//
//  InterfaceController.swift
//  Slider WatchKit Extension
//
//  Created by Jieyi Hu on 7/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    var phoneComCtrl : GKSessionControllerW = GKSessionControllerW()
    var sensorCtrl : GKSensorController = GKSensorController()
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        registerNotification()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        sensorCtrl.gestureClassifier = GKGestureClassifier.simpleTreeModel()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func registerNotification() {
        GKGesture.Up.registerNotification(self, selector: "gestureUpHandler")
        GKGesture.Down.registerNotification(self, selector: "gestureDownHandler")
        GKGesture.Left.registerNotification(self, selector: "gestureLeftHandler")
        GKGesture.Right.registerNotification(self, selector: "gestureRightHandler")
        GKGesture.Push.registerNotification(self, selector: "gesturePushHandler")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionUnreachableHandler", name: "TryToUseWCSessionWhileUnreachable", object: nil)
    }
    
    func sessionUnreachableHandler() {
        self.presentAlertControllerWithTitle("Unreachable", message: "Try to use WCSession while it is unreachable", preferredStyle: WKAlertControllerStyle.Alert, actions: [WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler: {self.popController()})])
    }
    
    func gestureUpHandler(){
        phoneComCtrl.sendGestureToHandheld(GKGesture.Up)
    }
    func gestureDownHandler(){
        phoneComCtrl.sendGestureToHandheld(GKGesture.Down)
    }
    func gestureLeftHandler(){
        phoneComCtrl.sendGestureToHandheld(GKGesture.Left)
    }
    func gestureRightHandler(){
        phoneComCtrl.sendGestureToHandheld(GKGesture.Right)
    }
    func gesturePushHandler(){
        phoneComCtrl.sendGestureToHandheld(GKGesture.Push)
    }
    
    
    //  button click events
    @IBAction func upButtonClick() {
        gestureUpHandler()
    }
    
    @IBAction func downButtonClick() {
        gestureDownHandler()
    }
    
    @IBAction func leftButtonClick() {
        gestureLeftHandler()
    }
    
    @IBAction func rightButtonClick() {
        gestureRightHandler()
    }
    
    @IBAction func pushButtonClick() {
        gesturePushHandler()
    }
    
    @IBAction func SensorSwitchClick(value: Bool) {
        sensorCtrl.on = value
    }
}
