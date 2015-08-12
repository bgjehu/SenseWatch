//
//  GKMotionManager.swift
//  Slider
//
//  Created by Jieyi Hu on 7/11/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import CoreMotion

class GKMotionSensorController: NSObject {

    private var motionManager : CMMotionManager = CMMotionManager()
    var classifier : GKGestureClassifier!
    var operationQueue : NSOperationQueue {
        get{
            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount = 5
            return queue
        }
    }
    var lastNotificationDate = NSDate(timeIntervalSince1970: 0)
    var notificationPushInterval : NSTimeInterval = 1.0
    var sensorUpdateInterval : NSTimeInterval {
        get{
            return motionManager.accelerometerUpdateInterval
        }
        set{
            motionManager.accelerometerUpdateInterval = newValue
        }
    }
    var reading : Bool = false {
        didSet{
            if oldValue == self.reading {
                //  unchange
            } else {
                //  changed
                if reading {
                    motionManager.startAccelerometerUpdatesToQueue(operationQueue, withHandler: handlerAccelerometerData)
                } else {
                    motionManager.stopAccelerometerUpdates()
                }
            }
        }
    }

    
    init(classifier : GKGestureClassifier) {
        super.init()
        self.classifier = classifier
        sensorUpdateInterval = 0.01
    }
    
    func handlerAccelerometerData (data : CMAccelerometerData?, error : NSError?) {
        if error != nil {
            print("\(error)")
        } else {
            if data != nil {
                if let result = classifier(data){
                    if lastNotificationDate.timeIntervalSinceNow <= -notificationPushInterval {
                        NSNotificationCenter.defaultCenter().postNotification(result.notification)
                        lastNotificationDate = NSDate()
                    }
                }
            }
        }
    }
}
