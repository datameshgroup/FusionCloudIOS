//
//  InputRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 5/7/22.
//

import Foundation
import ObjectMapper

/* Request */

public class InputRequest : Mappable, Request {
    
    var menuEntry:[Menu]?
    var displayOutput: DisplayOutput?
    var inputData: InputData?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        menuEntry       <-  map["MenuEntry"]
        displayOutput   <-  map["DisplayOutput"]
    }
}

public class InputData : Mappable {
    
    var device: String?
    var infoQualify: InfoQualify?
    var inputCommand: InputCommand?
    var maxInputTime: String?
    var minLength: String?
    var maxLength: String?
    var maskCharactersFlag: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        device          <-  map["Device"]
        infoQualify     <-  map["InfoQualify"]
        inputCommand    <-  map["InputCommand"]
        maxInputTime    <-  map["MaxInputTime"]
        minLength       <-  map["MinLength"]
        maxLength       <-  map["MaxLength"]
        maskCharactersFlag    <-  map["MaskCharactersFlag"]
    }
}

public class Menu: Mappable {
    
    var outputFormat:String?
    var outputText: OutputText?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        outputFormat        <-  map["OutputFormat"]
        outputText          <-  map["OutputText"]
    }
}

/* Input Response */

