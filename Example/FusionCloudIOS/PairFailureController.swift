//
//  PairFailureController.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 14/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import FusionCloudIOS

class PairFailureController: UIViewController{
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var txtErrorDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtErrorDescription.text = errorDescription
        // add error description here
       
    }
  
    
    @IBAction func btnOK(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
