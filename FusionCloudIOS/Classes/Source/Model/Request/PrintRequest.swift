//
//  PrintRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 5/8/22.
//

import Foundation
import ObjectMapper

public class PrintRequest: Mappable, Request {
    
    public var printOutput: PrintOuput?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        printOutput     <-  map["PrintOutput"]
    }
    
}

public class PrintOuput: Mappable {
    
    public var documentQualifier: String?
    public var integratedPrintFlag: Bool?
    public var requiredSignatureFlag: Bool?
    public var outputContent: OutputContent?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        documentQualifier   <-  map["DocumentQualifier"]
        integratedPrintFlag <-  map["IntegratedPrintFlag"]
        requiredSignatureFlag   <-  map["RequiredSignatureFlag"]
        outputContent       <-  map["OutputContent"]
    }
}


