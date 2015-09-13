//
//  SliderPathObjects.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 7/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit


class SliderPathObjects: NSObject {
    
    let fileName : String
    init(fileName : String) {
        self.fileName = fileName
    }
    
    var filePath : String {
        let path = SliderGlobalVar.appSliderContent
        let filePath = (path as NSString).stringByAppendingPathComponent(fileName)
        return filePath
    }
    
    var cachePath : String {
        let path = SliderGlobalVar.appSliderCache
        let cachePath = (path as NSString).stringByAppendingPathComponent(fileName) + ".cache"
        return cachePath
    }
    
    var fileTitle : String {
        let title = (fileName as NSString).stringByDeletingPathExtension
        return title
    }
    
    var fileExtension : String {
        let ext = (fileName as NSString).pathExtension
        return ext
    }
    
    var URL : NSURL {
        let filePath = self.filePath
        let url = NSURL(fileURLWithPath: filePath)
        return url
    }
    
    var PDF : CGPDFDocument? {
        let url = self.URL
        let pdf = CGPDFDocumentCreateWithURL(url)
        return pdf
    }
    
    var fileCreationDate : NSDate? {
        let date = self.getFileDate(NSFileCreationDate)
        return date
    }
    
    var fileModificationDate : NSDate? {
        let date = self.getFileDate(NSFileModificationDate)
        return date
    }
    
    func isSlidesFile() -> Bool {
        if fileName.hasSuffix("pdf") || fileName.hasSuffix("ppt") || fileName.hasSuffix("pptx") {
            return true
        } else {
            return false
        }
    }
    
    func getFileDate(kindOfDate : String) -> NSDate? {
        let filePath = self.filePath
        do {
            //  get attributes of the file
            let attrs = try NSFileManager.defaultManager().attributesOfItemAtPath(filePath)
            //  get date string
            let dateString = attrs[kindOfDate]!.description
            //  turn string to NSDate
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.dateFromString(dateString.stringByReplacingOccurrencesOfString(" +0000", withString: ""))
            //  return NSDate
            return date
        } catch let error as NSError {
            print(error)
            return nil
        }
        
    }
 
    
}

