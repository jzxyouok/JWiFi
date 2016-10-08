//
//  TodayViewController.swift
//  JWiFiTarget
//
//  Created by 晋先森 on 16/7/5.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit
import NotificationCenter

import SystemConfiguration.CaptiveNetwork

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var wifiButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: self.view.frame.size.width,height: 50)

        wifiButton.titleEdgeInsets = UIEdgeInsetsMake(0,10, 0,0)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let currentSSID = self.fetchSSIDInfo()

         wifiButton.setTitle(currentSSID.characters.count > 0 ? currentSSID : "No WiFi Connected", for: UIControlState())
    }


    func fetchSSIDInfo() ->  String {

    #if TARGET_IPHONE_SIMULATOR
           return "This is a simulator"
    #else
        let interfaces = CNCopySupportedInterfaces()
        var ssid = ""
        if interfaces != nil {
            let interfacesArray = CFBridgingRetain(interfaces) as! Array<AnyObject>
            if interfacesArray.count > 0 {
                let interfaceName = interfacesArray[0] as! CFString
                let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)
                if (ussafeInterfaceData != nil) {
                    let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                    ssid = interfaceData["SSID"]! as! String
                }
            }
        }
        return ssid

    #endif
    }


    @IBAction func wifiButtonClick(_ sender: UIButton) {

      //使用 prefs:root=WIFI 这个API会被惨拒！
        //self.extensionContext?.openURL(NSURL.init(string:"prefs:root=WIFI")!, completionHandler: { (result) in  })

    self.extensionContext?.open(URL.init(string: "JWiFi://com.jinxiansen.JWiFi")!, completionHandler: { (result) in
            print("open url result :\(result)")
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0,30, 0, 0)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.newData)
    }

//    @available(iOSApplicationExtension 10.0, *)
//    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize){
//        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
//            self.preferredContentSize = CGSize(width: self.view.frame.size.width,height: 50)
//        }
//        else {
//            self.preferredContentSize = CGSize(width: self.view.frame.size.width,height: 100)
//        }
//    }


}
