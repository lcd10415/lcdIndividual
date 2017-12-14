//
//  extenions.swift
//  snakesdk
//
//  Created by tgame on 16/6/27.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns the md5 digest of the  `String`
    func md5()-> String {
        
        if self.characters.count == 0 {
            return ""
        }
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
    /// the `String` is a email or not
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) != nil
    }
    
    /// the `String` is a mobile no or not
    func isMobile() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$", options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) != nil
    }
    

    func trim() -> String
    {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    //base64转化
    func fromBase64() -> String
    {
        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        return String(data: data! as Data, encoding: String.Encoding.utf8)!
    }
    
    func toBase64() -> String
    {
        let data = self.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    //号码mask
    func maskedText() -> String {
        if self.characters.count > 6 {
            let index = self.index(self.endIndex, offsetBy: -3)
            let str1 = self.substring(from: index)
            let str2 = self.substring(to: self.index(self.startIndex, offsetBy: 3))
            return str2 + "*****" + str1
        }
            return ""
    }
    
    func hasNumerics() -> Bool {
        let regex = try! NSRegularExpression(pattern: "\\d", options: .caseInsensitive)
        return regex.generalTest(toBeTested: self) != nil
    }
    
    func hasCharacters() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Za-z]", options: .caseInsensitive)
        return regex.generalTest(toBeTested: self) != nil
    }
    
    func hasSpecials() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[^\\w]", options: .caseInsensitive)
        return regex.generalTest(toBeTested: self) != nil
    }
    
    func noWhiteSpaces() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[\\s]", options: .caseInsensitive)
        return regex.generalTest(toBeTested: self) == nil
    }
    
    //本地化
    var localized: String {
        get {
            return  Bundle.main.localizedString(forKey: self, value: "", table: "localization")
        }

    }
    
}
