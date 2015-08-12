//
//  SliderGlobalVar.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 7/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

struct SliderGlobalVar {
    
    static var slidesViewRect : CGRect {
        get{
            let height = UIScreen.mainScreen().bounds.height
            let width = height / 3 * 4
            let x = (UIScreen.mainScreen().bounds.width - width) / 2
            let rect = CGRectMake(x, 0, width, height)
            return rect
        }
    }
    
    static var thumbnailSize : CGSize {
        get {
            return CGSizeMake(400, 300)
        }
    }
    
    static var appSliderContent : String {
        let docDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("Slides")
        return docDir
    }
    
    static var appSliderCache : String {
        let cacheDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("Slides")
        return cacheDir
    }
    
}




