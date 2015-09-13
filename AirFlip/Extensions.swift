//
//  NativeClassExtensions.swift
//  Slider
//
//  Created by Jieyi Hu on 7/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

extension String {
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
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func thumbnail(size : CGSize) -> UIImage {
        let offSet = self.scrollView.contentOffset
        var thm : UIImage
        if offSet == CGPointMake(0, 0) {
            thm = self.screenshot.resize(size)
        } else {
            self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            thm = self.screenshot.resize(size)
            self.scrollView.setContentOffset(offSet, animated: false)
        }
        return thm
    }
}
extension CGPDFDocument {
    
    var numberOfPages : Int {
        let numberOfPages = CGPDFDocumentGetNumberOfPages(self)
        return numberOfPages
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
    func getRGBA() -> (red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) {
        var rgba = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        return (rgba[0],rgba[1],rgba[2],rgba[3])
    }
    func getHSBA() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hsba = [CGFloat](count: 4, repeatedValue: 0.0)
        self.getHue(&hsba[0], saturation: &hsba[1], brightness: &hsba[2], alpha: &hsba[3])
        return (hsba[0],hsba[1],hsba[2],hsba[3])
    }
}

extension UIDevice {
    enum UIDeviceModel : String {
        case iPhone4 = "iPhone4"
        case iPhone5 = "iPhone5"
        case iPhone6 = "iPhone6"
        case iPhone6p = "iPhone6p"
        case iPad = "iPad"
        case unknown = "unknown"
    }
    static var currectDeviceByScreenSize : UIDeviceModel {
        let bounds = UIScreen.mainScreen().bounds
        let resolution = bounds.width * bounds.height
        switch resolution {
        case 153600:
            return UIDeviceModel.iPhone4
        case 181760:
            return UIDeviceModel.iPhone5
        case 250125:
            return UIDeviceModel.iPhone6
        case 304704:
            return UIDeviceModel.iPhone6p
        case 786432:
            return UIDeviceModel.iPad
        default:
            return UIDeviceModel.unknown
        }
    }
}
