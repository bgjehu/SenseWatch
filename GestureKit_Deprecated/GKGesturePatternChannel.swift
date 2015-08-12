//
//  GKGesturePatternChannel.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/5/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGesturePatternChannel: NSObject {

    var dataSet : NSMutableArray!
    var length : Int!
    var width : Int!
    var full : Bool = false
    
    init(length : Int, width : Int){
        super.init()
        if length > 0 && width > 0{
            self.length = length
            self.width = width
            self.dataSet = NSMutableArray()
        } else {
            print("\(self) is given invalid argument: (length,width) = (\(length),\(width))")
        }
    }
    
    func enqueue(dataPoint : [Double]?) {
        if let dataPoint = dataPoint {
            //  not nil
            let width = dataPoint.count
            if width == self.width {
                //  only act on valid input data points
                if self.full {
                    //  dequeue oldest data point
//                    for index in 0..<width {
//                        dataSet[index].removeAtIndex(0)
//                    }
                    dataSet.removeObjectAtIndex(0)
                }
                //  enqueue new data point
//                for index in 0..<width {
//                    dataSet[index].append(dataPoint[index])
//                }
                dataSet.addObject(dataPoint)
                
                //  update state
//                let currentLength = dataSet[0].count
//                if currentLength == length {
//                    full = true
//                } else if currentLength < length {
//                    full = false
//                } else {
//                    print("\(self) is overloaded")
//                }
                print(dataSet.count)
                if dataSet.count >= length {
                    full = true
                }
            }
        }
    }
    
    func createPattern(withName name : String?) -> GKGesturePattern? {
        if full {
            let pattern = GKGesturePattern(name: name, dataSet: self.dataSet)
            return pattern
        }
        else{
            return nil
        }
    }
}
