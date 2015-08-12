//
//  GKGestureClassifier.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKGestureClassifier: NSObject {

    var gesturePatterns = [GKGesturePattern]()
    var searchRange = 0
    var threshold = 0.0
    var length : Int {
        if gesturePatterns.aligned() {
            return gesturePatterns[0].length
        } else {
            print("Error accessing [GKGesturePattern] length: [GKGesturePattern] is not aligned")
            return 0
        }
    }
    var width : Int {
        if gesturePatterns.aligned() {
            return gesturePatterns[0].width
        } else {
            print("Error accessing [GKGesturePattern] width: [GKGesturePattern] is not aligned")
            return 0
        }
    }
    var queue : GKGestureDataStoringQueue {
        get{
            return GKGestureDataStoringQueue(length: length, width: width)
        }
    }
    
    init(gesturePatterns : [GKGesturePattern], searchRange : Int, threshold : Double) {
        if gesturePatterns.count > 0 && searchRange >= 0 && threshold >= 0 {
            if gesturePatterns.aligned() {
                self.gesturePatterns = gesturePatterns
                self.searchRange = searchRange
                self.threshold = threshold
            } else {
                print("Error creating GKGestureClassifier: [GKGesturePattern] is not aligned")
            }
        } else {
            print("Error creating GKGestureClassifier: [GKGesturePattern] is empty")
        }
    }
    
    func classify(testCase : GKGesturePattern) -> GKGesture? {
        if testCase.aligned(gesturePatterns[0]) {
//            let startTime = NSDate()
            var cost = gesturePatterns.map({pattern in GKUtilities.findCost(testCase, rhs: pattern, searchRange: searchRange)})
            var minCost = DBL_MAX
            var resultIndex = -1
            for i in 0..<cost.count {
                print("gesture \(gesturePatterns[i].name), cost:\(cost[i])")
                if cost[i] < minCost {
                    minCost = cost[i]
                    resultIndex = i
                }
            }
//            print("Time for one classification: \(startTime.timeIntervalSinceNow * -1)")
            if resultIndex >= 0 {
                //  Have result
                return cost[resultIndex] < threshold ? GKGesture(name: gesturePatterns[resultIndex].name) : nil
            } else {
                return nil
            }
        } else {
//            print("Error classifying GKGesturePattern test case: test case does not align to classifier gesture patterns")
            return nil
        }
    }
}

class GKPredefinedGestureClassifier {
    static var UpDownLeftRight : GKGestureClassifier {
        get{
            return GKGestureClassifier(gesturePatterns: [GKPredefinedGesturePattern.Up,GKPredefinedGesturePattern.Down,GKPredefinedGesturePattern.Left,GKPredefinedGesturePattern.Right], searchRange: 5, threshold: 480.0)
        }
    }
}
