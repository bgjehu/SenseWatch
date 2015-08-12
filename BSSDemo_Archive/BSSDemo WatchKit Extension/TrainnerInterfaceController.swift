//
//  TrainnerInterfaceController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/5/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import WatchKit
import Foundation


class TrainnerInterfaceController: WKInterfaceController {

    @IBOutlet var gestureLabel: WKInterfaceLabel!
    
    
    
    @IBAction func trainButtonClicked() {
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        gestureLabel.setText(context as? String)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
