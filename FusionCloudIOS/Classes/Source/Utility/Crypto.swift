//
//  Crypto.swift
//  TestApplication
//
//  Created by loey on 2/12/22.
//  Copyright © 2022 loey. All rights reserved.
//

import Foundation
import CommonCrypto
import IDZSwiftCommonCrypto
import ObjectMapper

public class Crypto {
    
    public init(){}
    
    public func buildRequest<T: Mappable>(kek: String, request: T,header: MessageHeader, security: SecurityTrailer, type: String) -> String{
        
        //print("request => \(request)")
        let requestBody = buildRequestBody(request: request, header: header, requestType: type)
        let saleToPOIRequest = "{\"SaleToPOIRequest\":{ \(requestBody),\(buildSecurityTrailer(kek: kek, request: requestBody.replacingOccurrences(of: "\\/", with: "/"), security: security))}"
    
        return saleToPOIRequest
    }
    
    public func buildRequestBody<T: Mappable>(request: T, header: MessageHeader, requestType: String)->String {
        return "\"MessageHeader\":\(header.toJSONString()!),\"\(requestType)\":\(request.toJSONString()!)"
    }
    
    
    public func buildSecurityTrailer(kek: String, request: String, security:SecurityTrailer)->String{
        let key = self.generate16ByteKey()
        let encryptedKey = self.generateEncryptedKey(randomKey: key, KEK: kek)
        
        //print("inside request => \(request) end request")
        
        /** Part of loginRequest */
        let encryptedString = hexString(fromArray: encryptedKey, uppercase: true)
        let hexKey = hexString(fromArray: key, uppercase: false)
        //print("(build)data=> \(request) , hexKey \(hexKey)")
        let MAC = generateMAC(macBody: request, hexKey: hexKey)
        
            
        security.authenticationData?.recipient?.kek?.encryptedKey = encryptedString
        security.authenticationData?.recipient?.mac = MAC
        return "\"SecurityTrailer\":\(security.toJSONString(prettyPrint: true)!)}"
    }
    
    public func generateMAC(macBody: String, hexKey: String)-> String {
        let hashResult = getSha256(s: macBody)
        let hashAppendBytes = append8Bytes(h: hashResult)
        let encrypt = crypt(value: hashAppendBytes, key: hexKey)
        let last8Bytes = getLast8Bytes(encrypt: encrypt)
        _ = String(bytes: last8Bytes, encoding: String.Encoding.utf8)
        return hexString(fromArray: last8Bytes, uppercase: true)
    }
    
    public func generate16ByteKey()->[UInt8]{
        var bytes = [UInt8](repeating: 0, count: 16)
        let byteKey = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        if byteKey == errSecSuccess {
            //print("16 byte key generated...")
        }
        return bytes
    }
    
    public func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    public func generateEncryptedKey(randomKey: [UInt8], KEK: String )-> [UInt8]{
        crypt(value: randomKey, key: KEK)
    }
    
    public func extractEncryptedKey(encryptedKey: [UInt8], kek: String)-> [UInt8]{
        decrypt(value: encryptedKey, key: kek)
    }
    
    public func crypt(value: [UInt8], key: String)-> [UInt8]{
        
        var keyBytes:[UInt8]? = arrayFrom(hexString: key)
        if(keyBytes!.count == 16){
            var tempKey = [UInt8](repeating: 0, count: 24)
            tempKey[0...15] = (keyBytes![0...15])
            tempKey[16...23] = (keyBytes![0...7])
            keyBytes = tempKey
        }
        
        var iv = [UInt8]()
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        
        let cryptor = Cryptor(operation: StreamCryptor.Operation.encrypt, algorithm: StreamCryptor.Algorithm.tripleDES, mode: StreamCryptor.Mode.CBC, padding: .NoPadding, key: keyBytes!, iv: iv).update(value)?.final()

        return cryptor!
    }
    
    public func decrypt(value: [UInt8], key: String)-> [UInt8]{
        
        var keyBytes:[UInt8]? = arrayFrom(hexString: key)
        
        if(keyBytes!.count == 16){
            var tempKey = [UInt8](repeating: 0, count: 24)
            tempKey[0...15] = (keyBytes![0...15])
            tempKey[16...23] = (keyBytes![0...7])
            keyBytes = tempKey
        }
        
        var iv = [UInt8]()
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        iv.append(UInt8(0))
        
        let cryptor = Cryptor(operation: StreamCryptor.Operation.decrypt, algorithm: StreamCryptor.Algorithm.tripleDES, mode: StreamCryptor.Mode.CBC, padding: .NoPadding, key: keyBytes!, iv: iv).update(value)?.final()
        
        return cryptor!
    }
    
    public func append8Bytes(h :[UInt8])-> [UInt8]{
        
        var resultArray = [UInt8](repeating: UInt8(0), count: 40)
        resultArray[0...31] = h[0...31]
        resultArray[32] = UInt8(128)
        return resultArray  //[UInt8](hashData)
    }
    
    public func getLast8Bytes(encrypt: [UInt8])-> [UInt8]{
        let byte8Value = [UInt8](encrypt[32...39])
        return byte8Value
    }
    
    public func getSha256(s: String)->[UInt8]{
        let sha = Digest(algorithm: .sha256).update(arrayFrom(string: s))?.final()
        return sha!
    }
    
    

    public func validateSecurityTrailer(
            securityTrailer: SecurityTrailer,
            kek: String,
            raw: String)throws{
                let macBody = getRawMacBody(jsonRaw: raw)
                //print("mac \(macBody)")
                let encryptedKey = securityTrailer.authenticationData?.recipient?.kek?.encryptedKey?.lowercased()
                let encryptedKeyBytes = arrayFrom(hexString: encryptedKey!)
                let key = self.extractEncryptedKey(encryptedKey: encryptedKeyBytes, kek: kek)
                let hexKey = hexString(fromArray: key, uppercase: false)
                let mac = generateMAC(macBody: macBody, hexKey: hexKey)
                
                if mac != securityTrailer.authenticationData?.recipient?.mac {
                    throw MacValidation.runtimeError("Security Exception: MAC Don't match!")
                }
    }
    
    public func getRawMacBody(jsonRaw: String)-> String{
        let end = ",\"SecurityTrailer\""
        var start = "{\"SaleToPOIResponse\":{"
        
        if jsonRaw.contains("SaleToPOIRequest"){
            start = "{\"SaleToPOIRequest\":{"
        }
        
        let first = jsonRaw.components(separatedBy: end).first?.replacingOccurrences(of: start, with: "")
        return first!
    }
}


public enum MacValidation: Error {
    case runtimeError(String)
}
