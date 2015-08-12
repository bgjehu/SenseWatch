//
//  WatchCommunicationController.swift
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
class GKSessionControllerHandheld: NSObject, WCSessionDelegate {
    
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
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        //retrieve info
        let type = message["Type"] as! String
        let content = message["Content"]
        
        switch type {
            
            case "Gesture":
                handleGestureContent(content)
            default:
                print("Received message \(message) is invalid with type of \(type)")
            
        }

    }
    
    func handleGestureContent(content : AnyObject?) {
        
        if let gestureString = content as? String {
            if let gesture = GKGesture(rawValue: gestureString) {
                print("Handheld device receives \(gesture)")
                gesture.postNotification()
            }
        }
    }
}
