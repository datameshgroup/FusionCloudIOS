//
//  ReconcillationRequest.swift
//  TestAppDM
//
//  Created by Loey Agdan on 5/8/22.
//

import Foundation
import ObjectMapper

public class ReconcillationRequest: Mappable, Request {
    
    var reconciliationType: String?
    var poiReconciliationID: String?
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        reconciliationType           <-      map["ReconciliationType"]
        poiReconciliationID          <-      map["POIReconciliationID"]
    }
}


