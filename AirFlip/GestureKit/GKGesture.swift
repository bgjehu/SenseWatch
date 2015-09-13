//
//  GKGesture.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGesture : NSObject {
    
    var name : String
    var notificationName : String {
        get{
            return "GESTURE_KIT_NOTIFICATION_GESTURE_\(name.uppercaseString)"
        }
    }
    var notification : NSNotification {
        get{
            return NSNotification(name: notificationName, object: nil)
        }
    }
    
    init(name : String) {
        self.name = name
    }
    
    func registerNotification(observer : AnyObject, selector : Selector) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: notificationName, object: nil)
    }
    
    func deregisterNotification(observer : AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: notificationName, object: nil)
    }
    
    func postNotification(){
        NSNotificationCenter.defaultCenter().postNotification(self.notification)
//        print("Gesture \(name) is picked up. Notification posted!")
    }
}

class GKPredefinedGesture {
    
    static var stringValues : [String] {
        get{
            return ["Up","Down","Left","Right","Push"]
        }
    }
    
    static var All : [GKGesture] {
        get{
            return GKPredefinedGesture.stringValues.map({name in GKGesture(name: name)})
        }
    }
    
    static var Up : GKGesture {
        get{
            return GKGesture(name: "Up")
        }
    }
    static var Down : GKGesture {
        get{
            return GKGesture(name: "Down")
        }
    }
    static var Left : GKGesture {
        get{
            return GKGesture(name: "Left")
        }
    }
    static var Right : GKGesture {
        get{
            return GKGesture(name: "Right")
        }
    }
    static var Push : GKGesture {
        get{
            return GKGesture(name: "Push")
        }
    }
    
    static func registerAllNotifications(observer : AnyObject, selector : Selector) {
        for gesture in GKPredefinedGesture.All {
            gesture.registerNotification(observer, selector: selector)
        }
    }
    
    static func deregisterAllNotifications(observer : AnyObject) {
        for gesture in GKPredefinedGesture.All {
            gesture.deregisterNotification(observer)
        }
    }
}
