# FusionCloudIOS

[![CI Status](https://img.shields.io/travis/datameshgroup/FusionCloudIOS.svg?style=flat)](https://travis-ci.org/datameshgroup/FusionCloudIOS)
[![Version](https://img.shields.io/cocoapods/v/FusionCloudIOS.svg?style=flat)](https://cocoapods.org/pods/FusionCloudIOS)
[![License](https://img.shields.io/cocoapods/l/FusionCloudIOS.svg?style=flat)](https://cocoapods.org/pods/FusionCloudIOS)
[![Platform](https://img.shields.io/cocoapods/p/FusionCloudIOS.svg?style=flat)](https://cocoapods.org/pods/FusionCloudIOS)

## Overview
This repository contains a websocket client and security components to make it easy for developer to connect and communicate with the DataMesh Unify payments platform.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

FusionCloudIOS is available through [CocoaPods](https://cocoapods.org/pods/FusionCloudIOS). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FusionCloudIOS'
```

## Usage
See the [DataMesh Fusion API](https://datameshgroup.github.io/fusion) documentation for a full description of schema and workflows. 

The [fusioncloud-sdk-ios-demo](https://github.com/datameshgroup/fusioncloud-sdk-ios-demo) application provides sample code for using the FusionCloud.framework library. 

Construct an instance of `FusionCloudConfig` using the configuration provided by DataMesh. See the [Fusion API](https://datameshgroup.github.io/fusion/#getting-started-design-your-integration-sale-system-settings) for instructions on how to manage settings. 

```
fusionCloudConfig = FusionCloudConfig()
fusionCloudConfig!.initConfig(
testEnvironment: true | false,
customURL: "<<Provided by DataMesh>>"
providerIdentification: "<<Provided by DataMesh>>",
applicationName: "<<Provided by DataMesh>>",
certificationCode: "<<Provided by DataMesh>>",
softwareVersion: "<<Your POS version>>")
```
Add *FusionClientDelegate* instance to your class.
* This will reveal the following socket events
<img width="841" alt="image" src="https://user-images.githubusercontent.com/107380164/202443409-040fa492-76ee-4c17-ab0b-a918a1a3a111.png">


Test connection to Socket
```
self.fusionClient = FusionClient(fusionCloudConfig: fusionCloudConfig)
```

Build and send a login 

```
let loginRequest = LoginRequest()
loginRequest.dateTime = Date()
loginRequest.operatorID = "sfsuper"
loginRequest.operatorLanguage = "en"
let saleSoftware = SaleSoftware()
saleSoftware.providerIdentification = fusionCloudConfig!.providerIdentification
saleSoftware.ApplicationName = fusionCloudConfig!.applicationName
saleSoftware.softwareVersion = fusionCloudConfig!.softwareVersion
saleSoftware.certificationCode = fusionCloudConfig!.certificationCode
let saleTerminalData = SaleTerminalData()
saleTerminalData.terminalEnvironment = "Attended"
saleTerminalData.saleCapabilities = ["CashierStatus","CashierError","CashierInput","CustomerAssistance","PrinterReceipt"]

loginRequest.saleTerminalData = saleTerminalData
loginRequest.saleSoftware = saleSoftware
```

Build and send a Payment

```
let paymentRequest = PaymentRequest()
let saleData = SaleData()
saleData.tokenRequestedType = "Customer"
saleData.saleTransactionID = SaleTransactionID(transactionID: "3000403")

let paymentTransaction = PaymentTransaction()

let amountsReq = AmountsReq(
amountsReq.currency = "AUD"
amountsReq.requestedAmount = requestedAmount
amountsReq.tipAmount = tipAmount

let saleItem1 = SaleItem()
saleItem1.itemID = 1
saleItem1.productCode = "SKU00FFDDG"
saleItem1.unitMeasure = "Unit"
saleItem1.quantity = 1
saleItem1.unitPrice = 42.50
saleItem1.productLabel = "NVIDIA GEFORCE RTX 3090"

paymentTransaction.amountsReq = amountsReq
paymentTransaction.saleItem = [saleItem1]

let paymentData = PaymentData(paymentType: paymentType) // paymentType = Normal|Refund
paymentRequest.saleData = saleData
paymentRequest.paymentTransaction = paymentTransaction
paymentRequest.paymentData = paymentData
```


## Author

datameshgroup, vanessa@datameshgroup.com

## License

FusionCloudIOS is available under the MIT license. See the LICENSE file for more info.
