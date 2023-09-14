//
//  Config.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 13/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import FusionCloudIOS

extension UserDefaults{
    
    func initFusion() {
        fusionClient = FusionClient(fusionCloudConfig: fusionCloudConfig)
        
    }
    
    func setPaired(value: Bool){
        set(value, forKey: UserDefaultKeys.isPaired.rawValue)
    }
    func isPaired()-> Bool {
        return bool(forKey: UserDefaultKeys.isPaired.rawValue)
    }
    
    func setSaleID(value: String){
        set(value, forKey: UserDefaultKeys.saleID.rawValue)
    }
    
    func getSaleID() -> String{
        return string(forKey: UserDefaultKeys.saleID.rawValue) ?? ""
    }
    
    func setPairingPOIID(value: String){
        set(value, forKey: UserDefaultKeys.pairingPOIID.rawValue)
    }
    
    func getPairingPOIID() -> String{
        return string(forKey: UserDefaultKeys.pairingPOIID.rawValue) ?? ""
    }
    
    func setKEK(value: String){
        set(value, forKey: UserDefaultKeys.kek.rawValue)
    }
    
    func getKEK() -> String{
        return string(forKey: UserDefaultKeys.kek.rawValue) ?? ""
    }
    
    func setPosName(value: String){
        set(value, forKey: UserDefaultKeys.posName.rawValue)
    }
    
    func getPosName() -> String{
        return string(forKey: UserDefaultKeys.posName.rawValue) ?? ""
    }
    
    func setPOIID(value: String){
        set(value, forKey: UserDefaultKeys.poiID.rawValue)
    }
    
    func getPOIID() -> String{
        return string(forKey: UserDefaultKeys.poiID.rawValue) ?? ""
    }
    
//    func setProviderIdentification(value: String){
//        set(value, forKey: UserDefaultKeys.providerIdentification.rawValue)
//    }
//
//    func getProviderIdentification() -> String{
//        return string(forKey: UserDefaultKeys.providerIdentification.rawValue) ?? ""
//    }
//    func setApplicationName(value: String){
//        set(value, forKey: UserDefaultKeys.applicationName.rawValue)
//    }
//
//    func getApplicationName() -> String{
//        return string(forKey: UserDefaultKeys.applicationName.rawValue) ?? ""
//    }
//    func setSoftwareVersion(value: String){
//        set(value, forKey: UserDefaultKeys.softwareVersion.rawValue)
//    }
//
//    func getSoftwareVersion() -> String{
//        return string(forKey: UserDefaultKeys.softwareVersion.rawValue) ?? ""
//    }
//    func setCertificationCode(value: String){
//        set(value, forKey: UserDefaultKeys.certificationCode.rawValue)
//    }
//    
//    func getCertificationCode() -> String{
//        return string(forKey: UserDefaultKeys.certificationCode.rawValue) ?? ""
//    }
    
    
    
}

enum UserDefaultKeys: String {
    case isPaired
    case saleID
    case pairingPOIID
    case kek
    case posName
    
    case poiID
//    case providerIdentification
//    case applicationName
//    case softwareVersion
//    case certificationCode
}

