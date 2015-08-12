//
//  GKBandSensorManager.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKBandSensorManager: NSObject, MSBClientManagerDelegate {

    // MARK: - Data Model
    // MARK: MS Band
    var bandClient : MSBClient!
    var connection : Bool {
        get{
            if let bandClient = bandClient {
                return bandClient.isDeviceConnected
            } else {
                return false
            }
        }
    }
    
    // MARK: GK related
    var classifier : GKGestureClassifier!
    var dataQueue : GKGestureDataStoringQueue?
    var dataRecorder = GKGestureDataRecorder(width: 3)
    var operationQueue : NSOperationQueue {
        get{
            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount = 1   //  Has to be 1 to avoid concurrency of putting sensor data into queue or recorder
            return queue
        }
    }
    var _classifying : Bool = false
    var classifying : Bool {
        get{
            return _classifying
        }
    }
    var _recording : Bool = false
    var recording : Bool {
        get{
            return _recording
        }
    }
    
    // MARK: Notification related
    var lastNotificationDate = NSDate(timeIntervalSince1970: 0)
    let notificationPushInterval : NSTimeInterval = 1.0
    
    
    // MARK: - MS Band Protocol
    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        print("Error connecting to band: failed to connect to band")
    }
    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        print("Band did connected")
        NSNotificationCenter.defaultCenter().postNotificationName("MSBAND_NOTIFICATION_CONNECTED", object: nil)
        startClassification()
    }
    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
        print("Band did disconnected")
    }
    
    
    // MARK: - Implementation
    override init() {
        super.init()
        MSBClientManager.sharedManager().delegate = self
        classifier = GKPredefinedGestureClassifier.UpDownLeftRight
        startConnect()
    }
    
    
    func startConnect() {
        if MSBClientManager.sharedManager().attachedClients().count > 0 {
            if let bandClient = MSBClientManager.sharedManager().attachedClients()[0] as? MSBClient {
                self.bandClient = bandClient
                MSBClientManager.sharedManager().connectClient(self.bandClient)
                print("Connecting band client...")
            } else {
                print("Error starting connection: attached MS Band client is invalid")
            }
        } else {
            print("Error starting connection: no attached MS Band client")
        }
    }
    func stopConnect() {
        if bandClient != nil {
            MSBClientManager.sharedManager().cancelClientConnection(bandClient)
        } else {
            print("Error stopping connection: no band client in connection")
        }
    }
    
    func startClassification() {
        if bandClient != nil && classifier != nil && connection {
            //  stop sensor
            do{try bandClient.sensorManager.stopAccelerometerUpdatesErrorRef()}catch let error as NSError{print(error)}
            
            //  start sensor and classification
            do{
                try bandClient.sensorManager.startAccelerometerUpdatesToQueue(operationQueue, withHandler: classification)
            } catch let error as NSError{
                print(error)
                _classifying = false
            }
        }
    }
    func stopClassification() {
        if bandClient != nil && classifier != nil && connection {
            //  stop sensor
            do{try bandClient.sensorManager.stopAccelerometerUpdatesErrorRef()}catch let error as NSError{print(error)}
            dataQueue = nil
            _classifying = false
        }
    }

    func startRecord() -> Bool {
        if bandClient != nil && connection {
            //  stop sensor
            do{try bandClient.sensorManager.stopAccelerometerUpdatesErrorRef()}catch let error as NSError{print(error)}
            
            //  start sensor and record
            do{
                dataRecorder.reset()
                try bandClient.sensorManager.startAccelerometerUpdatesToQueue(operationQueue, withHandler: dataRecord)
                return true
            } catch let error as NSError{
                print(error)
                _recording = false
                return false
            }
        } else {
            return false
        }
    }
    func stopRecord() {
        if bandClient != nil && connection {
            //  stop sensor
            do{try bandClient.sensorManager.stopAccelerometerUpdatesErrorRef()}catch let error as NSError{print(error)}
            _recording = false
        }
    }
    
    private func classification(data : MSBSensorAccelerometerData!, error : NSError!) {
        if error != nil {
            print("\(error)")
        } else {
            if classifier != nil {
                if dataQueue == nil {
                    //  new queue
                    dataQueue = classifier.queue
                } else { /* Do nothing */}
                
                if data != nil {
                    let testCase = dataQueue!.enque(GKUtilities.quantize(data))
                    _classifying = true
                    if let result = self.classifier.classify(testCase) {
                        if self.lastNotificationDate.timeIntervalSinceNow <= -self.notificationPushInterval {
                            result.postNotification()
                            self.lastNotificationDate = NSDate()
                        }
                    }
                } else {
                    print("Error classifying MSBSensorAccelerometerData: data is empty")
                }
            } else {
                print("Error classifying MSBSensorAccelerometerData: classifier is nil")
            }
        }
    }
    
    private func dataRecord(data : MSBSensorAccelerometerData!, error : NSError!) {
        if error != nil {
            print("\(error)")
        } else {
            dataRecorder.enque(GKUtilities.quantize(data))
            _recording = true
        }
    }
}
