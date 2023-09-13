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
    
    @IBOutlet weak var btnUnpairTerminal: UIButton!
    @IBOutlet weak var btnPairTerminal: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnViewSettings: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

    }
    
    
    @IBAction func btnViewSettings(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "ManualSettingStoryboard")
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnUnpairTerminal(_ sender: Any) {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        print("UserDefaults cleared")
    }
    
    @IBAction func btnPairTerminal(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "QRStoryboard")

        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
}
