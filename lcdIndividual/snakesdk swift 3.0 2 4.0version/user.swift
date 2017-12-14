//
//  store.swift
//  snakesdk
//
//  Created by tgame on 16/6/30.
//  Copyright © 2016年 snakepop. All rights reserved.
//


//持久存储
class Store {
    private var _db: Database!


    static let sharedInstance = Store()
    
    //todo: failble ?
    private init() {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true
            ).first!

        do {
            let absPath  = "\(dirPath)/snakepop.sqlite3"
            _db = try Database.open(path: absPath)
            
            try _db.createTable(table: User.self)
            

        }catch let err {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "store",
                "action": "init",
                "error":  err])
        }
    
    }
    
    //查找指定用户
    func user(account: String)-> User? {
    
        do {
            let u = try _db.user(account: account)
            return u
        }
        catch {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "store",
                "action": "user",
                "account":  account,
                "error": error])
            
        }
        return nil
    }
    
    //查找指定用户
    func userWithID(id: Int)-> User? {
        
        do {
            let u = try _db.userWithId(id: id)
            return u
        }
        catch {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "store",
                "action": "userWithID",
                "id":  id,
                "error": error])
            
        }
        return nil
    }
    
    
    //查找所有用户
    func users()-> [User]? {
        
        do {
            let users = try _db.users()
            return users
        }
        catch {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "store",
                "action": "users",
                "error": error])
        }
        return nil
    }
    
    //用户数
    func count() -> Int32 {
        return _db.count()
    }
    
    //删除用户
    func deleteUser(id: Int) -> Bool {
        do {
            try _db.deleteUser(id: id)
            SnakeLogger.sharedInstance.event(dictionary: [
                "component": "store",
                "action": "deleteUser",
                "id":  id,
                ])
            
            return true
            
         }
        catch {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "store",
                "action": "deleteUser",
                "id":  id,
                "error": error])
            
        }
        return false
        
    }
    

    //新加或更新用户
    func addOrUpdateUser(old: String, new: String = "",  key: String = "", type: Int = 0 ) -> Error? {
        do {
            
            guard let u = try? _db.user(account: old) else {
                try _db.addUser(account: old, key: key, type: type)
                
                SnakeLogger.sharedInstance.event(dictionary: [
                    "component": "store",
                    "action": "addUser",
                    "account": old,
                    "key": key,
                    "type": type])
                
                return nil
            }
            
            if new != "" {
                u!.account = new
            }
            
            
            if key != "" {
                u!.key = key
            }
            
            if type != 0 {
                u!.type = type
            }
            
            try _db.updateUser(new: u!)
            
            SnakeLogger.sharedInstance.event(dictionary: [
                "component": "store",
                "action": "updateUser",
                "old": old,
                "new": new,
                "key": key,
                "type": type])
            
            return nil
            
            
        }catch let error {

            //print(NSThread.callStackSymbols())
            
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "store",
                "action": "addOrUpdateUser",
                "error":  error])
            return error
            
        }
        
    }
    
    

}



extension User: SQLTable {
    static var createStatement: String {
        return "CREATE TABLE IF NOT EXISTS user(" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT ," +
            "account VARCHAR(255)," +
            "key VARCHAR(255)," +
            "type TINYINT(255)," +
            "login_at INTEGER" +
        ");"
    }
}


extension Database {
    func createTable(table: SQLTable.Type) throws {
        
        let createTableStmt = try prepareStatement(sql: table.createStatement)
        defer {
            sqlite3_finalize(createTableStmt)
        }
        
        guard sqlite3_step(createTableStmt) == SQLITE_DONE else {
            throw DBError.Step(message: errorMessage)
        }
        
    }
    
    
    //查找指定user
    func user(account: String) throws -> User? {
        let querySql = "SELECT * FROM user WHERE account = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        guard sqlite3_bind_text(queryStatement, 1, NSString(string: account).utf8String, -1, nil) == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
             throw DBError.Step(message: errorMessage)
        }
        
        let id = sqlite3_column_int(queryStatement, 0)
        
        let accountCol = sqlite3_column_text(queryStatement, 1)
        let account = String(cString: accountCol!)
        
        let keyCol = sqlite3_column_text(queryStatement, 2)
        let key = String(cString: keyCol!)
        
        let type = sqlite3_column_int(queryStatement, 3)
        
        let loginAt = sqlite3_column_int(queryStatement, 4)
        
