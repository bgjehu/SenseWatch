//
//  GKUtilities.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/5/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import CoreMotion

class GKUtilities: NSObject {

}


extension CMAccelerometerData {
    var quantizedData : [Double] {
        get{
//            let data = [round(self.acceleration.x / 0.1), round(self.acceleration.y / 0.1), round(self.acceleration.z / 0.1)]
            let data = [self.acceleration.x,self.acceleration.y,self.acceleration.z]
            return data
        }
    }
}