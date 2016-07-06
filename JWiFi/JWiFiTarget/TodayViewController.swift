//
//  TodayViewController.swift
//  JWiFiTarget
//
//  Created by 晋先森 on 16/7/5.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit
import NotificationCenter
//import NetworkExtension
import SystemConfiguration.CaptiveNetwork

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var wifiButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSizeMake(self.view.frame.size.width,50)

        wifiButton.titleEdgeInsets = UIEdgeInsetsMake(0,10, 0,0)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let currentSSID = self.fetchSSIDInfo()

         wifiButton.setTitle(currentSSID.characters.count > 0 ? currentSSID : "No WiFi Connected", forState: UIControlState.Normal)
    }
    // http://stackoverflow.com/questions/31755692/swift-cncopysupportedinterfaces-not-valid
    func fetchSSIDInfo() ->  String {
        var currentSSID = ""
        if let interfaces:CFArray! = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = interfaceData["SSID"] as! String
                } else {
                    currentSSID = ""
                }
            }
        }
        return currentSSID
    }



    @IBAction func wifiButtonClick(sender: UIButton) {

        self.extensionContext?.openURL(NSURL.init(string:"prefs:root=WIFI")!, completionHandler: { (result) in
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0,30, 0, 0)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
