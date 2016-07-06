//
//  StepModel.swift
//  JWiFi
//
//  Created by 晋先森 on 16/7/6.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

class StepModel: NSObject {

    var step : String?

    var imageName : String?

    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}


}
