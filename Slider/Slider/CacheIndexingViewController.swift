//
//  CacheIndexingViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class CacheIndexingViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var indexingActivityIndicator: UIActivityIndicatorView!
    var webView : UIWebView! = UIWebView(frame: CGRectMake(0, 0, GlobalVar.thumbnailSize.width, GlobalVar.thumbnailSize.height))
    var cacheQueue : [EKSlidesCache] = []      //  store fileName
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeComponents()
        buildCache()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeComponents() {
        
        indexingActivityIndicator.startAnimating()
        
        //  initialize webView
        webView.scalesPageToFit = true
        webView.delegate = self
        
        //  initialize cacheQueue
        let fileManager = NSFileManager.defaultManager()
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let enumerator = fileManager.enumeratorAtPath(path)
        while let element = enumerator?.nextObject() as? String{
            if element.isSlidesFile() {
                if let cache = EKSlidesCache(fileName: element) {
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
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.indexingActivityIndicator.stopAnimating()
                self.dismissViewControllerAnimated(true, completion: nil)
                let slidesPreviewController = self.storyboard!.instantiateViewControllerWithIdentifier("SlidesPreviewController")
                slidesPreviewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                self.presentViewController(slidesPreviewController, animated: true, completion: nil)
                
            })
        }
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
