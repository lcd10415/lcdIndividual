//
//  result.swift
//  snakesdk
//
//  Created by tgame on 16/8/11.
//  Copyright © 2016年 snakepop. All rights reserved.
//

//https://segmentfault.com/a/1190000004442872 !!!
//http://ju.outofmemory.cn/entry/244351
//http://www.stefanovettor.com/2015/10/31/swift-map-flatmap/
//http://www.swiftcafe.io/2016/03/28/about-map/
public enum Result<T> {
    case Success(T)
    case Failure(Error)
}

extension Result {
    func map<U>(f: (T)->U) -> Result<U> {
        switch self {
        case .Success(let t):
            return .Success(f(t))
            
        case .Failure(let err):
            return .Failure(err)

        }
    }
    
    func flatMap<U>(f: (T)->Result<U>) -> Result<U> {
        switch self {
        case .Success(let t):
            return f(t)
            
        case .Failure(let err):
            return .Failure(err)
            
        }
    }
    
    func resolve() throws -> T {
        switch  self  {
        case Result.Success(let value):
            return value
        
        case Result.Failure(let error):
            throw error
        }
        
    }
    
    init ( _ throwingExpr: @escaping () throws -> T) {
        
        do {
            let value = try throwingExpr()
            self = Result.Success(value)
        
        }catch {
            self = Result.Failure(error )
        }
    }
}
