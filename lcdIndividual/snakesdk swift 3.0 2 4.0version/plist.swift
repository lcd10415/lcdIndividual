//  EasyHelper
//  Swift 2.0
//  Created by DaRk-_-D0G on 24/07/2015.
//  Copyright (c) 2015 DaRk-_-D0G. All rights reserved.
//
import Foundation

/// Error enum
enum EHError: Error {
    case Nil(String)
    case NSData(String)
    case JSON(String)
}
// MARK: - Dictionary File
extension Dictionary {
    /**
     Loads a JSON file from the app bundle into a new dictionary
     
     - parameter filename: File name
     
     - throws: EHError : PathForResource / NSData / JSON
     
     - returns: Dictionary<String, AnyObject>
     */
    static func loadJSONFromBundle(filename: String) throws ->  Dictionary<String, AnyObject> {
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "json")  else {
            throw EHError.Nil("[EasyHelper][loadJSONFromBundle][->pathForResource] The file could not be located\nFile : '\(filename).json'")
        }
        
        guard let data = try? NSData(contentsOfFile: path, options:.uncached)   else {
            throw EHError.NSData("[EasyHelper][loadJSONFromBundle][->NSData] The absolute path of the file not find\nFile : '\(filename)'")
        }
        
        guard let jsonDict = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? Dictionary<String, AnyObject> else {
            throw EHError.JSON("[EasyHelper][loadJSONFromBundle][->NSJSONSerialization]Error.InvalidJSON Level file '\(filename)' is not valid JSON")
        }
        
        return jsonDict
        
    }
    
    /**
     Load a Plist file from the app bundle into a new dictionary
     
     :param: File name
     :return: Dictionary<String, AnyObject>?
     */
    /**
     Load a Plist file from the app bundle into a new dictionary
     
     - parameter filename: File name
     
     - throws: EHError : Nil
     
     - returns: Dictionary<String, AnyObject>
     */
    static func loadPlistFromBundle(filename: String) throws -> Dictionary<String, AnyObject> {
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist")  else {
            throw EHError.Nil("[EasyHelper][loadPlistFromBundle] (pathForResource) The file could not be located\nFile : '\(filename).plist'")
        }
        guard let plistDict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> else {
            throw EHError.Nil("[EasyHelper][loadPlistFromBundle] (NSDictionary) There is a file error or if the contents of the file are an invalid representation of a dictionary. File : '\(filename)'.plist")
        }
        
        return plistDict
    }
}
// MARK: - Array File
public extension Array {
    /**
     Loads a JSON file from the app bundle into a new dictionary
     
     - parameter filename: File name
     
     - throws: EHError : PathForResource / NSData / JSON
     
     - returns: [String : AnyObject]
     */
    static func loadJSONFromBundle(filename: String, nameJson:String) throws ->  [String : AnyObject] {
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "json")  else {
            throw EHError.Nil("[EasyHelper][loadJSONFromBundle][->pathForResource] The file could not be located\nFile : '\(filename).json'")
        }
        
        guard let data = try? NSData(contentsOfFile: path, options:.uncached)   else {
            throw EHError.NSData("[EasyHelper][loadJSONFromBundle][->NSData] The absolute path of the file not find\nFile : '\(filename)'")
        }
        
        guard let jsonDict = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [String : AnyObject] else {
            throw EHError.JSON("[EasyHelper][loadJSONFromBundle][->NSJSONSerialization] Invalid JSON\n nameJson '\(nameJson)'\nFile '\(filename)'")
        }
        
        return jsonDict
        
    }
    
    /**
     Load a Plist file from the app bundle into a new dictionary
     
     :param: File name
     :return: Dictionary<String, AnyObject>?
     */
    /**
     Load a Plist file from the app bundle into a new dictionary
     
     - parameter filename: File name
     
     - throws: EHError : Nil
     
     - returns: [String : AnyObject]
     */
    static func loadPlistFromBundle(filename: String) throws -> [String : AnyObject] {
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist")  else {
            throw EHError.Nil("[EasyHelper][loadPlistFromBundle] (pathForResource) The file could not be located\nFile : '\(filename).plist'")
        }
        guard let plistDict = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else {
            throw EHError.Nil("[EasyHelper][loadPlistFromBundle] (NSDictionary) There is a file error or if the contents of the file are an invalid representation of a dictionary. File : '\(filename)'.plist")
        }
        
        return plistDict
    }
}
