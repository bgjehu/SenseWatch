//
//  NativeClassExtensions.swift
//  Slider
//
//  Created by Jieyi Hu on 7/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

extension String {
    
    var filePath : String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath = path.stringByAppendingPathComponent(self)
        return filePath
    }
    
    var cachePath : String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let cachePath = path.stringByAppendingPathComponent(self) + ".cache"
        return cachePath
    }
    
    var fileTitle : String {
        let title = self.stringByDeletingPathExtension
        return title
    }
    
    var fileExtension : String {
        let ext = self.pathExtension
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
        if self.hasSuffix("pdf") || self.hasSuffix("ppt") || self.hasSuffix("pptx") {
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
extension UIImage {
    func resize(newSize : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize,false,0.0)
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    func resizeWithNewWidth(newWidth : CGFloat) -> UIImage {
        let newSize = CGSizeMake(newWidth, newWidth / self.size.width * self.size.height)
        return self.resize(newSize)
    }
    func resizeWithNewHeight(newHeight : CGFloat) -> UIImage {
        let newSize = CGSizeMake(newHeight / self.size.height * self.size.width, newHeight)
        return self.resize(newSize)
    }
}
extension UIWebView {
    
    var screenshot : UIImage {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.renderInContext(UIGraphicsGetCurrentContext())
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    var thumbnail : UIImage {
        let offSet = self.scrollView.contentOffset
        var thm : UIImage
        if offSet == CGPointMake(0, 0) {
            thm = self.screenshot.resize(GlobalVar.thumbnailSize)
        } else {
            self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            thm = self.screenshot.resize(GlobalVar.thumbnailSize)
            self.scrollView.setContentOffset(offSet, animated: false)
        }
        return thm
    }
    
    var numberOfPages : Int {
        let slideClassString = "<div class=\"slide\""
        let html = self.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
//        do{try html?.writeToFile(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("html.txt"), atomically: true, encoding: NSUTF8StringEncoding)}catch{}
        let count = (html?.componentsSeparatedByString(slideClassString).count)! - 1
        return count
    }
    
    func loadFile(fileName : String) {
        let url = fileName.URL
        let request = NSURLRequest(URL: url)
        self.loadRequest(request)
    }
    
    func removePageGap() {
        self.stringByEvaluatingJavaScriptFromString("var slides = document.getElementsByClassName('slide');var count = slides.length;for (var i = 1; i < count; i++) {var oldTop = slides[i].style.top;var newTop = parseInt(oldTop) - 5 * i + 'px';slides[i].style.top = newTop;}")
    }
    
}
extension CGPDFDocument {
    
    var numberOfPages : Int {
        let numberOfPages = CGPDFDocumentGetNumberOfPages(self)
        return numberOfPages
    }
    
    var thumbnail : UIImage {
        let thm = self.getPageImage(1, width: GlobalVar.thumbnailSize.width)
        return thm!
    }
    
    func getPageImage(pageNumber : Int, width : CGFloat) -> UIImage? {
        
        // http://stackoverflow.com/questions/4639781/rendering-a-cgpdfpage-into-a-uiimage
        
        if pageNumber <= self.numberOfPages {
            //  Get the page
            let page = CGPDFDocumentGetPage(self, pageNumber)
            
            var pageRect = CGPDFPageGetBoxRect(page, CGPDFBox.MediaBox)
            
            if width < pageRect.width {
                pageRect =  CGRectMake(0, 0, width, width / 4 * 3)
            } else {}
            
            //  Set up box and rect
            
            UIGraphicsBeginImageContext(pageRect.size)
            
            let context = UIGraphicsGetCurrentContext()
            
            //  White Background
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextFillRect(context, pageRect)
            CGContextSaveGState(context)
            
            // Next 3 lines makes the rotations so that the page look in the right direction
            CGContextTranslateCTM(context, 0.0, pageRect.size.height)
            CGContextScaleCTM(context, 1.0, -1.0)
            CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(page, CGPDFBox.MediaBox, pageRect, 0, true))
            
            
            CGContextDrawPDFPage(context, page)
            CGContextRestoreGState(context)
            
            let img = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return img
            
        } else {
            return nil
        }
    }
}

extension UIColor {
    func getRGBAf() -> (red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) {
        var rgba = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        return (rgba[0],rgba[1],rgba[2],rgba[3])
    }
//    func getRGBA() -> (red : Int, green : Int, blue : Int, alpha : Int) {
//        let r = Int(self.getRGBAf().red * 255)
//        let g = Int(self.getRGBAf().green * 255)
//        let b = Int(self.getRGBAf().blue * 255)
//        let a = Int(self.getRGBAf().alpha * 255)
//        return (r,g,b,a)
//    }
//    convenience init(r: Int, g:Int , b:Int , a: Int) {
//        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
//    }
}
