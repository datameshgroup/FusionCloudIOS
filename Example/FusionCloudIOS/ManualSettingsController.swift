//
//  ManualSettingsController.swift
//  FusionCloudIOS_Example
//
//  Created by Vanessa on 13/9/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import FusionCloudIOS

class ManualSettingsController: UIViewController, FusionClientDelegate{
    
    //TODO check serviceID of response
    func socketConnected(client: FusionCloudIOS.FusionClient) {
        print("socketConnected")
        connectionSuccessful()
    }
    
    func socketDisconnected(client: FusionCloudIOS.FusionClient) {
        print("socketDisconnected")
        connectionFailure(errorMessage: "socketDisconnected")
    }
    
    func socketReceived(client: FusionCloudIOS.FusionClient, data: String) {
        print("socketReceived")
    }
    
    func socketError(client: FusionCloudIOS.FusionClient, error: Error) {
        print("socketError")
        connectionFailure(errorMessage: error.localizedDescription)
    }
    
    func logData(client: FusionCloudIOS.FusionClient, type: String, data: String) {
        print("logData")
        print(data)
    }
    
    func loginResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, loginResponse: FusionCloudIOS.LoginResponse) {
        print("loginResponseReceived")
        print(loginResponse)
        if (loginResponse.response?.result == ResponseResult.Success) {
            loginSuccessful()
        }
        else{
            loginFailure(errorMessage: "Login Failure. " + (loginResponse.response?.additionalResponse ?? "unknown error"))
        }
        
    }
    
    func paymentResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, paymentResponse: FusionCloudIOS.PaymentResponse) {
        print("paymentResponseReceived")
    }
    
    func transactionStatusResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, transactionStatusResponse: FusionCloudIOS.TransactionStatusResponse) {
        print("transactionStatusResponseReceived")
    }
    
    func displayRequestReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, displayRequest: FusionCloudIOS.DisplayRequest) {
        print("displayRequestReceived")
    }
    
    func eventNotificationReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, eventNotification: FusionCloudIOS.EventNotification) {
        print("eventNotificationReceived")
    }
    
    func reconcilationResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, reconcilationResponse: FusionCloudIOS.ReconciliationResponse) {
        print("reconcilationResponseReceived")
    }
    
    func cardAcquisitionResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, cardAcquisitionResponse: FusionCloudIOS.CardAcquisitionResponse) {
        print("cardAcquisitionResponseReceived")
    }
    
    func logoutResponseResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, logoutResponse: FusionCloudIOS.LogoutResponse) {
        print("logoutResponseResponseReceived")
    }
    
    func credentialsError(client: FusionCloudIOS.FusionClient, error: String) {
        print("credentialsError")
        loginFailure(errorMessage: error)
    }
    
    @IBOutlet weak var inputSaleID: UITextField!
    @IBOutlet weak var inputPOIIID: UITextField!
    @IBOutlet weak var inputKEK: UITextField!
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var txtConnectionStatus: UILabel!
    
    var currentServiceID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        txtConnectionStatus.isHidden = true
        indicatorLoading.isHidden = true
        
        if(UserDefaults.standard.isPaired()){
            inputSaleID.text = UserDefaults.standard.getSaleID()
            inputPOIIID.text = UserDefaults.standard.getPOIID()
            inputKEK.text = UserDefaults.standard.getKEK()
        }

    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOK(_ sender: Any) {
        indicatorLoading.isHidden = false

        UserDefaults.standard.initFusion()
        fusionClient.fusionClientDelegate = self
    }
    
    func doLogin(){
        self.currentServiceID = UUID().uuidString
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
            
        fusionClient.messageHeader?.serviceID = currentServiceID
        fusionClient.messageHeader?.messageCategory = MessageCategory.Login
        fusionClient.messageHeader?.saleID = inputSaleID.text
        fusionClient.messageHeader?.poiID = inputPOIIID.text
        fusionCloudConfig.kekValue = inputKEK.text
        
                
        let loginRequest = LoginRequest()
            loginRequest.dateTime = Date()
            loginRequest.operatorLanguage = "en"
            
        let saleSoftware = SaleSoftware()
            saleSoftware.providerIdentification = fusionCloudConfig.providerIdentification
            saleSoftware.applicationName = fusionCloudConfig.applicationName
            saleSoftware.softwareVersion = fusionCloudConfig.softwareVersion
            saleSoftware.certificationCode = fusionCloudConfig.certificationCode
                
        let saleTerminalData = SaleTerminalData()
        saleTerminalData.terminalEnvironment = TerminalEnvironment.Attended
        saleTerminalData.saleCapabilities = [SaleCapability.CashierStatus, SaleCapability.CashierError, SaleCapability.CashierInput, SaleCapability.CustomerAssistance, SaleCapability.PrinterReceipt]
                
        loginRequest.saleTerminalData = saleTerminalData
        loginRequest.saleSoftware = saleSoftware
        fusionClient.sendMessage(requestBody: loginRequest, type: "LoginRequest")
        
    }
    
    func connectionSuccessful(){
        indicatorLoading.isHidden=true
        txtConnectionStatus.isHidden = false
        txtConnectionStatus.text = "Socket Connected. Logging in..."
        txtConnectionStatus.textColor = UIColor.systemGreen
        
        //TODO Validate required input
        fusionCloudConfig.saleID = inputSaleID.text
        fusionCloudConfig.poiID = inputPOIIID.text
        fusionCloudConfig.kekValue = inputKEK.text
        
        doLogin()
    }
    
    func connectionFailure(errorMessage: String){
        indicatorLoading.isHidden=true
        txtConnectionStatus.isHidden = false
        txtConnectionStatus.text = "Socket Connection Failed. \nDetail: " + errorMessage
        txtConnectionStatus.textColor = UIColor.systemRed
    }
    
    func loginFailure(errorMessage: String){
        indicatorLoading.isHidden=true
        txtConnectionStatus.isHidden = false
        txtConnectionStatus.text = "Login Failed. Detail: " + errorMessage
        txtConnectionStatus.textColor = UIColor.systemRed
        
        errorDescription = txtConnectionStatus.text!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "NotPairedStoryboard")
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func loginSuccessful(){
        indicatorLoading.isHidden=true
        txtConnectionStatus.isHidden = false
        txtConnectionStatus.text = "Login Successful. Saving.."
        txtConnectionStatus.textColor = UIColor.systemGreen
        
        saveConfig()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.dismiss(animated: true, completion: nil)
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "PairedStoryboard")
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    func saveConfig(){
        UserDefaults.standard.setSaleID(value: inputSaleID.text ?? "")
        UserDefaults.standard.setPOIID(value: inputPOIIID.text ?? "")
        UserDefaults.standard.setKEK(value: inputKEK.text ?? "" )
        
        UserDefaults.standard.setPaired(value: true)
    }
    
    
}
