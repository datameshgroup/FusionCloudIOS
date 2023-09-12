//
//  QRController.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 12/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import FusionCloudIOS
import CoreImage.CIFilterBuiltins
let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

class QRController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

    }
    
    func btnGenerateQRCode(_ sender: Any) {
        print("Generating QR Code...")
        
        let s = UUID().uuidString //SaleID
        let p = UUID().uuidString //PairingPOIID
        let k = "" //KEK
        let c = "98cf9dfc-0db7-4a92-8b8cb66d4d2d7169" //CertificationCode
        let n = "IOS Demo App v1.0A" //POS display name with at most 30 characters.
        
        let newPairingData = fusionClient.createPairingData(
                                       saleID: s,
                                       pairingPOIID: p,
                                       kek: k,
                                       posName: n,
                                       certificationCode: c)
        print(newPairingData?.toJSONString()! ?? "default value")
        let qrCode = genQRCode(from: newPairingData?.toJSONString()! ?? "default value")
        

        
        let qrCodeImageView:UIImageView = UIImageView()
        qrCodeImageView.contentMode = UIView.ContentMode.scaleToFill
        qrCodeImageView.frame.size.width = 400
        qrCodeImageView.frame.size.height = 400
        qrCodeImageView.center = self.view.center
        qrCodeImageView.image = qrCode
        qrCodeImageView.layer.magnificationFilter = kCAFilterNearest
        view.addSubview(qrCodeImageView)
        
        
    }
    
    func genQRCode(from input: String) -> UIImage? {

        let data = Data(input.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
