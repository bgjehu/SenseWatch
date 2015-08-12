//
//  BackDoorViewController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/7/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import AudioToolbox

class BackDoorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var gestureNameTextField: UITextField!
    @IBOutlet var recordButton: UIButton!
    
    @IBAction func exitButtonClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func recordButtonClicked(sender: AnyObject) {
        if let text = gestureNameTextField.text {
            recordButton.hidden = true
            let sensorMgr = (UIApplication.sharedApplication().delegate as! AppDelegate).bandSensorManager
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                sensorMgr.startRecord()
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(60 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    sensorMgr.stopRecord()
                    sensorMgr.dataRecorder.createPattern(text).saveLocally()
                    self.recordButton.hidden = false
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
