//
//  InterfaceController.swift
//  BSSDemo WatchKit Extension
//
//  Created by Jieyi Hu on 7/24/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//
import UIKit
import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {
    
    var hardwareCtrl = HKWatchController()
    let mgr = CMMotionManager()
    
    // MARK: Notification related
    var lastNotificationDate = NSDate(timeIntervalSince1970: 0)
    let notificationPushInterval : NSTimeInterval = 1.0
    
    
    @IBOutlet var motionSensorSwitch: WKInterfaceSwitch!
    
    @IBAction func pushButtonClick() {
        hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Push.notification)
    }
    @IBAction func leftButtonClick() {
        hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Left.notification)
    }
    @IBAction func rightButtonClick() {
        hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Right.notification)
    }
    @IBAction func upButtonClick() {
        hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Up.notification)
    }
    @IBAction func downButtonClick() {
        hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Down.notification)
    }
    @IBAction func motionSensorSwitchClick(value: Bool) {
        if value {
            mgr.accelerometerUpdateInterval = 0.01
            mgr.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: { (data, error) -> Void in
                if let data = data {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    if sqrt(x*x+y*y+z*z) > 1.35 {
                        if self.lastNotificationDate.timeIntervalSinceNow <= -self.notificationPushInterval {
                            if z > y {
                                self.hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Up.notification)
                            } else {
                                self.hardwareCtrl.comSession.sendNotification(GKPredefinedGesture.Down.notification)
                            }
                            self.lastNotificationDate = NSDate()
                        }
                    }
                }
            })
        } else {
            mgr.stopAccelerometerUpdates()
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
}
