//
//  ViewController.swift
//  FusionCloudIOS
//
//  Created by datameshgroup on 09/07/2023.
//  Copyright (c) 2023 datameshgroup. All rights reserved.
//

import UIKit
import FusionCloudIOS

class ViewController: UIViewController, FusionClientDelegate {
    func socketConnected(client: FusionCloudIOS.FusionClient) {
        print("socketConnected")
    }
    
    func socketDisconnected(client: FusionCloudIOS.FusionClient) {
        print("socketDisconnected")
    }
    
    func socketReceived(client: FusionCloudIOS.FusionClient, data: String) {
        print("socketReceived")
    }
    
    func socketError(client: FusionCloudIOS.FusionClient, error: Error) {
        print("socketError")
    }
    
    func logData(client: FusionCloudIOS.FusionClient, type: String, data: String) {
        print("logData")
    }
    
    func loginResponseReceived(client: FusionCloudIOS.FusionClient, messageHeader: FusionCloudIOS.MessageHeader, loginResponse: FusionCloudIOS.LoginResponse) {
        print("loginResponseReceived")
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
    }
    

    let testEnvironment = true
    let fusionCloudConfig = FusionCloudConfig(testEnvironmentui: true)
    var fusionClient = FusionClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        fusionCloudConfig.allowSelfSigned = true
       ///TO BE PROVIDED BY DATAMESH
       fusionCloudConfig.saleID = testEnvironment ? "VA POS"  : "<<SALE ID - PROD>>"
       fusionCloudConfig.poiID = testEnvironment ? "DMGVA002" : "<<POI ID - PROD>>"
               
       fusionCloudConfig.providerIdentification = testEnvironment ? "Company A" : "<<PROD>>"
       fusionCloudConfig.applicationName = testEnvironment ? "POS Retail" : "<<PROD>>"
       fusionCloudConfig.softwareVersion = testEnvironment ? "01.00.00" : "<<PROD>>"
       fusionCloudConfig.certificationCode = testEnvironment ? "98cf9dfc-0db7-4a92-8b8cb66d4d2d7169" : "<<PROD>>"
               
        /*per pinpad*/
        fusionCloudConfig.kekValue = testEnvironment ? "44DACB2A22A4A752ADC1BBFFE6CEFB589451E0FFD83F8B21" : "<<PROD>>"
               
        self.fusionClient = FusionClient(fusionCloudConfig: fusionCloudConfig)
        fusionClient.fusionClientDelegate = self
        
        
        
        var currentTransaction = "Login"
        var currentTransactionServiceID = UUID().uuidString
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
            
        fusionClient.messageHeader?.serviceID = currentTransactionServiceID
        fusionClient.messageHeader?.messageCategory = MessageCategory.Login
                
        let loginRequest = LoginRequest()
            loginRequest.dateTime = Date()
//            loginRequest.operatorID = "sfsuper"
            loginRequest.operatorLanguage = "en"
            
        let saleSoftware = SaleSoftware()
            saleSoftware.providerIdentification = fusionCloudConfig.providerIdentification
            saleSoftware.applicationName = fusionCloudConfig.applicationName
            saleSoftware.softwareVersion = fusionCloudConfig.softwareVersion
            saleSoftware.certificationCode = fusionCloudConfig .certificationCode
                
        let saleTerminalData = SaleTerminalData()
        saleTerminalData.terminalEnvironment = TerminalEnvironment.Attended
        saleTerminalData.saleCapabilities = [SaleCapability.CashierStatus, SaleCapability.CashierError, SaleCapability.CashierInput, SaleCapability.CustomerAssistance, SaleCapability.PrinterReceipt]
                
        loginRequest.saleTerminalData = saleTerminalData
 
        fusionClient.sendMessage(requestBody: loginRequest, type: "LoginRequest")
        
        let x = File()
        x.printFile()
        print("test")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

