//
//  Response.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class Response : Mappable {
    public var result: ResponseResult?
    public var errorCondition: ErrorCondition?
    public var additionalResponse: String?
    

    public func mapping(map: Map) {
        result              <-  map["Result"]
        errorCondition      <-  map["ErrorCondition"]
        additionalResponse  <-  map["AdditionalResponse"]
    }
    
    public func isSuccess() -> Bool {
        let r = result
        return (r == .Success)
    }
    
    public required init?(map: Map) {}
    public required init(){}
}
