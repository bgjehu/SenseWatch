//
//  TableViewController.swift
//  Slider
//
//  Created by Jieyi Hu on 7/13/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import CoreGraphics

class SlidesPreviewController: UITableViewController {
    
    ///  MARK: - IBOutlets
    //  MARK: - IBActions
    @IBAction func exitButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //  MARK: - Data Model Variables
    var slidesFileNames : [String] = []

    //  MARK: - Main Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        initializeComponents()
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
    
    //  MARK: Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidesFileNames.count
    }
    
    //  MARK: Table view delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SlidesPreviewCell", forIndexPath: indexPath) as UITableViewCell
        let fileName = slidesFileNames[indexPath.row]
        (cell.contentView.viewWithTag(1) as! UILabel).text = getCellInfo(fileName).titleString
        (cell.contentView.viewWithTag(2) as! UILabel).text = getCellInfo(fileName).numberOfPagesString
        (cell.contentView.viewWithTag(3) as! UILabel).text = getCellInfo(fileName).creatationDateString
        (cell.contentView.viewWithTag(4) as! UILabel).text = getCellInfo(fileName).modificationDateString
        (cell.contentView.viewWithTag(5) as! UILabel).text = getCellInfo(fileName).typeString
        (cell.contentView.viewWithTag(6) as! UIImageView).image = getCellInfo(fileName).image
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presentSlides(slidesFileNames[indexPath.row])
    }
    
    //  MARK: - Main Controller Implementations
    func initializeComponents() {
        //  initialize slidesFileNames
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(SliderGlobalVar.appSliderContent)
        while let element = enumerator?.nextObject() as? String{
            if element.appSliderPathObjects.isSlidesFile() {
                slidesFileNames.append(element)
            }
        }
    }
    
    func getCellInfo(fileName : String) -> (titleString : String, numberOfPagesString: String,creatationDateString : String, modificationDateString: String, typeString : String, image : UIImage) {
        let cache = SlidesCache(fileName: fileName)!
        
        let titleString = fileName.appSliderPathObjects.fileTitle
        
        let numberOfPagesString = cache.numberOfPages > 1 ? "Pages" : "Page"
        
        let creatationDateString = "Added: " + ((fileName.appSliderPathObjects.fileCreationDate)?.description.stringByReplacingOccurrencesOfString(" +0000", withString: ""))!
        let modificationDateString = "Modified: " + ((fileName.appSliderPathObjects.fileModificationDate)?.description.stringByReplacingOccurrencesOfString(" +0000", withString: ""))!
        let typeString = fileName.appSliderPathObjects.fileExtension.uppercaseString
        let image = cache.thumbnail
        
        return (titleString,numberOfPagesString,creatationDateString,modificationDateString,typeString,image)
    }
    
    func presentSlides(fileName : String){
        let slidesViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SlidesViewController") as! SlidesViewController
        slidesViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(slidesViewController, animated: true, completion: {slidesViewController.loadFile(fileName)})
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
