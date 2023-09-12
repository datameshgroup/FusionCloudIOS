//
//  Settings.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 12/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import FusionCloudIOS
import CoreImage.CIFilterBuiltins

class SettingsController: UIViewController{
    @IBOutlet var SettingsView: UIView!
    
    @IBOutlet weak var btnPairTerminal: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

    }
    
    @IBAction func btnPairTerminal(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "QRStoryboard")
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
