//
//  EKSlideInfo.swift
//  Slider
//
//  Created by Jieyi Hu on 7/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class EKSlidesCache {
    
    let dataStringEncoding = NSUTF8StringEncoding
    let stringFileEncoding = NSUTF8StringEncoding
    var fileName : String = ""
    
    var thumbnail : UIImage!
    var numberOfPages : Int = 0
    
    var exist : Bool = false
    
    init?(fileName : String) {
        
        self.fileName = fileName
        
        if NSFileManager.defaultManager().fileExistsAtPath(self.fileName.cachePath) {
            do{
                let jsonStr = try String(contentsOfFile: self.fileName.cachePath, encoding: self.stringFileEncoding)
                let jsonData = jsonStr.dataUsingEncoding(self.dataStringEncoding)
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments)
                let info = jsonObject as! [String : String]
                self.thumbnail = UIImage(data: NSData(base64EncodedString: info["Thumbnail"]!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!)
                self.numberOfPages = Int(info["NumberOfPages"]!)!
                self.exist = true
            } catch let error as NSError {
                print(error)
                self.exist = false
                return nil
            }
        } else {
            self.exist = false
        }
    }
    
    func createCache() {
        var info : [String : String] = [:]
        info["NumberOfPages"] = String(numberOfPages)
        info["Thumbnail"] = UIImagePNGRepresentation(thumbnail)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(info, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonStr = NSString(data: jsonData, encoding: dataStringEncoding)
            try jsonStr?.writeToFile(fileName.cachePath, atomically: true, encoding: stringFileEncoding)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateCache(numberOfPages : Int, thumbnail : UIImage) {
        self.numberOfPages = numberOfPages
        self.thumbnail = thumbnail
        createCache()
    }
    
    func updatePDFCache(){
        if let pdf =  fileName.PDF {
            numberOfPages = pdf.numberOfPages
            thumbnail =  pdf.thumbnail
            createCache()
        }
    }
}
