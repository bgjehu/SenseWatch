//
//  GKGestureModel.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/4/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import CoreMotion

class GKGesturePattern: NSObject {
    
    var dataSet = [[Int]]()
    var length : Int!
    var width : Int!
    var name : String!
    var type : String!
    var fullyLoaded = false
    
    var initializedCostTable : [[Double]] {
        get{
            var costTable = [[Double]]()
            for _ in 0...length {
                costTable.append(Array(count: length + 1, repeatedValue: DBL_MAX))
            }
            costTable[0][0] = 0
            return costTable
        }
    }
    init?(length : Int, width : Int) {
        super.init()
        if length > 0 && width > 0{
            self.length = length
            self.width = width
            for _ in 0...self.width - 1 {
                dataSet.append([Int]())
            }
        } else {
            print("\(self) is given invalid argument: (length,width) = (\(length),\(width))")
            return nil
        }
    }
    
    init(name : String?, type: String?, dataSet : [[Int]]){
        super.init()
        self.name = name
        self.type = type
        self.dataSet = dataSet
        self.width = dataSet.count
        self.length = dataSet[0].count
        self.fullyLoaded = true
    }
    
    init(name : String?, type: String?, dataSetf : [[Double]]){
        super.init()
        self.name = name
        self.type = type
        self.dataSet = dataSetf.map({numbers in numbers.map({number in Int(round(number / 0.1))})})
        self.width = dataSetf.count
        self.length = dataSetf[0].count
        self.fullyLoaded = true
    }
    
    func enqueue(dataPoint data : [Int]) {
        if data.count == width {
            if fullyLoaded {
                dequeue()
            }
            for index in 0...width - 1 {
                dataSet[index].append(data[index])
            }
            if dataSet[0].count == length {
                fullyLoaded = true
            } else if dataSet[0].count < length {
                fullyLoaded = false
            } else {
                print("\(self) is overloaded")
            }
        }
    }
    
    func enqueue(accelerometerData data : CMAccelerometerData?) {
        if data != nil {
            self.enqueue(dataPoint: data!.quantizedData)
        }
    }
    
    private func dequeue() {
        for index in 0...width - 1 {
            dataSet[index].removeAtIndex(0)
        }
    }
    
    func findCost(testCase : GKGesturePattern, searchRange : Int) -> Double {
        if self.fullyLoaded && testCase.fullyLoaded && self.length == testCase.length && self.width == testCase.width {
            var costTable = initializedCostTable
            for i in 1...length {
                for j in max(1,i - searchRange)...min(length,i + searchRange) {
                    costTable[i][j] = dist(testCase, modelIndex: i - 1, testCaseIndex: j - 1) + [costTable[i][j-1],costTable[i-1][j],costTable[i-1][j-1]].reduce(DBL_MAX, combine: {min($0, $1)})
                }
            }
            var minDist = 0
            var finalMin = costTable[length][length]
            for index in 1...searchRange {
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
    }
    
    private func dist(testCase : GKGesturePattern, modelIndex : Int, testCaseIndex : Int) -> Double {
        var dist = 0.0
        for index in 0...self.width - 1 {
            dist += pow(Double(self.dataSet[index][modelIndex] - testCase.dataSet[index][testCaseIndex]), 2)
        }
        dist = sqrt(dist)
        return dist
    }
}

extension CMAccelerometerData {
    var quantizedData : [Int] {
        get{
            let data = [Int(round(self.acceleration.x / 0.1)),Int(round(self.acceleration.y / 0.1)),Int(round(self.acceleration.z / 0.1))]
            return data
        }
    }
}