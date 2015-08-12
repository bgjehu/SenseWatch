//
//  GKGesturePatternRecorder.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/5/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGesturePatternRecorder: NSObject {
    
    private var dataSet : [[Double]]!
    var length : Int {
        get{
            //  if dataSet is nil or dataSet has invalid width, BROKE!
            return dataSet[0].count
        }
    }
    var width : Int {
        get{
            //  if dataSet is nil, BROKE!
            return dataSet.count
        }
    }
    
    
    init(width : Int) {
        super.init()
        if width > 0 {
            self.dataSet = [[Double]]()
            for _ in 0..<width {
                dataSet.append([Double]())
            }
        } else {
            print("\(self) is given an invalid argument width = \(width)")
        }
    }
    
    func enqueue(dataPoint : [Double]?) {
        if let dataPoint = dataPoint {
            //  not nil
            if width == dataPoint.count {
                //  only action on valid data points (having the same width)
                for index in 0..<width {
                    dataSet[index].append(dataPoint[index])
                }
            } else {
                //  invalid state
                //  no action
                print("\(self) is given an invalid argument dataPoint = \(dataPoint)")
            }
        }
    }
    
    func createPattern(withName name : String?) -> GKGesturePattern {
        let pattern = GKGesturePattern(name: name, dataSet: self.dataSet)
        return pattern
    }
}
