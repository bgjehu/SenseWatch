//
//  HKWatchSensorManagerCP.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/8/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class HKWatchSensorManagerCP: NSObject {

    var parent : HKHandheldController!
    var accelerometerDataHandler : (HKAccelerometerData -> Void)!
    
    init(parent : HKHandheldController) {
        super.init()
        self.parent = parent
    }
    
    func startAccelerometerUpdates(handler : HKAccelerometerData -> Void) {
        accelerometerDataHandler = handler
    }
    
    func stopAccelerometerUpdates() {
        accelerometerDataHandler = nil
    }
}
