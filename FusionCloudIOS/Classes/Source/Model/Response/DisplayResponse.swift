//
//  DisplayResponse.swift
//  FusionCloud
//
//  Created by Vanessa on 12/4/2023.
//

import Foundation
import ObjectMapper

public class DisplayResponse: Mappable, ResponseType {
    public var outputResultList: [OutputResult]?
    
    public required init?(map: Map) {}
    public func mapping(map: Map) {
        outputResultList <- map["OutputResult"]
    }
}
