//
//  CacheIndexingViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class SlidesCachingViewController: UIViewController,UIWebViewDelegate {

    //  MARK: - IBOutlets
    @IBOutlet var indexingActivityIndicator: UIActivityIndicatorView!

    ///  MARK: - IBActions
    
    
    //  MARK: - Data Model Variables
    var webView : UIWebView! = UIWebView(frame: CGRectMake(0, 0, SliderGlobalVar.thumbnailSize.width, SliderGlobalVar.thumbnailSize.height))
    var cacheQueue : [SlidesCache] = []      //  store fileName
    var viewUsed = false
    
    //  MARK: - Main Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeComponents()
    }
    
    override func viewDidAppear(animated: Bool) {
        if !viewUsed {
            buildCache()
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
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
    func webViewDidFinishLoad(webView: UIWebView) {
        if cacheQueue.count > 0 {
            if cacheQueue[0].fileName.hasSuffix("pdf") {
                cacheQueue[0].updatePDFCache()
            } else {
                let numberOfPage = webView.numberOfPages
                let thumbnail = webView.screenshot
                cacheQueue[0].updateCache(numberOfPage, thumbnail: thumbnail)
            }
            cacheQueue.removeAtIndex(0)
            buildCache()
        }
    }
    
    //  MARK: - Main Controller Implementations
    func initializeComponents() {
        
        indexingActivityIndicator.startAnimating()
        
        //  initialize webView
        webView.scalesPageToFit = true
        webView.delegate = self
        
        //  initialize cacheQueue
        let fileManager = NSFileManager.defaultManager()
        
        var isDir = ObjCBool(false)
        
        if fileManager.fileExistsAtPath(SliderGlobalVar.appSliderContent, isDirectory: &isDir) {
            if isDir {
            } else {
                print("\(SliderGlobalVar.appSliderContent) is created as a file, cannot create a folder")
            }
        } else {
            do{
                try fileManager.createDirectoryAtPath(SliderGlobalVar.appSliderContent, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error)
            }
        }
        
        if fileManager.fileExistsAtPath(SliderGlobalVar.appSliderCache, isDirectory: &isDir) {
            if isDir {
            } else {
                print("\(SliderGlobalVar.appSliderContent) is created as a file, cannot create a folder")
            }
        } else {
            do{
                try fileManager.createDirectoryAtPath(SliderGlobalVar.appSliderCache, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error)
            }
        }
    
    
        let path = SliderGlobalVar.appSliderContent
        let enumerator = fileManager.enumeratorAtPath(path)
        while let element = enumerator?.nextObject() as? String{
            if element.appSliderPathObjects.isSlidesFile() {
                if let cache = SlidesCache(fileName: element) {
                    if cache.exist {
                        //  do nothing
                    } else {
                        //  load fileName into queue
                        cacheQueue.append(cache)
                    }
                }
            }
        }
    }
    
    func buildCache() {
        if cacheQueue.count > 0 {
            webView.loadFile(cacheQueue[0].fileName)
        } else {
            indexingActivityIndicator.stopAnimating()
            let slidesPreviewController = self.storyboard!.instantiateViewControllerWithIdentifier("SlidesPreviewController")
            slidesPreviewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            presentViewController(slidesPreviewController, animated: true, completion: nil)
            viewUsed = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
