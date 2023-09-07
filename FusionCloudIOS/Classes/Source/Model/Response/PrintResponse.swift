//
//  PrintResponse.swift
//  FusionCloud
//
//  Created by Loey Agdan on 5/30/22.
//

import Foundation
import ObjectMapper


public class PrintResponse: Mappable, ResponseType {
    
    public var documentQuaifier: String?
    public var response: Response?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        documentQuaifier    <-  map["DocumentQualifier"]
        response            <-  map["Response"]
    }
    
}
