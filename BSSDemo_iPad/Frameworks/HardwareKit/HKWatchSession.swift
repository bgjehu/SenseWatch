//
//  HKWatchSessionHKWatchSession.swift
//  Slider
//
//  Created by Jieyi Hu on 7/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import WatchConnectivity
import WatchKit
import CoreMotion

class HKWatchSession: NSObject, WCSessionDelegate {
    
    var session : WCSession! = WCSession.isSupported() ? WCSession.defaultSession() : nil
    var parent : HKWatchController!
    
    init(parent : HKWatchController){
        
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
    
    deinit{

    }
    
    func sendMessage(type : String, content : AnyObject) {
        if session!.reachable {
            let message = [
                            "Type" : type,
                            "Content" : content
                            ]
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        } else {
            print("WCSession is not reachable")
        }
    }
    
    func sendNotification(notification : NSNotification) {
        sendMessage("Notification", content: notification.name)
    }
    
    func sendAcclerometerData(data : CMAccelerometerData) {
        let type = "AcclerometerData"
        let content = [
                        "X":String(data.acceleration.x),
                        "Y":String(data.acceleration.y),
                        "Z":String(data.acceleration.z),
                        "Time":String(data.timestamp)
                        ]
        sendMessage(type, content: content)
    }
}
