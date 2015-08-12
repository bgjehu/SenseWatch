//
//  GKUtilities.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class GKUtilities: NSObject {
    
    static func findCost(lhs : GKGesturePattern, rhs : GKGesturePattern, searchRange : Int) -> Double {
        if lhs.aligned(rhs) {
            let length = lhs.length
            
//            let startTime = NSDate()
            //  Create cost table
            var costTable = GKUtilities.initCostTable(length)

            //  Fill cost table
            for i in 1...length {
                for j in max(1,i - searchRange)...min(length,i + searchRange) {
                    costTable[i][j] = GKUtilities.findDistance(lhs, rhs: rhs, lhsIndex: i-1, rhsIndex: i-1) + [costTable[i][j-1],costTable[i-1][j],costTable[i-1][j-1]].reduce(DBL_MAX, combine: {min($0, $1)})
                }
            }
            
            //  Calculate Cost
            var minDist = 0
            var finalMin = costTable[length][length]
            for index in 1...searchRange {
                let newMin = min(costTable[length][length - index], costTable[length - index][length])
                if  newMin < finalMin {
                    minDist = index
                    finalMin = newMin
                }
            }
//            print("Cal Cost Time: \(startTime.timeIntervalSinceNow * -1)")
            return finalMin + Double(minDist)
        } else {
            print("Error finding cost of GKGesturePatterns: GKGesturePatterns do not align")
            return DBL_MAX
        }
    }
    
    static func findDistance(lhs : GKGesturePattern, rhs : GKGesturePattern, lhsIndex : Int, rhsIndex : Int) -> Double {
        if lhsIndex < lhs.length && rhsIndex < rhs.length {
            if lhs.aligned(rhs) {
//                let startTime = NSDate()
                var dist = 0.0
                for i in 0..<lhs.width {
                    dist += pow(Double(lhs.dataPoints[lhsIndex][i] - rhs.dataPoints[rhsIndex][i]), 2)
                }
                dist = sqrt(dist)
//                print("Cal Dist Time: \(startTime.timeIntervalSinceNow * -1)")
                return dist
            } else {
                print("Error finding distance of GKGesturePattern data points: GKGesturePatterns do not align")
                return 0
            }
        } else {
            print("Error finding distance of GKGesturePattern data points: index is out of range")
            return 0
        }
    }
    
    static func initCostTable(length : Int) -> [[Double]] {
        var costTable = [[Double]]()
        let tableLength = length + 1
        for _ in 0..<tableLength {
            costTable.append(Array(count: tableLength, repeatedValue: DBL_MAX))
        }
        costTable[0][0] = 0
        return costTable
    }
    
    static func quantize(data : MSBSensorAccelerometerData) -> [Double] {
        return [data.x,data.y,data.z].map({num in round(num / 0.1)})
    }

}

extension CollectionType where Generator.Element == GKGesturePattern {
    func aligned() -> Bool {
        if self.count > 0 {
            for index in startIndex..<endIndex {
                if !self[index].aligned(self[startIndex]) {
                    return false
                }
                //  checked current pattern
            }
            //  checked all patterns
            return true
        } else {
            print("Error determine alignment of [GKGesturePattern]: no GKGesturePattern")
            return false
        }
    }
}


