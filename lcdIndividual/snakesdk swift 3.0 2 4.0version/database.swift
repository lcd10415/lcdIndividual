//
//  sqlite.swift
//  testSQLite
//
//  Created by tgame on 16/8/15.
//  Copyright © 2016年 snakepop. All rights reserved.
//

//https://github.com/3aaap/DZHandleDB/blob/master/DZHandleDB/DZHandleDB/DZSQLiteManager/DZSQLiteManager.swift
import Foundation

enum DBError: Error {
    case Open(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
}

class Database {
    let dbPointer: OpaquePointer
    
    private init(dbPointer: OpaquePointer) {
        self.dbPointer = dbPointer
    }
    
    static func open(path: String) throws -> Database {
        var db: OpaquePointer? = nil
        if sqlite3_open(path, &db) == SQLITE_OK {
            return Database(dbPointer: db!)
            
        } else {
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            
            if let message = String(cString: sqlite3_errmsg(db)!) as? String {
                throw DBError.Open(message: message)
                
            } else {
                throw DBError.Open(message: "No error message provided from sqlite.")
            }
        }
    }
    
    internal var errorMessage: String {
        if let errorMessage = String(cString: sqlite3_errmsg(dbPointer)!) as? String {
            return errorMessage
            
        } else {
            return "No error message provided from sqlite."
        }
    }
    
    deinit {
        sqlite3_close(dbPointer)
    }
}

extension Database {
    func prepareStatement(sql: String) throws -> OpaquePointer {
        var stmt: OpaquePointer? = nil
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &stmt, nil) == SQLITE_OK else {
            throw DBError.Prepare(message: errorMessage)
        }
        
        return stmt!
    }
    
}

protocol SQLTable {
    static var createStatement: String { get }
}

