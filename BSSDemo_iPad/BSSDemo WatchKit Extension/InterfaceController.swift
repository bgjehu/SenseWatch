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


class InterfaceController: WKInterfaceController {
    
    var hardwareCtrl = HKWatchController()
    
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
        hardwareCtrl.sensorManager.accelerometerOn = value
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
