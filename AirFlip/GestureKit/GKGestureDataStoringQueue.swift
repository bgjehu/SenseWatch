//
//  GKGestureDataStoringQueue.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGestureDataStoringQueue: NSObject {
    
    var dataPoints = [[Double]]()
    var length = 0
    var width = 0
    var full = false
    
    init(length : Int, width : Int) {
        super.init()
        if length > 0 && width > 0{
            self.length = length
            self.width = width
        } else {
            print("Error creating GKGestureDataStoringQueue with invalid argument: (length,width) = (\(length),\(width))")
        }
    }
    
    func enque(dataPoint : [Double]) -> GKGesturePattern {
        if dataPoint.count == width {
            if full {
                dataPoints.removeAtIndex(0)
            } else {
                //  Do nothing
            }
            dataPoints.append(dataPoint)
            if dataPoints.count == length {
                full = true
            } else if dataPoints.count > length {
                print("Error enqueing data point: Queue overloaded with \(dataPoints.count - length) instances")
            }
            return GKGesturePattern(dataPoints: dataPoints)
        } else {
            print("Error enqueing unaligned data point: data point = \(dataPoint)")
            return GKGesturePattern()
        }
    }
}
