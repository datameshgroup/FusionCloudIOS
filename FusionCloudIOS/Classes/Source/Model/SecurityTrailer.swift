//
//  SecurityTrailer.swift
//  TestApplication
//
//  Created by loey on 1/30/22.
//  Copyright © 2022 loey. All rights reserved.
//

import Foundation
import ObjectMapper

public class SecurityTrailer: Mappable{
    
    public var contentType: String?
    public var authenticationData: AuthenticationData?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        contentType         <- map["ContentType"]
        authenticationData  <- map["AuthenticatedData"]
    }
    
}

public class AuthenticationData: Mappable {
    
    public var version: String?
    public var recipient: Recipient?
    public required init(){}
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
         version    <- map["AuthenticatedData"]
         recipient  <- map["Recipient"]
    }
}


public class Recipient: Mappable {
    public var mac: String?
    public var kek: KEK?
    public var macAlgorithm: MACAlgorithm?
    public var encapContent: EncapsulatedContent?
    
    public required init(){}
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        mac             <- map["MAC"]
        kek             <- map["KEK"]
        macAlgorithm    <- map["MACAlgorithm"]
        encapContent    <- map["EncapsulatedContent"]
    }
}

//Security Data ===============================

public class KEK : Mappable{
    
    public var version:String?
    public var encryptedKey: String?
    public var kekIdentifier: KEKIdentifier?
    public var kekAlgorithm: KeyEncryptionAlgorithm?
    
    public func mapping(map: Map) {
        version         <- map["Version"]
        encryptedKey    <- map["EncryptedKey"]
        kekIdentifier   <- map["KEKIdentifier"]
        kekAlgorithm    <- map["KeyEncryptionAlgorithm"]
    }
    
    public required init?(map: Map) {}
    public required init(){}
}


public class KEKIdentifier: Mappable{
    
    public var keyIdentifier: String?
    public var keyVersion: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        keyVersion      <- map["KeyVersion"]
        keyIdentifier  <- map["KeyIdentifier"]
    }
}

public class KeyEncryptionAlgorithm: Mappable{
    
    public var algorithm: String?
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        algorithm   <- map["Algorithm"]
    }
}


//Security Data ===============================

public class MACAlgorithm : Mappable {
    public var algorithm: String?
    public func mapping(map: Map) {
        algorithm   <- map["Algorithm"]
    }
    public required init?(map: Map) {}
    public required init(){}
}

//Security Data ===============================

public class EncapsulatedContent : Mappable{
    
    public var contentType: String?
    
    public func mapping(map: Map) {
        contentType     <-  map["ContentType"]
    }
    
    public required init?(map: Map) {}
    public required init(){}
}
