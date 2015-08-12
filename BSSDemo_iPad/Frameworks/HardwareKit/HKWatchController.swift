//
//  HKWatchController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/8/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class HKWatchController: NSObject {
    var comSession : HKWatchSession!
    var sensorManager : HKWatchSensorManager!
    override init() {
        super.init()
        self.comSession = HKWatchSession(parent: self)
        self.sensorManager = HKWatchSensorManager(parent: self)
    }
}
