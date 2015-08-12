//
//  EKSlidesImageViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class SlidesImageViewController: NSObject, SlidesViewControllerProtocol {
    
    var fileName : String = ""
    var numberOfPages : Int = 0
    var currentPage : Int = 0
    var PDF : CGPDFDocument! = nil
    var imageView : UIImageView! = UIImageView(frame: SliderGlobalVar.slidesViewRect)
    var view : UIView {
        get{
            return imageView
        }
    }
    
    func loadFile(fileName: String) {
        self.fileName = fileName
        self.PDF = self.fileName.appSliderPathObjects.PDF
        numberOfPages = self.PDF.numberOfPages
        firstPage()
    }
    
    
    func gotoPage(pageNumber : Int){
        if pageNumber >= 1 && pageNumber <= numberOfPages {
            currentPage = pageNumber
            imageView.image = PDF.getPageImage(currentPage, width: 768)
        }
    }
    func nextPage(){
        gotoPage(currentPage + 1)
    }
    func prevPage(){
        gotoPage(currentPage - 1)
    }
    func firstPage(){
        gotoPage(1)
    }
    func finalPage(){
        gotoPage(numberOfPages)
    }
    
    
}
