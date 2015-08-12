//
//  SlidesViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/12/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class SlidesViewController: UIViewController {

    var slidesViewCtrl : EKSlidesViewController = EKSlidesViewController()
    var sessionCtrl : GKSessionControllerH = GKSessionControllerH()
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //  register notifications
        registerNotification()
        
        //  load slides
//        slidesViewCtrl.loadSlides("ObjectiveC.pdf")
        
        //        locateSimulatorFolder()
    }
    
    func loadFile(fileName : String){
        slidesViewCtrl.loadFile(fileName)
        self.view.addSubview(slidesViewCtrl.view)
    }
    
    func locateSimulatorFolder() {
        let path : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let txt = ""
        
        do{
            try txt.writeToFile(path.stringByAppendingPathComponent("hello.txt"), atomically: true, encoding: NSUTF8StringEncoding)
            print("write out file")
        }
        catch let error as NSError {
            print("\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerNotification() {
        
        GKGesture.Up.registerNotification(self, selector: "gestureUpHandler")
        GKGesture.Down.registerNotification(self, selector: "gestureDownHandler")
        GKGesture.Left.registerNotification(self, selector: "gestureLeftHandler")
        GKGesture.Right.registerNotification(self, selector: "gestureRightHandler")
        GKGesture.Push.registerNotification(self, selector: "gesturePushHandler")
        
    }
    
    
    //  gesture Handlers
    func gestureUpHandler() {
        dispatch_async(dispatch_get_main_queue()) {
            self.slidesViewCtrl.prevPage()
        }
    }
    func gestureDownHandler() {
        dispatch_async(dispatch_get_main_queue()) {
            self.slidesViewCtrl.nextPage()
        }
    }
    func gestureLeftHandler() {
        dispatch_async(dispatch_get_main_queue()) {
            self.slidesViewCtrl.prevPage()
        }
    }
    func gestureRightHandler() {
        dispatch_async(dispatch_get_main_queue()) {
            self.slidesViewCtrl.nextPage()
        }
    }
    func gesturePushHandler() {
        if let currentPage = slidesViewCtrl.currentPage {
            if currentPage == 1 {
                //
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.slidesViewCtrl.firstPage()
                }
            }
        } else {}
    }
    
    //  Button Click Events
    @IBAction func lastButtonClick(sender: AnyObject) {
        slidesViewCtrl.prevPage()
    }
    
    @IBAction func nextButtonClick(sender: AnyObject) {
        slidesViewCtrl.nextPage()
    }
    @IBAction func exitButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
