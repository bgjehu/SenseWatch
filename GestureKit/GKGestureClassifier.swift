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
    var thresholds = [Double]()
    
    var deltaThreshold = 0.0
    var costsQueue = [[Double]]()
    var costsQueueLength = 0
    
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
    
    init(gesturePatterns : [GKGesturePattern], searchRange : Int, thresholds : [Double], deltaThreshold : Double, costsQueueLength : Int) {
        if gesturePatterns.count > 0 && searchRange >= 0 && thresholds.count == gesturePatterns.count && deltaThreshold < 0 && costsQueueLength > 0 {
            if gesturePatterns.aligned() {
                self.gesturePatterns = gesturePatterns
                self.searchRange = searchRange
                self.thresholds = thresholds
                self.deltaThreshold = deltaThreshold
                self.costsQueueLength = costsQueueLength
                for _ in 0..<costsQueueLength {
                    self.costsQueue.append(Array(count: gesturePatterns.count, repeatedValue: 0.0))
                }
            } else {
                print("Error creating GKGestureClassifier: [GKGesturePattern] is not aligned")
            }
        } else {
            print("Error creating GKGestureClassifier with invalid argument: pattern count = \(gesturePatterns.count), searchRange = \(searchRange), threshold = \(thresholds), zeroOrderThreshold = \(deltaThreshold), queueLength = \(costsQueueLength)")
        }
    }
    
    func classify(testCase : GKGesturePattern) -> GKGesture? {
        if testCase.aligned(gesturePatterns[0]) {
//            let startTime = NSDate()
            var costs = gesturePatterns.map({pattern in GKUtilities.findCost(testCase, rhs: pattern, searchRange: searchRange)})
            
            //  cal delta costs
            var deltaCosts = [Double]()
            for i in 0..<costs.count {
                let delta = costs[i] - costsQueue[0][i]
                deltaCosts.append(delta)
                print("gesture \(gesturePatterns[i].name), cost:\(costs[i])")
                print("gesture \(gesturePatterns[i].name), Δcost:\(deltaCosts[i])")
            }
            //  update queue
            costsQueue.removeAtIndex(0)
            costsQueue.append(costs)
            
            //  test against threshold
            var indices = [Int]()
            for i in 0..<deltaCosts.count {
                if deltaCosts[i] < deltaThreshold && costs[i] < thresholds[i] {
                    indices.append(i)
                }
            }
            
            var maxDeltaCost = 0.0
            var resultIndex = -1
            for i in indices {
                if thresholds[i] - costs[i] > maxDeltaCost {
                    maxDeltaCost = thresholds[i] - costs[i]
                    resultIndex = i
                }
            }
//            print("Time for one classification: \(startTime.timeIntervalSinceNow * -1)")
            if resultIndex >= 0 {
                //  Have result
                print("NOTIFICATION__________\(gesturePatterns[resultIndex].name)__________GONNA BE POSTED!!!!!")
                return GKGesture(name: gesturePatterns[resultIndex].name)
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
            return GKGestureClassifier(gesturePatterns: [GKPredefinedGesturePattern.Up,GKPredefinedGesturePattern.Down,GKPredefinedGesturePattern.Left,GKPredefinedGesturePattern.Right], searchRange: 5, thresholds: [250.0,400.0,250.0,300.0], deltaThreshold: -60.0, costsQueueLength: 3)
        }
    }
}
