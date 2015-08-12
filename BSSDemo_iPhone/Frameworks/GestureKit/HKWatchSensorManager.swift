//
//  HKWatchSensorManager.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/8/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import CoreMotion

class HKWatchSensorManager: NSObject {

    var motionManager = CMMotionManager()
    var parent : HKWatchController!
    var accelerometerOn : Bool = false {
        didSet{
            if oldValue != accelerometerOn {
                if accelerometerOn {
                    motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: { (data, error) -> Void in
                        if error != nil {
                            print(error)
                        } else {
                            if let data = data {
                                self.parent.comSession.sendAcclerometerData(data)
                            }
                        }
                    })
                } else {
                    motionManager.stopAccelerometerUpdates()
                }
            }
        }
    }
    
    init(parent : HKWatchController) {
        super.init()
        self.parent = parent
    }
}
