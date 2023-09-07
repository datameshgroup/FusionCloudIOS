//
//  CustomField.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class CustomField: Mappable {
    public var key: String?
    public var type: String?
    public var value: String?
    
    public required init?(map: Map) {}
    public required init() {}
    
    public func mapping(map: Map) {
        key     <- map["Key"]
        type    <- map["Type"]
        value   <- map["Value"]
    }
}
