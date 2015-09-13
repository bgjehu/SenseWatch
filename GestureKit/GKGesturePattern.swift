//
//  GKGesturePattern.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGesturePattern: NSObject {
    
    var name : String = ""
    var dataPoints = [[Double]]()
    var length : Int {
        get{
            return dataPoints.count
        }
    }
    var width : Int {
        get{
            if dataPoints.count > 0 {
                return dataPoints[0].count
            } else {
                print("Error accessing width: GKGesturePattern is empty")
                return 0
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    init(dataPoints : [[Double]]){
        super.init()
        self.dataPoints = dataPoints
    }
    
    init(name : String, dataPoints : [[Double]]) {
        self.name = name
        self.dataPoints = dataPoints
    }
    
    func aligned(rhs : GKGesturePattern) -> Bool {
        return self.length == rhs.length && self.width == rhs.width
    }
    
    func saveLocally() {
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dataPoints, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonStr = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
            let fileName = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("\(name).gest")
            try jsonStr?.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error)
        }
    }
}

class GKPredefinedGesturePattern {
    static var Up : GKGesturePattern {
        get{
            return GKGesturePattern(name: "Up", dataPoints:   [[3,-7,5],[5,-7,5],[5,-6,7],[5,-6,8],[5,-6,9],[4,-7,11],[4,-7,16],[6,-7,22],[11,-8,26],[19,-9,27],[22,-5,23],[21,-3,15],[19,-1,7],[15,-3,1],[11,1,-2],[8,3,-8],[1,2,-11],[-5,4,-13],[-8,3,-10],[-9,2,-3],[-11,-2,3],[-11,-4,6],[-10,-6,5],[-9,-6,5],[-9,-5,6]])
        }
    }
    static var Down : GKGesturePattern {
        get{
            return GKGesturePattern(name: "Down", dataPoints: [[8,-12,6],[15,-14,9],[18,-15,10],[17,-16,0],[18,-19,-12],[18,-19,-8],[18,-14,-5],[17,-10,-9],[14,-6,-10],[10,0,-4],[6,3,1],[3,5,2],[1,4,1],[-1,3,1],[-1,2,2],[0,0,4],[1,-1,4],[2,-1,7],[4,-7,14],[13,-18,14],[23,-15,16],[19,-23,13],[13,-22,-2],[9,-18,-9],[10,-15,-7]])
        }
    }
    static var Left : GKGesturePattern {
        get{
            return GKGesturePattern(name: "Left", dataPoints:  [[2,-6,-9],[2,-6,-9],[3,-6,-10],[3,-5,-9],[3,-4,-9],[3,-2,-8],[4,0,-9],[4,2,-9],[4,5,-9],[5,9,-10],[6,16,-14],[9,19,-13],[13,15,-10],[23,3,-11],[28,-7,-8],[24,-10,-4],[14,-18,0],[7,-14,-1],[7,-8,-3],[3,-11,-2],[0,-10,-3],[0,-6,-6],[-2,-6,-7],[-2,-7,-6],[-2,-7,-6]])
        }
    }
    static var Right : GKGesturePattern {
        get{
            return GKGesturePattern(name: "Right", dataPoints: [[1,-7,-6],[0,-7,-7],[-1,-7,-6],[-1,-7,-4],[-1,-9,-3],[1,-9,0],[1,-10,8],[9,-22,7],[21,-28,0],[21,-13,2],[22,-5,-7],[16,3,-14],[8,-11,-9],[6,12,-8],[9,3,-15],[3,2,-10],[1,1,-7],[-1,-3,-7],[-2,-5,-8],[-2,-6,-8],[-1,-6,-8],[-1,-7,-8],[-1,-7,-8],[-1,-6,-8],[-1,-6,-8]])
        }
    }
}
