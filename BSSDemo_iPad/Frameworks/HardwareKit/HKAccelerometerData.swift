//
//  CKAccelerometerData.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/8/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class HKAccelerometerData: NSObject {
    var x : Double
    var y : Double
    var z : Double
    var timestamp : NSTimeInterval
    init(x : Double, y : Double, z : Double, timestamp : NSTimeInterval) {
        self.x = x
        self.y = y
        self.z = z
        self.timestamp = timestamp
    }
}
