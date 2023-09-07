//
//  DisplayRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 4/20/22.
//

import Foundation
import ObjectMapper



public class DisplayRequest: Mappable, Request {
    public var displayOutput: DisplayOutput?
    
    public func mapping(map: Map) {
        displayOutput    <-  map["DisplayOutput"]
    }
    
    public required init?(map: Map) {}
    public required init(){}
    
    
    /// Get a plain text version of the display intended for the cashier UI dialog, or nil if no such display exists
    public func getCashierDisplayAsPlainText() -> String? {
        
        var result = displayOutput?.outputContent?.outputText?.text ?? ""
        
        if(result == "") {
            return nil
        }
        
        // Some responses will bve formatted as SHORT TEXT | FULL TEXT
        var index = result.firstIndex(of: "|")
        if(index != nil) {
            index = result.index(index!, offsetBy: 2)
            result = result[index!...].trimmingCharacters(in: [" "])
        }
        return result
    }
}

public class DisplayOutput: Mappable {
    
    public var responseRequiredFlag: Bool?
    public var device: String?
    public var infoQuality: String?
    public var outputContent: OutputContent?
    
    public func mapping(map: Map) {
        responseRequiredFlag    <-  map["ResponseRequiredFlag"]
        device          <-  map["Device"]
        infoQuality     <-  map["InfoQuality"]
        outputContent   <-  map["OutputContent"]
    }
    public required init?(map: Map) {}
    public required init(){}
}

    public class OutputContent: Mappable {
        
        /// MessageRef, Text, XHTML, Barcode
        public var outputFormat: String?
        public var outputText: OutputText?
        public var outputXHTML: String?
        
        public func mapping(map: Map) {
            outputFormat    <-  map["OutputFormat"]
            outputText      <-  map["OutputText"]
            outputXHTML     <-  map["OutputXHTML"]
        }
        
        public required init?(map: Map) {}
        public required init(){}
        
        ///TODO:
        ///public func GetContentAsPlainText() -> STring  {}
        ///
    }

        public class OutputText: Mappable {
            public var text: String?
            
            public func mapping(map: Map) {
                text    <-  map["Text"]
            }
            
            public required init?(map: Map) {}
            public required init(){}
        }



