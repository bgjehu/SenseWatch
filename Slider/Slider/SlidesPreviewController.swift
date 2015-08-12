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
    
    var slidesFileNames : [String] = []

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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidesFileNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SlidesPreviewCell", forIndexPath: indexPath) as UITableViewCell
        let cache = EKSlidesCache(fileName: slidesFileNames[indexPath.row])!
        (cell.contentView.viewWithTag(1) as! UILabel).text = slidesFileNames[indexPath.row].fileTitle
        let page = cache.numberOfPages > 1 ? "Pages" : "Page"
        (cell.contentView.viewWithTag(2) as! UILabel).text = "\(cache.numberOfPages) " + page
        var date = (slidesFileNames[indexPath.row].fileCreationDate)?.description.stringByReplacingOccurrencesOfString(" +0000", withString: "")
        (cell.contentView.viewWithTag(3) as! UILabel).text = "Added: \(date!)"
        date = (slidesFileNames[indexPath.row].fileModificationDate)?.description.stringByReplacingOccurrencesOfString(" +0000", withString: "")
        (cell.contentView.viewWithTag(4) as! UILabel).text = "Modified: \(date!)"
        let ext = slidesFileNames[indexPath.row].fileExtension
        (cell.contentView.viewWithTag(5) as! UILabel).text = ext.uppercaseString
        (cell.contentView.viewWithTag(6) as! UIImageView).image = cache.thumbnail
        return cell
    }
    
    func initializeComponents() {
        //  initialize slidesFileNames
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])
        while let element = enumerator?.nextObject() as? String{
            if element.hasSuffix("pdf") || element.hasSuffix("ppt") || element.hasSuffix("pptx") {
                slidesFileNames.append(element)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presentSlides(slidesFileNames[indexPath.row])
    }
    
    func presentSlides(fileName : String){
        let slidesViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SlidesViewController") as! SlidesViewController
        slidesViewController.modalTransitionStyle = .FlipHorizontal
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
