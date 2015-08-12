//
//  EKSlidesWebViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class EKSlidesWebViewController: NSObject, EKSlidesViewControllerProtocol, UIWebViewDelegate {
    
    var fileName : String = ""
    var numberOfPages : Int = 0
    var currentPage : Int = 0
    var webView : UIWebView! = UIWebView(frame: GlobalVar.slidesViewRect)
    var view : UIView {
        get{
            return webView as UIView
        }
    }
    
    func loadFile(fileName: String) {
        self.fileName = fileName
        webView.delegate = self
        webView.scalesPageToFit = true
        webView.loadFile(self.fileName)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.removePageGap()
        numberOfPages = webView.numberOfPages
        currentPage = 1
        EKSlidesCache(fileName: fileName)?.updateCache(numberOfPages, thumbnail: webView.thumbnail)
    }
    
    func gotoPage(pageNumber : Int){
        if pageNumber >= 1 && pageNumber <= numberOfPages {
            currentPage = pageNumber
            webView.scrollView.setContentOffset(CGPointMake(0, CGFloat(currentPage - 1) * GlobalVar.slidesViewRect.height) , animated: false)
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
