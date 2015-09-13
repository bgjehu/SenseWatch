//
//  TrainnerRootInterfaceController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/5/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import WatchKit
import Foundation


class TrainnerRootInterfaceController: WKInterfaceController {
    
    @IBAction func f1ButtonClicked() {
        presentTrainnerInterfaceController("F1")
    }
    @IBAction func f2ButtonClicked() {
        presentTrainnerInterfaceController("F2")
    }
    @IBAction func f3ButtonClicked() {
        presentTrainnerInterfaceController("F3")
    }
    @IBAction func f4ButtonClicked() {
        presentTrainnerInterfaceController("F4")
    }
    @IBAction func f5ButtonClicked() {
        presentTrainnerInterfaceController("F5")
    }
    @IBAction func f6ButtonClicked() {
        presentTrainnerInterfaceController("F6")
    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func presentTrainnerInterfaceController(gestureName : String) {
        presentControllerWithName("TrainnerIC", context: gestureName)
    }
    
}
