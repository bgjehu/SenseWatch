//
//  SlidesViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/12/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class SlidesViewController: UIViewController {

    //  MARK: - IBOutlets
    @IBOutlet var exitButton: UIButton!
    //  MARK: - IBActions
    @IBAction func lastButtonClick(sender: AnyObject) {
        slidesViewCtrl.prevPage()
    }
    
    @IBAction func nextButtonClick(sender: AnyObject) {
        slidesViewCtrl.nextPage()
    }
    @IBAction func exitButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //  MARK: - Data Model Variables
    var slidesViewCtrl = SlidesWebAndImageViewsController()
    
    //  MARK: - Main Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //  register notifications
        registerNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        GKPredefinedGesture.deregisterAllNotifications(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //  MARK: - Protocol Implementations
    
    //  MARK: - Main Controller Implementations
    func loadFile(fileName : String){
        slidesViewCtrl.loadFile(fileName)
        self.view.addSubview(slidesViewCtrl.view)
        self.view.bringSubviewToFront(exitButton)
    }
    
    func registerNotification() {
        
        GKPredefinedGesture.Up.registerNotification(self, selector: "gestureUpHandler")
        GKPredefinedGesture.Down.registerNotification(self, selector: "gestureDownHandler")
        GKPredefinedGesture.Left.registerNotification(self, selector: "gestureLeftHandler")
        GKPredefinedGesture.Right.registerNotification(self, selector: "gestureRightHandler")
        GKPredefinedGesture.Push.registerNotification(self, selector: "gesturePushHandler")
        
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
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.slidesViewCtrl.firstPage()
                }
            }
        } else {}
    }
    
}
