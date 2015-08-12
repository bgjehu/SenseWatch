//
//  GKGestureDataRecorder.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGestureDataRecorder: NSObject {
    
    var dataPoints = [[Double]]()
    var length : Int {
        get{
            return dataPoints.count
        }
    }
    var width : Int = 0
    init(width : Int) {
        super.init()
        if width > 0 {
            self.width = width
        } else {
            print("Error creating GKGestureDataRecorder with invalid argument: width = \(width)")
        }
    }
    
    func enque(dataPoint : [Double]) {
        if dataPoint.count == width {
            dataPoints.append(dataPoint)
        } else {
            print("Error enqueing unaligned data point: data point = \(dataPoint)")
        }
    }
    
    func createPattern(name : String) -> GKGesturePattern {
        return GKGesturePattern(name: name, dataPoints: dataPoints)
    }
    
    func reset(){
        dataPoints.removeAll()
    }
}
