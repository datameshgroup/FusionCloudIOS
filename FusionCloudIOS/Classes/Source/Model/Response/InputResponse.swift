//
//  InputResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper



public class InputResponse: Mappable, ResponseType {
    
    var outputResult: OutputResult?
    var inputResult: InputResult?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        outputResult    <-  map["OutputResult"]
        inputResult     <-  map["InputResult"]
    }
}


public class OutputResult: Mappable {
    
    var device: String?
    var infoQualify: InfoQualify?
    var result: String?
    var errorCondition: String?
    var additionalReponse: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        device              <-  map["Device"]
        infoQualify         <-  map["InfoQualify"]
        result              <-  map["Result"]
        errorCondition      <-  map["ErrorCondition"]
        additionalReponse   <-  map["AdditionalResponse"]
    }
}

public class InputResult: Mappable {
    
    var device: String?
    var infoQuality: String?
    var response: Response?
    var input: Input?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        device          <-  map["Device"]
        infoQuality     <-  map["InfoQualify"]
        response        <-  map["Response"]
        input           <-  map["Input"]
    }
}

public class Input : Mappable {
    
    public var inputCommand: String?
    public var confirmedFlag: String?
    public var password: String?
    public var menuEntryNumber: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
       inputCommand     <-  map["InputCommand"]
       confirmedFlag    <-  map["ConfirmedFlag"]
       password         <-  map["Password"]
       menuEntryNumber  <- map["MenuEntryNumber"]
    }
}
