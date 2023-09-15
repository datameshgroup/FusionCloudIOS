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
        fusionClient.disconnect();
        print("UserDefaults cleared")
        self.showToast(message: "Terminal Unpaired", font: .systemFont(ofSize: 24))
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
extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-250, width: 200, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .transitionCurlDown, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
