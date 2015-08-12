//
//  SliderExtension.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 7/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

extension UIWebView {
    
    var numberOfPages : Int {
        let slideClassString = "<div class=\"slide\""
        let html = self.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
        let count = (html?.componentsSeparatedByString(slideClassString).count)! - 1
        return count
    }
    
    func loadFile(fileName : String) {
        let url = fileName.appSliderPathObjects.URL
        let request = NSURLRequest(URL: url)
        self.loadRequest(request)
    }
    
    func removePageGap() {
        self.stringByEvaluatingJavaScriptFromString("var slides = document.getElementsByClassName('slide');var count = slides.length;for (var i = 1; i < count; i++) {var oldTop = slides[i].style.top;var newTop = parseInt(oldTop) - 5 * i + 'px';slides[i].style.top = newTop;}")
    }
}

extension String {
    var appSliderPathObjects : SliderPathObjects {
        get{
            return SliderPathObjects(fileName: self)
        }
    }
}
