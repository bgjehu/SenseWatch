//
//  EKSlidesViewControllerProtocol.swift
//  Slider
//
//  Created by Jieyi Hu on 7/15/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

protocol EKSlidesViewControllerProtocol {
    
    var numberOfPages : Int {get set}
    var currentPage : Int {get set}
    var view : UIView {get}
    
    func loadFile(fileName : String)
    func gotoPage(pageNumber : Int)
    func nextPage()
    func prevPage()
    func firstPage()
    func finalPage()
}
