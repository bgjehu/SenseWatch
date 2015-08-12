//
//  GKMotionManager.swift
//  Slider
//
//  Created by Jieyi Hu on 7/11/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKMotionSensorController: NSObject, MSBClientManagerDelegate {

    var bandClient : MSBClient!
    var bandConnected : Bool = false
    var sensorNeedStart : Bool = false
    var patternChannel : GKGesturePatternChannel!
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
        var reading : Bool = false {
        didSet{
            if oldValue == self.reading {
                //  unchange
            } else {
                //  changed
                if reading {
                    if bandConnected {
                        startSensor()
                    } else {
                        sensorNeedStart = true
                    }
                } else {
                    stopSensor()
                }
            }
        }
    }

    
    init(classifier : GKGestureClassifier) {
        super.init()
        setupMSBand()
        self.classifier = classifier
        patternChannel = GKGesturePatternChannel(length: classifier.length, width: classifier.width)
        setupMSBand()
    }
    
    func setupMSBand(){
        MSBClientManager.sharedManager().delegate = self
        bandClient = MSBClientManager.sharedManager().attachedClients()[0] as? MSBClient
        if bandClient == nil {
            print("No connection to Microsoft Band")
        } else {
            MSBClientManager.sharedManager().connectClient(bandClient)
        }
    }
    
    //  MARK: MSBandSDK
    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        print("Failed to connect Microsoft Band")
    }
    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        print("Microsoft Band Connected")
        bandConnected = true
        if sensorNeedStart {
            startSensor()
        }
    }
    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
    }
    func accelerometerDataHandler(data : MSBSensorAccelerometerData!, error : NSError!) {
        if error != nil {
            print("\(error)")
        } else {
            if data != nil {
                
                patternChannel.enqueue([data.x,data.y,data.z].map({number in round(number / 0.1)}))
                if let result = classifier.classify(patternChannel.createPattern(withName: nil)) {
                    if lastNotificationDate.timeIntervalSinceNow <= -notificationPushInterval {
                        NSNotificationCenter.defaultCenter().postNotification(result.notification)
                        lastNotificationDate = NSDate()
                    }
                }
            }
        }
    }
    
    func startSensor() {
        do {
            try bandClient.sensorManager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: accelerometerDataHandler)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func stopSensor() {
        do{
            try bandClient.sensorManager.stopAccelerometerUpdatesErrorRef()
        } catch let error as NSError {
            print(error)
        }
    }

}
