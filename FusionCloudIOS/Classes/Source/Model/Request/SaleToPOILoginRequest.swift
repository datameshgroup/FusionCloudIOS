//
//  SaleToPOILoginRequest.swift
//  TestApplication
//
//  Created by loey on 2/6/22.
//  Copyright © 2022 loey. All rights reserved.
//

import Foundation
import ObjectMapper

public class SaleToPOILoginRequest: Mappable {
    public var saleToPOIRequest: SaleToPOIRequest?
    public required init?(map: Map) {}
    
    public required init(){
        
    }
      
    public func mapping(map: Map) {
          saleToPOIRequest <- map["SaleToPOIRequest"]
    }
}