        return User(id: Int64(id), type: Int(type), account: account, key: key, loginAt: Int64(loginAt))
    }
    
    
    func userWithId(id: Int) throws -> User? {
        let querySql = "SELECT * FROM user WHERE id = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        guard sqlite3_bind_int(queryStatement, 1, Int32(id)) == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            throw DBError.Step(message: errorMessage)
        }
        
        let id = sqlite3_column_int(queryStatement, 0)
        
        let accountCol = sqlite3_column_text(queryStatement, 1)
//        http://stackoverflow.com/questions/25168030/issue-with-unsafepointeruint8-in-sqlite-project-in-swift
        let account = String(cString: accountCol!)
        
        let keyCol = sqlite3_column_text(queryStatement, 2)
        let key = String(cString: keyCol!)
        
        let type = sqlite3_column_int(queryStatement, 3)
        
        let loginAt = sqlite3_column_int(queryStatement, 4)
        
        return User(id: Int64(id), type: Int(type), account: account, key: key, loginAt: Int64(loginAt))
    }
    
    //查找所有user
    func users() throws -> [User]? {
        let querySql = "SELECT * FROM user;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        var users = [User]()
        
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            
            let id = sqlite3_column_int(queryStatement, 0)
            
            let accountCol = sqlite3_column_text(queryStatement, 1)
            let account = String(cString: accountCol!)
            
            let keyCol = sqlite3_column_text(queryStatement, 2)
            let key = String(cString: keyCol!)
            
            let type = sqlite3_column_int(queryStatement, 3)
            
            let loginAt = sqlite3_column_int(queryStatement, 4)
            
            let u = User(id: Int64(id), type: Int(type), account: account, key: key, loginAt: Int64(loginAt))
            users.append(u)
            
        }
        
        return users
    }

    
    //用户数
    func count() -> Int32 {
        let querySql = "SELECT count(*) FROM user;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return 0
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return 0
        }
        
        let count = sqlite3_column_int(queryStatement, 0)
        
        return count
        
    }

    
    //删除用户
    func deleteUser(id: Int) throws {
        
        let delSql = "DELETE FROM user WHERE id = ?;"
        guard let delStatement = try? prepareStatement(sql: delSql) else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        defer {
            sqlite3_finalize(delStatement)
        }
        guard sqlite3_bind_int(delStatement, 1, Int32(id)) == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }

        
        guard sqlite3_step(delStatement) == SQLITE_DONE  else {
             throw DBError.Step(message: errorMessage)
        }


    }


    //添加一个用户
    func addUser(account: String, key: String, type: Int ) throws{
        
        let insertSql = "INSERT INTO user (account, key, type, login_at) VALUES (?, ?, ?, ?);"
        
        guard let insertStatement = try? prepareStatement(sql: insertSql) else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        
        guard sqlite3_bind_text(insertStatement, 1, NSString(string:account).utf8String, -1, nil) == SQLITE_OK else {
             throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_bind_text(insertStatement, 2, NSString(string:key).utf8String, -1, nil)  == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }

        guard sqlite3_bind_int(insertStatement, 3, Int32(type))  == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }

        guard sqlite3_bind_int(insertStatement, 4, Int32(Utils.unixTime))  == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }

        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw DBError.Step(message: errorMessage)
        }

        sqlite3_reset(insertStatement)
        
    }
    


    //更新用户
    func updateUser(new :User) throws {
        
//      let insertSql = "INSERT OR REPLACE INTO user (id, account, key, type, login_at) VALUES (?, ?, ?, ?, ?);"
        
        let updateSql = "UPDATE user SET account = ?, key = ?, type = ?, login_at = ? WHERE id = ?;"
        
        guard let updateStatement = try? prepareStatement(sql: updateSql) else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        defer {
            sqlite3_finalize(updateStatement)
        }
        
        guard sqlite3_bind_text(updateStatement, 1, NSString(string:new.account).utf8String, -1, nil) == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_bind_text(updateStatement, 2, NSString(string:new.key).utf8String, -1, nil)  == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_bind_int(updateStatement, 3, Int32(new.type))  == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_bind_int(updateStatement, 4, Int32(Utils.unixTime))  == SQLITE_OK else {
            throw DBError.Bind(message: errorMessage)
        }
        
        guard sqlite3_step(updateStatement) == SQLITE_DONE else {
            throw DBError.Step(message: errorMessage)
        }
        
        sqlite3_reset(updateStatement)
        
    }
    
   
    
}

