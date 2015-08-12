//
//  GKGesturePattern.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/5/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

struct GKGesturePattern {
    
    var name : String?
    let dataSet : [[Double]]!
    var length : Int {              //  number of data points
        get{
            if let dataSet = self.dataSet {
                let length = dataSet.count
                return length
            } else {
                return 0
            }
        }
    }
    var width : Int {               //  number of attributes
        get{
            if self.length > 0 {
                let width = self.dataSet[length - 1].count
                return width
            } else {
                return 0
            }
        }
    }
                                    /*  
                                        for example: one gesture has 100 data points of x, y, z accelerometer data
                                        this pattern has length of 100 and width of 3
                                    */
    
    init(name : String?, dataSet : [[Double]]?) {
        self.dataSet = dataSet
        self.name = name
        if self.length <= 0 {
            print("Error: empty data set is given.")
        }
    }
    
    func cost(withComparingPattern pattern : GKGesturePattern?, usingSearchRange range : Int) -> Double {
        if let pattern = pattern {
            //  not nil
            if self.length == pattern.length && self.width == pattern.width {
                var costTable = self.initCostTable(withLength: self.length)
                for i in 1...length {
                    for j in max(1,i - range)...min(length,i + range) {
                        costTable[i][j] = distance(withComparingPattern: pattern, currentPatternIndex: i - 1, comparingPatternIndex: j - 1) + [costTable[i][j-1],costTable[i-1][j],costTable[i-1][j-1]].reduce(DBL_MAX, combine: {min($0, $1)})
                    }
                }
                var minDist = 0
                var finalMin = costTable[length][length]
                for index in 1...range {
                    let newMin = min(costTable[length][length - index], costTable[length - index][length])
                    if  newMin < finalMin {
                        minDist = index
                        finalMin = newMin
                    }
                }
                return finalMin + Double(minDist)
            } else {
                return DBL_MAX
            }
        } else {
            return DBL_MAX
        }
    }
    
    private func distance(withComparingPattern pattern: GKGesturePattern, currentPatternIndex : Int, comparingPatternIndex : Int) -> Double {
        var distance = 0.0
        for index in 0..<self.width {
            distance += pow(Double(self.dataSet[currentPatternIndex][index] - pattern.dataSet[comparingPatternIndex][index]), 2)
        }
        distance = sqrt(distance)
        return distance
    }
    
    private func initCostTable(withLength length: Int) -> [[Double]] {
        var costTable = [[Double]]()
        for _ in 0...length {
            costTable.append(Array(count: length + 1, repeatedValue: DBL_MAX))
        }
        costTable[0][0] = 0
        return costTable
    }
    
    func dimensionAligned(withPattern pattern: GKGesturePattern?) -> Bool {
        if let pattern = pattern {
            if self.length == pattern.length && self.width == pattern.width {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
