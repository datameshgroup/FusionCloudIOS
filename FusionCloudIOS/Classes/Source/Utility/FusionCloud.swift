//
//  FusionCloud.swift
//  FusionCloud
//
//  Created by Loey Agdan on 6/25/22.
//

import Foundation

public class FusionCloudConfig{
    public var serverDomain: String?
    public var kekValue: String?
    public var keyIdentifier: String?
    public var keyVersion: String?
    public var providerIdentification: String?
    public var applicationName: String?
    public var softwareVersion: String?
    public var certificationCode: String?
    public var saleID: String!
    public var poiID: String!
    public var testEnvironment: Bool
    
    public var allowSelfSigned: Bool?
    
    public required init(testEnvironmentui: Bool?) {
        testEnvironment = testEnvironmentui ?? true
        
        self.serverDomain = testEnvironment ? "wss://www.cloudposintegration.io/nexodev" : "wss://nexo.datameshgroup.io:5000"
        self.keyIdentifier = testEnvironment ? "SpecV2TestMACKey" : "SpecV2ProdMACKey"
        self.keyVersion = testEnvironment ? "20191122164326" : "20191122164326"
        
    }
    
}
