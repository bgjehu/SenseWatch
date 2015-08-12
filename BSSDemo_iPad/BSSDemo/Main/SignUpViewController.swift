//
//  SignUpViewController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/9/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!

    @IBAction func exitButtonClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.sense.watch/#contact")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
