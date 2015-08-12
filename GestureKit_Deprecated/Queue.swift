//
//  Queue.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class QNode {
    var object : NSMutableArray?
    var next : QNode?
}

public class Queue {
    
    init(length : Int){
        self.length = length
    }
    
    private var top: QNode! = QNode()
    let length : Int
    
    func enQueue(object: NSMutableArray) -> NSMutableArray {
        
        var deepCopy = NSMutableArray()
        var currentLength = 0
        func addToDeepCopy(obj : NSMutableArray) {
            let x = obj.objectAtIndex(0) as! Double
            let y = obj.objectAtIndex(1) as! Double
            let z = obj.objectAtIndex(2) as! Double
            deepCopy.addObject([x,y,z])
            currentLength++
        }
        
        if (top == nil) {
            top = QNode()
        }
        
        if (top.object == nil) {
            top.object = object;
            return deepCopy
        }
        
        var childToUse: QNode = QNode()
        var current: QNode = top
                
        while (current.next != nil) {
            current = current.next!
            
            addToDeepCopy(current.object!)
        }
        
        childToUse.object = object;
        current.next = childToUse;
        
        addToDeepCopy(current.object!)
        
        if currentLength > 70 {
            deQueue()
            currentLength--
        }
        
        return deepCopy
    }
    
    func deQueue() -> NSMutableArray? {
        let topitem: NSMutableArray? = self.top?.object
        if (topitem == nil) {
            return nil
        }
        var queueitem: NSMutableArray? = top.object!
        if let nextitem = top.next {
            top = nextitem
        } else {
            top = nil
        }
        return queueitem
    }
    func isEmpty() -> Bool {
        if let topitem: NSMutableArray = self.top?.object {
            return false
        } else {
            return true
        }
    }
}
