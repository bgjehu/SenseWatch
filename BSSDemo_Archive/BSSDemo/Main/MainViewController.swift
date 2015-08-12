//
//  ViewController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 7/22/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //  MARK: - IBOutlets
    @IBOutlet var sourcePickerView: UIPickerView!
    @IBOutlet var actionPickerView: UIPickerView!
    @IBOutlet var sourceButton: UIButton!
    @IBOutlet var actionButton: UIButton!
    @IBOutlet var arrowLabel: UILabel!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var bandConnectView: UIView!
    
    //  MARK: - IBActions
    @IBAction func sourceButtonClick(sender: AnyObject) {
        closeActionPicker()
        openSourcePicker()
    }
    @IBAction func actionButtonClick(sender: AnyObject) {
        closeSourcePicker()
        openActionPicker()
    }
    @IBAction func cancelButtonClick(sender: AnyObject) {
        closeSourcePicker()
        closeActionPicker()
    }
    @IBAction func submitButtonClick(sender: AnyObject) {
        enterDemo(getActionStoryboardName(selectedAction))
    }
    
    //  MARK: - Data Model Variables
    var selectedSource = 0 {
        didSet{
            sourceButton.setTitle(getSource(selectedSource), forState: UIControlState.Normal)
            if selectedSource != oldValue {
                //  reset Action
                selectedAction = 0
                actionPickerView.reloadAllComponents()
                actionPickerView.selectRow(0, inComponent: 0, animated: false)
            }
        }
    }
    var selectedAction = 0 {
        didSet{
            actionButton.setTitle(getActionName(selectedAction), forState: UIControlState.Normal)
            let description = getActionDescription(selectedAction)
            descriptionTextView.text = description == "" ? "No Description" : description
            submitButton.setTitle(getActionAvailability(selectedAction) ? "Demo" : "Not Available Yet\nSubscribe", forState: UIControlState.Normal)
        }
    }
    var dataSource = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("DataSource", ofType: "plist")!)!
    
    //  MARK: - Main Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        createSimulatorFolderIndicator()
        handleBandConnection()
        adjustUIForDevices()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "MSBAND_NOTIFICATION_CONNECTED", object: nil)
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
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sourcePickerView {
            return sourceCount
        } else if pickerView == actionPickerView {
            return actionCount
        } else {
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sourcePickerView {
            return getSource(row)
        } else if pickerView == actionPickerView {
            return getActionName(row)
        } else {
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sourcePickerView {
            selectedSource = row
            closeSourcePicker()
        } else if pickerView == actionPickerView {
            selectedAction = row
            closeActionPicker()
        } else {
        }
    }
    
    //  MARK: - Main Controller Implementations
    func enterDemo(storyboardName : String){
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("Entry")
        controller.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    private func adjustUIForDevices() {
        submitButton.titleLabel?.textAlignment = NSTextAlignment.Center
        var width : CGFloat
        switch UIDevice.currectDeviceByScreenSize {
            case .iPhone4, .unknown:
                width = 200
            case .iPhone5:
                width = 240
            case .iPhone6:
                width = 290
            case .iPhone6p, .iPad:
                width = 300
        }
        sourceButton.constraints[0].constant = width
        sourcePickerView.constraints[0].constant = width
        actionButton.constraints[0].constant = width
        actionPickerView.constraints[0].constant = width
    }
    private var sourceCount : Int {
        get{
            return dataSource.count
        }
    }
    private var actionCount : Int {
        get{
            return dataSource[selectedSource]["Action"]!!.count
        }
    }
    private func getSource(index : Int) -> String {
        return dataSource[index]["Source"] as! String
    }
    private func getAction(index : Int) -> Dictionary<String,String> {
        let actions = dataSource[selectedSource]["Action"] as! Array<Dictionary<String,String>>
        let action = actions[index]
        return action
    }
    private func getActionName(index : Int) -> String {
        return getAction(index)["Name"]!
    }
    private func getActionDescription(index : Int) -> String {
        return getAction(index)["Description"]!
    }
    private func getActionStoryboardName(index : Int) -> String {
        return getAction(index)["StoryboardName"]!
    }
    private func getActionAvailability(index : Int) -> Bool {
        switch (getActionStoryboardName(index)){
            case "":
                return false
            default:
                return true
        }
    }
    private func openSourcePicker() {
        sourcePickerView.hidden = false
        sourceButton.hidden = true
        descriptionTextView.hidden = true
        cancelButton.hidden = false
        submitButton.hidden = true
    }
    private func closeSourcePicker() {
        let a = selectedSource
        selectedSource = a
        sourcePickerView.hidden = true
        sourceButton.hidden = false
        descriptionTextView.hidden = false
        cancelButton.hidden = true
        submitButton.hidden = false
    }
    private func openActionPicker() {
        actionPickerView.hidden = false
        actionButton.hidden = true
        descriptionTextView.hidden = true
        cancelButton.hidden = false
        submitButton.hidden = true
    }
    private func closeActionPicker() {
        let a = selectedAction
        selectedAction = a
        actionPickerView.hidden = true
        actionButton.hidden = false
        descriptionTextView.hidden = false
        cancelButton.hidden = true
        submitButton.hidden = false
    }
    
    private func createSimulatorFolderIndicator() {
        
        let device = UIDevice.currectDeviceByScreenSize.rawValue
        let app = NSBundle.mainBundle().infoDictionary!["CFBundleName"]!
        let name = "\(device)_\(app)"
        
        
        
        let path : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        do{
            try "".writeToFile(path.stringByAppendingPathComponent(name), atomically: true, encoding: NSUTF8StringEncoding)
            print("create folder indicator \(name)")
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func handleBandConnection() {
        bandConnectView.hidden = (UIApplication.sharedApplication().delegate as! AppDelegate).bandSensorManager.connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideBandConnectView", name: "MSBAND_NOTIFICATION_CONNECTED", object: nil)
    }
    func hideBandConnectView(){
        bandConnectView.hidden = true
    }
}

