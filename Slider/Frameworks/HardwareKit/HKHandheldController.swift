//
//  HKHandheldController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/8/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class HKHandheldController: NSObject {

    var comSession : HKHandheldSession!
    var sensorManager : HKWatchSensorManagerCP!
    
    override init() {
        super.init()
        comSession = HKHandheldSession(parent: self)
        sensorManager = HKWatchSensorManagerCP(parent: self)
    }
}
