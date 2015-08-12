//
//  WhipViewController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/10/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import AVFoundation

class WhipViewController: UIViewController {

    @IBAction func exitButtonClicked(sender: AnyObject) {
        dismissView()
    }
    var whipSoundPlayer : AVAudioPlayer!
    
    @IBAction func whipButtonClicked(sender: UIButton) {
        playWhipSound()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do{
            let str = NSBundle.mainBundle().pathForResource("Whip", ofType: "mp3")!
            let url = NSURL(string: str)!
            try whipSoundPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch let error as NSError{print(error)}
        GKPredefinedGesture.Left.registerNotification(self, selector: "playWhipSound")
        GKPredefinedGesture.Right.registerNotification(self, selector: "playWhipSound")
        GKPredefinedGesture.Down.registerNotification(self, selector: "playWhipSound")
        GKPredefinedGesture.Up.registerNotification(self, selector: "dismissView")
    }
    override func viewWillDisappear(animated: Bool) {
        GKPredefinedGesture.Up.deregisterNotification(self)
        GKPredefinedGesture.Left.deregisterNotification(self)
        GKPredefinedGesture.Down.deregisterNotification(self)
        GKPredefinedGesture.Right.deregisterNotification(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playWhipSound() {
        whipSoundPlayer.play()
    }
    func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
