//
//  PairingData.swift
//  FusionCloudIOS
//
//  Created by Vanessa on 11/9/2023.
//

import Foundation
import ObjectMapper

public class PairingData: Mappable {
    
    public var saleID: String?
    public var pairingPOIID: String?
    public var kek: String?
    public var cerificationCode: String?
    public var posName: String?
    public var version: Int?
    
    
    public required init?(map: Map) {}
    public required init(){}
    public func mapping(map: Map) {
        saleID              <-  map["s"]
        pairingPOIID        <-  map["p"]
        kek                 <-  map["k"]
        cerificationCode    <-  map["c"]
        posName             <-  map["n"]
        version             <-  map["v"]
    }
    
    public static func createKEK() -> String! {
        var chars = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" ]
        var result: String! = "";
        for _ in 1...48 {
            result += chars.randomElement()!
        }
        return result;
    }
}
