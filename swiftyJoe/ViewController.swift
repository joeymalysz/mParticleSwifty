//
//  ViewController.swift
//  swiftyJoe
//
//  Created by Joe Malysz on 1/10/17.
//  Copyright © 2017 JMalysz. All rights reserved.
//

import UIKit
import Mixpanel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        enum MPScreen: String {
           case home = "Home screen"
           case threeNDone = "3nDone Screen"
           case samsungPayPromotion = "Samsung Pay Promotion"
           case settings = "Settings"
           case wallet = "Wallet"
           case promos = "Promos Page"
           case about = "About"
           case loyaltyCarousel = "Loyalty Card Carousel"
           case receipts = "Receipt History"
           case help = "Help"
           case faq = "FAQs"
           case qrCode = "QR Code Reader"
           case plentiRedemption = "Plenti Redemption Screen"
           case preTransaction = "Pre-transaction Summary"
           case paymentMethods = "Payment Method Selection Screen"
           case loyalty = "Loyalty Card Selection Screen"
           case pumpSelection = "Pump Selection"
           case spPasscode = "SP+ Passcode Screen"
           case thirtySeconds = "30 Second Screen"
           case discountCards = "Discount Card Selection Page"
            func mpTrack (event: String, properties: [String:String]? = nil) {
                Mixpanel.mainInstance().track(event: event, properties: properties)
            }
            func send(properties: [String: String]? = nil) {
                mpTrack(event: self.rawValue, properties: properties)
            }
        }

        MPScreen.qrCode.send(properties:nil)
    }
    @IBOutlet weak var label1: UILabel!
    
    @IBAction func btn1(_ sender: Any) {
        let boolTweak = MixpanelTweaks.assign(
            MixpanelTweaks.boolTweak)
        if boolTweak == true{
            label1.text = "DEFAULT"
        } else {
            label1.text = "TWEAKED"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

