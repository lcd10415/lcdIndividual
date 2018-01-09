//
//  ErrorHandle.swift
//  
//
//  Created by Liuchaodong on 2018/1/6.
//

import UIKit
//在swift中，错误均由遵循Error协议的类型的值表示

//继续向上抛出异常或错误。
//使用 do-catch 代码块。
//使用 try? 将返回值作为可选值处理。
//使用 try! 忽略错误直接强解包。
enum ErrorThrow: Error{
    case assdd
    case qwe
    case fedf
}
struct LCDError {
    func readFiles(path: String) throws ->  String {
        if path == "assdd" {
            throw ErrorThrow.assdd
        } else if path == "qwe" {
            throw ErrorThrow.qwe
        } else if path == "fedf" {
            throw ErrorThrow.fedf
        }
        return "Data from file"
    }
    
    func errorHandle() {
        do {
            let data = try? readFiles(path: "path for file")
        } catch ErrorThrow.assdd {
            print("assdd")
        } catch ErrorThrow.qwe {
            print("qwe")
        } catch ErrorThrow.fedf{
            print("fedf")
        }
    }
}
