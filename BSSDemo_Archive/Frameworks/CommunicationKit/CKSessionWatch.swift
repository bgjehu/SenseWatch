//
//  CKSessionWatch.swift
//  Slider
//
//  Created by Jieyi Hu on 7/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import WatchConnectivity
import WatchKit

class CKSessionWatch: NSObject, WCSessionDelegate {
    
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
}
