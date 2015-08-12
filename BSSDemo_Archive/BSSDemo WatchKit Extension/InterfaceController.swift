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
    
    var session = CKSessionWatch()
    
    @IBOutlet var motionSensorSwitch: WKInterfaceSwitch!
    
    @IBAction func pushButtonClick() {
    }
    @IBAction func leftButtonClick() {
        session.sendNotification(GKPredefinedGesture.Left.notification)
    }
    @IBAction func rightButtonClick() {
        session.sendNotification(GKPredefinedGesture.Right.notification)
    }
    @IBAction func upButtonClick() {
        session.sendNotification(GKPredefinedGesture.Up.notification)
    }
    @IBAction func downButtonClick() {
        session.sendNotification(GKPredefinedGesture.Down.notification)
    }
    @IBAction func motionSensorSwitchClick(value: Bool) {
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
