//https://github.com/TakeScoop/SwiftyRSA
//
//  SwiftyRSA.swift
//  SwiftyRSA
//
//  Created by Loïs Di Qual on 7/2/15.
//  Copyright (c) 2015 Scoop Technologies, Inc. All rights reserved.


import Foundation
import Security


public class SnakeRSAError: NSError {
    init(message: String) {
        super.init(domain: "com.snakepop.snakesdk", code: 500, userInfo: [
            NSLocalizedDescriptionKey: message
            ])
    }
    
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


@objc
public class SnakeRSA: NSObject {
    
    @objc public enum DigestType: Int {
        case SHA1
        case SHA224
        case SHA256
        case SHA384
        case SHA512
    }
    
    private var keyTags: [NSData] = []
    public static let defaultPadding: SecPadding = .PKCS1
    private static var defaultDigest: DigestType = .SHA1
    
    // MARK: - Public Shorthands
    public static func encryptString(str: String, publicKeyDER: String, padding: SecPadding = defaultPadding) throws -> String {
        
        let pubKeyData = NSData(base64Encoded: publicKeyDER, options: .ignoreUnknownCharacters )!
        
        let rsa = SnakeRSA()
        let key = try rsa.publicKeyFromDERData(keyData: pubKeyData)
        return try rsa.encryptString(str: str, publicKey: key, padding: padding)
    }
    
    
    // MARK: - Public Advanced Methods
    
    public override init() {
        super.init()
    }
    
    public func publicKeyFromDERData(keyData: NSData) throws -> SecKey {
        return try addKey(keyData: keyData, isPublic: true)
    }
    
    /** The regular expression used to find public key armor */
    let publicKeyRegexp : NSRegularExpression? = {
        let publicKeyRegexp = "(-----BEGIN PUBLIC KEY-----.+?-----END PUBLIC KEY-----)"
        
        return try? NSRegularExpression(pattern: publicKeyRegexp, options: .dotMatchesLineSeparators)
    }()
    
    
    // Encrypts data with a RSA key
    public func encryptData(data: NSData, publicKey: SecKey, padding: SecPadding) throws -> NSData {
        let blockSize = SecKeyGetBlockSize(publicKey)
        let maxChunkSize = blockSize - 11
        
        var decryptedDataAsArray = [UInt8](repeating: 0, count: data.length / MemoryLayout<UInt8>.size)
        data.getBytes(&decryptedDataAsArray, length: data.length)
        
        var encryptedData = [UInt8](repeating: 0, count: 0)
        var idx = 0
        while (idx < decryptedDataAsArray.count) {
            
            let idxEnd = min(idx + maxChunkSize, decryptedDataAsArray.count)
            let chunkData = [UInt8](decryptedDataAsArray[idx..<idxEnd])
            
            var encryptedDataBuffer = [UInt8](repeating: 0, count: blockSize)
            var encryptedDataLength = blockSize
            
            let status = SecKeyEncrypt(publicKey, padding, chunkData, chunkData.count, &encryptedDataBuffer, &encryptedDataLength)
            
            guard status == noErr else {
                throw SnakeRSAError(message: "Couldn't encrypt chunk at index \(idx)")
            }
            
            encryptedData += encryptedDataBuffer
            
            idx += maxChunkSize
        }
        
        return NSData(bytes: encryptedData, length: encryptedData.count)
    }

    
    public func encryptString(str: String, publicKey: SecKey, padding: SecPadding = defaultPadding) throws -> String {
        guard let data = str.data(using: String.Encoding.utf8) else {
            throw SnakeRSAError(message: "Couldn't get UT8 data from provided string")
        }
        let encryptedData = try encryptData(data: data as NSData, publicKey: publicKey, padding: padding)
        return encryptedData.base64EncodedString(options: [])
    }
    

    // MARK: - Private
    
