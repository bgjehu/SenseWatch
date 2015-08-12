//
//  GKGesture.swift
//  Slider
//
//  Created by Jieyi Hu on 7/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

enum GKGesture: String {
    case Push = "Push"
    case Left = "Left"
    case Right = "Right"
    case Up = "Up"
    case Down = "Down"
    
    static var allValues : [String] {
        get{
            return ["Push","Left","Right","Up","Down"]
        }
    }
    
    var userInfo : [String : String] {
        get{
            return ["Gesture" : self.rawValue]
        }
    }
    
    var notification : NSNotification {
        get{
            return NSNotification(name: notificationName, object: nil, userInfo: userInfo)
        }
    }
    
    var notificationName : String {
        get{
            return "GKGESTURE_\(self.rawValue.uppercaseString)_NOTIFICATION"
        }
    }
    
    func registerNotification(observer : AnyObject, selector : Selector) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: notificationName, object: nil)
    }
    
    func deregisterNotification(observer : AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: notificationName, object: nil)
    }
    
    func postNotification(){
        NSNotificationCenter.defaultCenter().postNotification(self.notification)
    }
    
    var sessionMessage : [String : String] {
        get{
            return [
                "Type":"Gesture",
                "Content":self.rawValue,
            ]

        }
    }
    
    static func registerAllNotifications(observer : AnyObject, selector : Selector) {
        for value in allValues {
            NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: GKGesture(rawValue: value)!.notificationName, object: nil)
        }
    }
    
    static func deregisterAllNotifications(observer : AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    static func fromNotification(notification : NSNotification) -> GKGesture? {
        switch notification.name {
        case GKGesture.Push.notificationName:
            return GKGesture.Push
        case GKGesture.Left.notificationName:
            return GKGesture.Left
        case GKGesture.Right.notificationName:
            return GKGesture.Right
        case GKGesture.Up.notificationName:
            return GKGesture.Up
        case GKGesture.Down.notificationName:
            return GKGesture.Down
        default:return nil
        }
    }
}

