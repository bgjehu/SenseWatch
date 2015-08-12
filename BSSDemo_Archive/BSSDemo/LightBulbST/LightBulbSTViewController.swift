//
//  LightBulbSTViewController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/1/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import AudioToolbox


class LightBulbSTViewController: UIViewController, MSBClientManagerDelegate {

    //  MARK: - IBOutlets
    @IBOutlet var lightImageView: UIImageView!
    @IBOutlet var hueSlider: UISlider!
    @IBOutlet var saturationSlider: UISlider!
    @IBOutlet var brightnessSlider: UISlider!
    @IBOutlet var connectionLabel: UILabel!
    @IBOutlet var bandConnectingView: UIView!
    @IBOutlet var lightOnOffSwitch: UISwitch!
    @IBOutlet var temperatureLabel: UILabel!
    
    //  MARK: - IBActions
    @IBAction func exitButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func aSliderValueChanged(sender: UISlider) {
        //  update LightImageColor
        updateLightImageColor()
        
        //  update light state
        updateLightState()
    }
    @IBAction func lightSwitchValueChanged(sender: UISwitch) {
        //  update sliders
        updateSlidersUponUISwitch()
        //  update LightImageColor
        updateLightImageColor()
        //  update light state
        updateLightState()
    }
    
    //  MARK: - Data Model Variables
    //  MARK: Constant
    let bridgeID = "001788FFFE15ADCA"
    let bridgeIP = "192.168.0.100"
    let lightID = "2"
    let minTemp : Float = 20.0
    let maxTemp : Float = 40.0
    //  MARK: Data Model
    var client : MSBClient!
    var sdk = PHHueSDK()
    var light : PHLight!
    var lightOn : Bool {
        get{
            return lightOnOffSwitch.on
        }
        set{
            if lightOnOffSwitch.on != newValue {
                //  update Switch
                lightOnOffSwitch.setOn(newValue, animated: true)
                //  update sliders
                updateSlidersUponUISwitch()
                //  update LightImageColor
                updateLightImageColor()
                //  update light state
                updateLightState()
            }
        }
    }
    var lightColorHue : Float {
        get{
            return hueSlider.value
        }
        set{
            //  update slider
            hueSlider.setValue(newValue, animated: true)
            //  update LightImageColor
            updateLightImageColor()
            //  update light state
            updateLightState()
        }
    }
    var lightColorSaturation : Float {
        get{
            return saturationSlider.value
        }
        set{
            //  update UI
            saturationSlider.setValue(newValue, animated: true)
            //  update LightImageColor
            updateLightImageColor()
            //  update light state
            updateLightState()
        }
    }
    var lightBrightness : Float {
        get{
            return brightnessSlider.value
        }
        set{
            //  update UI
            brightnessSlider.setValue(newValue, animated: true)
            //  update LightImageColor
            updateLightImageColor()
            //  update light state
            updateLightState()
        }
    }
    var lightColor : UIColor {
        get{
            return UIColor(hue: CGFloat(lightColorHue), saturation: CGFloat(lightColorSaturation), brightness: CGFloat(1), alpha: CGFloat(1))
        }
    }
    var lightImageColor : UIColor {
        get{
            return UIColor(hue: CGFloat(lightColorHue), saturation: CGFloat(lightColorSaturation), brightness: CGFloat(lightBrightness), alpha: CGFloat(1))
        }
    }
    
    
    //  MARK: - Main Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initializations()
    }
    
    override func viewWillDisappear(animated: Bool) {
        deinitializations()
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
    
    
    //  MARK: - Protocol Implementations
    //  MARK: PHHueSDK
    func onlocalConnection() {
        PHNotificationManager.defaultManager().deregisterObject(self, forNotification: LOCAL_CONNECTION_NOTIFICATION)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        connectionLabel.text = "Connected"
        light = PHBridgeResourcesReader.readBridgeResourcesCache().lights[lightID] as! PHLight
        lightOn = true
    }
    func noLocalConnection() {
        PHNotificationManager.defaultManager().deregisterObjectForAllNotifications(self)
        showAlert("No connection to Philips Hue", dismissView: true)
    }
    //  MARK: MSBandSDK
    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        showAlert("Failed to connect Microsoft Band", dismissView: true)
    }
    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        bandConnectingView.hidden = true
        showAlert("Microsoft Band Connected", dismissView: false)
        do {
            try client.sensorManager.startSkinTempUpdatesToQueue(NSOperationQueue(), withHandler: skinTemperatureDataHandler)
        } catch let error as NSError {
            print(error)
        }
    }
    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
        
    }
    func skinTemperatureDataHandler(data : MSBSensorSkinTemperatureData!, error : NSError!) {
        dispatch_async(dispatch_get_main_queue()) {
            let temp = Float(data.temperature)
            self.temperatureLabel.text = "Temp: \(temp)°C"
            self.lightColorHue = (temp - self.minTemp) / (self.maxTemp - self.minTemp)
        }
    }
    
    
    func increaseLightColorHue() {
        dispatch_async(dispatch_get_main_queue()) {
            self.lightColorHue = self.lightColorHue + 0.1
        }
    }
    func decreaseLightColorHue() {
        dispatch_async(dispatch_get_main_queue()) {
            self.lightColorHue = self.lightColorHue - 0.1
        }
    }
    func increaseLightBrightness() {
        dispatch_async(dispatch_get_main_queue()) {
            self.lightBrightness = self.lightBrightness + 0.1
        }
    }
    func decreaseLightBrightness() {
        dispatch_async(dispatch_get_main_queue()) {
            self.lightBrightness = self.lightBrightness - 0.1
        }
    }
    func changeLightOn() {
        dispatch_async(dispatch_get_main_queue()) {
            self.lightOn = !self.lightOn
        }
    }
    
    //  MARK: - Main Controller Implementations
    func initializations() {
        setupHue()
        setupMSBand()
    }
    func deinitializations() {
        MSBClientManager.sharedManager().cancelClientConnection(client)
        lightOn = false
        PHNotificationManager.defaultManager().deregisterObjectForAllNotifications(self)
        sdk.disableLocalConnection()
        sdk.stopSDK()
    }

    func setupMSBand(){
        MSBClientManager.sharedManager().delegate = self
        client = MSBClientManager.sharedManager().attachedClients()[0] as? MSBClient
        if client == nil {
            showAlert("No connection to Microsoft Band", dismissView: true)
        } else {
            bandConnectingView.hidden = false
            MSBClientManager.sharedManager().connectClient(client)
        }
    }
    
    func setupHue() {
        sdk.enableLogging(true)
        sdk.startUpSDK()
        sdk.setBridgeToUseWithId(bridgeID, ipAddress: bridgeIP)
        PHNotificationManager.defaultManager().registerObject(self, withSelector: "onlocalConnection", forNotification: LOCAL_CONNECTION_NOTIFICATION)
        PHNotificationManager.defaultManager().registerObject(self, withSelector: "noLocalConnection", forNotification: NO_LOCAL_CONNECTION_NOTIFICATION)
        sdk.enableLocalConnection()
    }
    func updateSlidersUponUISwitch() {
        if lightOnOffSwitch.on {
            hueSlider.enabled = true
            saturationSlider.enabled = true
            brightnessSlider.enabled = true
            hueSlider.setValue(1, animated: true)
            saturationSlider.setValue(1, animated: true)
            brightnessSlider.setValue(1, animated: true)
        } else {
            hueSlider.enabled = false
            saturationSlider.enabled = false
            brightnessSlider.enabled = false
            hueSlider.setValue(0, animated: true)
            saturationSlider.setValue(0, animated: true)
            brightnessSlider.setValue(0, animated: true)
        }
    }

    func updateLightImageColor() {
        lightImageView.backgroundColor = lightImageColor
    }
    
    func updateLightState() {
        let lightState = light.lightState
        let colorXY = PHUtilities.calculateXY(lightColor, forModel: light.modelNumber)
        lightState.on = NSNumber(bool: lightOn)
        lightState.x = colorXY.x
        lightState.y = colorXY.y
        lightState.brightness = Int(254 * lightBrightness)
        PHBridgeSendAPI().updateLightStateForId(light.identifier, withLightState: lightState, completionHandler: {(error) in
            if error == nil {
                print("light state changed successfully")
            } else {
                print("light state changed unsuccessfully")
            }
        })
    }
    
    func showAlert(title : String, dismissView : Bool) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        if dismissView {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: {(_) in self.dismissViewControllerAnimated(true, completion: nil)}))
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        }
        self.presentViewController(alert, animated: true, completion: nil)
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
