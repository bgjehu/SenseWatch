//
//  EKSlidesViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

enum SlidesViewControllerMode : Int {
    case None = 0, PDF, PPT
}

class SlidesWebAndImageViewsController: NSObject {
    
    var PPTCtrl = SlidesWebViewController()
    var PDFCtrl = SlidesImageViewController()
    var mode : SlidesViewControllerMode = .None
    var view : UIView! {
        get{
            switch mode {
                
            case .None:
                return nil
            case .PDF:
                return PDFCtrl.view
            case .PPT:
                return PPTCtrl.view
            }
        }
    }
    var currentPage : Int! {
        get{
            switch mode {
                
            case .None:
                return nil
            case .PDF:
                return PDFCtrl.currentPage
            case .PPT:
                return PPTCtrl.currentPage
            }
        }
    }
    
    func loadFile(fileName: String) {
        if fileName.hasSuffix("pdf") {
            mode = .PDF
            PDFCtrl.loadFile(fileName)
        } else {
            mode = .PPT
            PPTCtrl.loadFile(fileName)
        }
    }
    
    
    func nextPage(){
        switch mode {
            
        case .PDF:
            PDFCtrl.nextPage()
        case .PPT:
            PPTCtrl.nextPage()
        case .None:break
        }
    }
    func prevPage(){
        switch mode {
            
        case .PDF:
            PDFCtrl.prevPage()
        case .PPT:
            PPTCtrl.prevPage()
        case .None:break
        }
    }
    func firstPage(){
        switch mode {
            
        case .PDF:
            PDFCtrl.firstPage()
        case .PPT:
            PPTCtrl.firstPage()
        case .None:break
        }
    }
    func finalPage(){
        switch mode {
            
        case .PDF:
            PDFCtrl.finalPage()
        case .PPT:
            PPTCtrl.finalPage()
        case .None:break
        }
    }
}