    private func addKey(keyData: NSData, isPublic: Bool) throws -> SecKey {
        
        var keyData = keyData
        
        // Strip key header if necessary
        if isPublic {
            try keyData = stripPublicKeyHeader(keyData: keyData)
        }
        
        let tag = NSUUID().uuidString
        let tagData = NSData(bytes: tag, length: tag.lengthOfBytes(using: String.Encoding.utf8))
        removeKeyWithTagData(tagData: tagData)
        
        // Add persistent version of the key to system keychain
        let persistKey = UnsafeMutablePointer<AnyObject?>(mutating: nil)
        let keyClass   = isPublic ? kSecAttrKeyClassPublic : kSecAttrKeyClassPrivate
        
        // Add persistent version of the key to system keychain
        let keyDict = NSMutableDictionary()
        keyDict.setObject(kSecClassKey,         forKey: kSecClass as! NSCopying)
        keyDict.setObject(tagData,              forKey: kSecAttrApplicationTag as! NSCopying)
        keyDict.setObject(kSecAttrKeyTypeRSA,   forKey: kSecAttrKeyType as! NSCopying)
        keyDict.setObject(keyData,              forKey: kSecValueData as! NSCopying)
        keyDict.setObject(keyClass,             forKey: kSecAttrKeyClass as! NSCopying)
        keyDict.setObject(NSNumber(value: true), forKey: kSecReturnPersistentRef as! NSCopying)
        keyDict.setObject(kSecAttrAccessibleWhenUnlocked, forKey: kSecAttrAccessible as! NSCopying)
        
        var secStatus = SecItemAdd(keyDict as CFDictionary, persistKey)
        if secStatus != noErr && secStatus != errSecDuplicateItem {
            throw SnakeRSAError(message: "Provided key couldn't be added to the keychain")
        }
        
        keyTags.append(tagData)
        
        // Now fetch the SecKeyRef version of the key
        var keyRef: AnyObject? = nil
        keyDict.removeObject(forKey: kSecValueData)
        keyDict.removeObject(forKey: kSecReturnPersistentRef)
        keyDict.setObject(NSNumber(value: true), forKey: kSecReturnRef as! NSCopying)
        keyDict.setObject(kSecAttrKeyTypeRSA,   forKey: kSecAttrKeyType as! NSCopying)
        secStatus = SecItemCopyMatching(keyDict as CFDictionary, &keyRef)
        
        guard let unwrappedKeyRef = keyRef else {
            throw SnakeRSAError(message: "Couldn't get key reference from the keychain")
        }
        
        return unwrappedKeyRef as! SecKey
    }
    
    
    /**
     This method strips the x509 from a provided ASN.1 DER public key.
     If the key doesn't contain a header, the DER data is returned as is.
     
     Supported formats are:
     
     Headerless:
     SEQUENCE
     INTEGER (1024 or 2048 bit) -- modulo
     INTEGER -- public exponent
     
     With x509 header:
     SEQUENCE
     SEQUENCE
     OBJECT IDENTIFIER 1.2.840.113549.1.1.1
     NULL
     BIT STRING
     SEQUENCE
     INTEGER (1024 or 2048 bit) -- modulo
     INTEGER -- public exponent
     
     Example of headerless key:
     https://lapo.it/asn1js/#3082010A0282010100C1A0DFA367FBC2A5FD6ED5A071E02A4B0617E19C6B5AD11BB61192E78D212F10A7620084A3CED660894134D4E475BAD7786FA1D40878683FD1B7A1AD9C0542B7A666457A270159DAC40CE25B2EAE7CCD807D31AE725CA394F90FBB5C5BA500545B99C545A9FE08EFF00A5F23457633E1DB84ED5E908EF748A90F8DFCCAFF319CB0334705EA012AF15AA090D17A9330159C9AFC9275C610BB9B7C61317876DC7386C723885C100F774C19830F475AD1E9A9925F9CA9A69CE0181A214DF2EB75FD13E6A546B8C8ED699E33A8521242B7E42711066AEC22D25DD45D56F94D3170D6F2C25164D2DACED31C73963BA885ADCB706F40866B8266433ED5161DC50E4B3B0203010001
     
     Example of key with X509 header (notice the additional ASN.1 sequence):
     https://lapo.it/asn1js/#30819F300D06092A864886F70D010101050003818D0030818902818100D0674615A252ED3D75D2A3073A0A8A445F3188FD3BEB8BA8584F7299E391BDEC3427F287327414174997D147DD8CA62647427D73C9DA5504E0A3EED5274A1D50A1237D688486FADB8B82061675ABFA5E55B624095DB8790C6DBCAE83D6A8588C9A6635D7CF257ED1EDE18F04217D37908FD0CBB86B2C58D5F762E6207FF7B92D0203010001
     */
    private func stripPublicKeyHeader(keyData: NSData) throws -> NSData {
        let count = keyData.length / MemoryLayout<CUnsignedChar>.size
        
        guard count > 0 else {
            throw SnakeRSAError(message: "Provided public key is empty")
        }
        
        var byteArray = [UInt8](repeating: 0, count: count)
        keyData.getBytes(&byteArray, length: keyData.length)
        
        var index = 0
        guard byteArray[index] == 0x30 else {
            throw SnakeRSAError(message: "Provided key doesn't have a valid ASN.1 structure (first byte should be 0x30 == SEQUENCE)")
        }
        
        index += 1
        if byteArray[index] > 0x80 {
            index += Int(byteArray[index]) - 0x80 + 1
        }
        else {
            index += 1
        }
        
        // If current byte marks an integer (0x02), it means the key doesn't have a X509 header and just
        // contains its modulo & public exponent. In this case, we can just return the provided DER data as is.
        if Int(byteArray[index]) == 0x02 {
            return keyData
        }
        
        // Now that we've excluded the possibility of headerless key, we're looking for a valid X509 header sequence.
        // It should look like this:
        // 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00
        guard Int(byteArray[index]) == 0x30 else {
            throw SnakeRSAError(message: "Provided key doesn't have a valid X509 header")
        }
        
        index += 15
        if byteArray[index] != 0x03 {
            throw SnakeRSAError(message: "Invalid byte at index \(index - 1) (\(byteArray[index - 1])) for public key header")
        }
        
        index += 1
        if byteArray[index] > 0x80 {
            index += Int(byteArray[index]) - 0x80 + 1
        }
        else {
            index += 1
        }
        
        guard byteArray[index] == 0 else {
            throw SnakeRSAError(message: "Invalid byte at index \(index - 1) (\(byteArray[index - 1])) for public key header")
        }
        
        index += 1
        
        let strippedKeyBytes = [UInt8](byteArray[index...keyData.length - 1])
        let data = NSData(bytes: strippedKeyBytes, length: keyData.length - index)
        
        return data
    }
    
    private func removeKeyWithTagData(tagData: NSData) {
        let publicKey = NSMutableDictionary()
        publicKey.setObject(kSecClassKey,       forKey: kSecClass as! NSCopying)
        publicKey.setObject(kSecAttrKeyTypeRSA, forKey: kSecAttrKeyType as! NSCopying)
        publicKey.setObject(tagData,            forKey: kSecAttrApplicationTag as! NSCopying)
        SecItemDelete(publicKey as CFDictionary)
    }
    
    
    deinit {
        for tagData in keyTags {
            removeKeyWithTagData(tagData: tagData)
        }
    }
}
