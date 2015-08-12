//
//  PhoneCommunicationController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import WatchConnectivity
import WatchKit

class GKSessionControllerWatch: NSObject, WCSessionDelegate {
    
    var session : WCSession! = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    override init(){
        
        super.init()
        
        if session == nil {
            print("WCSession is not supported")
        } else {
            //  set delegate
            session.delegate = self
            
            //  activate session
            session.activateSession()
            
            //  register notifications
            GKGesture.registerAllNotifications(self, selector: "sendGestureNotificationToHandheldDevice:")
            
        }
    }
    
    deinit{
        GKGesture.deregisterAllNotifications(self)
    }
    
    func sendGestureNotificationToHandheldDevice(notification : NSNotification){
        
        //  if WCSession is reachable
        if session!.reachable {     //  it is reachable
            if let gesture = GKGesture.fromNotification(notification) {
                session.sendMessage(gesture.sessionMessage, replyHandler: nil, errorHandler: nil)
                print("Watch send gesture \(gesture)")
            }
        } else{                     //  it is not reachable
            print("WCSession is not reachable")
        }
    }
}
