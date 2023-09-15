//
//  PairSuccessController.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 14/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import FusionCloudIOS

class PairSuccessController: UIViewController{
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var txtPOIID: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPOIID.text = "POIID: " + UserDefaults.standard.getPOIID() + "\n" +
        "Generated SaleID: " + UserDefaults.standard.getSaleID() + "\n" +
        "Generated KEK: " + UserDefaults.standard.getKEK() + "\n"
       
    }
    
    @IBAction func btnOK(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "MainStoryboard")
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
}
