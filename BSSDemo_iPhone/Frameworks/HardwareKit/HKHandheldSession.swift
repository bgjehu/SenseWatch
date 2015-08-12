//
//  HKHandheldSession.swift
//  Slider
//
//  Created by Jieyi Hu on 7/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import WatchConnectivity


//
//  A controller to control WCSession on Handheld Device to communicate with Watch
//
class HKHandheldSession: NSObject, WCSessionDelegate {
    
    var session : WCSession! = WCSession.isSupported() ? WCSession.defaultSession() : nil
    var parent : HKHandheldController!
    
    init(parent : HKHandheldController){
        
        super.init()
        self.parent = parent
        if session == nil {
            print("WCSession is not supported")
        } else {
            //  set delegate
            session.delegate = self
            
            //  activate session
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        //retrieve info
        let type = message["Type"] as! String
        let content = message["Content"]
        
        switch type {
            
            case "Notification":
                readNotification(content)
            case "AcclerometerData":
                readAcclerometerData(content)
            default:
                print("Received message \(message) is invalid with type of \(type)")
            
        }

    }
    
    func readNotification(content : AnyObject?) {
        let notificationName = content as! String
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil)
    }
    
    func readAcclerometerData(content : AnyObject?) {
        let dataInContent = content as! [String : String]
        let x = Double(dataInContent["X"] as String!)!
        let y = Double(dataInContent["Y"] as String!)!
        let z = Double(dataInContent["Z"] as String!)!
        let timestamp = NSTimeInterval(dataInContent["Time"] as String!)!
        let data = HKAccelerometerData(x: x, y: y, z: z, timestamp: timestamp)
        if let handler = parent.sensorManager.accelerometerDataHandler {
            handler(data)
        }
    }
}
