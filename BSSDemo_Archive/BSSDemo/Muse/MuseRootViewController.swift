//
//  MuseRootViewController.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 7/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit
import MediaPlayer

class MuseRootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    //  MARK: - IBOutlets
    @IBOutlet var nowPlayingTitleButton: UIBarButtonItem!
    @IBOutlet var musicControllToolBar: UIToolbar!
    @IBOutlet var previewTableView: UITableView!
    
    //  MARK: - IBActions
    @IBAction func prevButtonClick(sender: AnyObject) {
        prevAction()
    }
    @IBAction func playButtonClick(sender: AnyObject) {
        playAction()
    }
    @IBAction func nextButtonClick(sender: AnyObject) {
        nextAction()
    }
    @IBAction func exitButtonClick(sender: AnyObject) {
        exitAction()
    }

    //  MARK: - Data Model Variables
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
    var allLocalSongs : MPMediaQuery {
        get{
            let _allLocalSongs = MPMediaQuery.songsQuery()
            let localSongOnlyPredication = MPMediaPropertyPredicate(value: 0, forProperty: MPMediaItemPropertyIsCloudItem)
            let artistPredication = MPMediaPropertyPredicate(value: "Swift", forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.Contains)
            _allLocalSongs.addFilterPredicate(localSongOnlyPredication)
            _allLocalSongs.addFilterPredicate(artistPredication)
            return _allLocalSongs
        }
    }
    var queue : MPMediaQuery = MPMediaQuery.songsQuery()
    var nowPlaying = false {
        didSet{
            updateUI()
            if nowPlaying {
                musicPlayer.play()
            } else {
                musicPlayer.pause()
            }
        }
    }
    var playButtonIndex = 3
    
    //  MARK: - Main Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initializeComponents()
    }
    
    override func viewWillDisappear(animated: Bool) {
        musicPlayer.stop()
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
        return UIInterfaceOrientationMask.Portrait
    }

    //  MARK: - Protocol Implementations
    
    //  MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = queue.items?.count {
            return count
        } else {
            return 0
        }
    }
    
    //  MARK: UITableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MusicPreviewCell", forIndexPath: indexPath) as UITableViewCell
        (cell.contentView.viewWithTag(1) as! UILabel).text = queue.items![indexPath.row].title
        (cell.contentView.viewWithTag(2) as! UILabel).text = queue.items![indexPath.row].artist
        (cell.contentView.viewWithTag(3) as! UILabel).text = queue.items![indexPath.row].albumTitle
        (cell.contentView.viewWithTag(4) as! UIImageView).image = queue.items![indexPath.row].artwork?.imageWithSize(CGSizeMake(128, 128))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        musicPlayer.nowPlayingItem = queue.items?[indexPath.row]
        nowPlaying = true
    }
    
    //  MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsScopeBar = false
        searchBar.showsCancelButton = false
        queue = allLocalSongs
        previewTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let keyword = searchBar.text
        switch searchBar.selectedScopeButtonIndex {
        case 0:
            queue.addFilterPredicate(MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyTitle, comparisonType: MPMediaPredicateComparison.Contains))
        case 1:
            queue.addFilterPredicate(MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.Contains))
        case 2:
            queue.addFilterPredicate(MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.Contains))
        default:break
        }
        previewTableView.reloadData()
    }
    
    //  MARK: - Main Controller Implementations
    func initializeComponents () {
        
        //  register notification
        GKPredefinedGesture.Left.registerNotification(self, selector: "prevAction")
        GKPredefinedGesture.Right.registerNotification(self, selector: "nextAction")
        GKPredefinedGesture.Push.registerNotification(self, selector: "playAction")
        GKPredefinedGesture.Up.registerNotification(self, selector: "exitAction")
        
        //  initialize musicplayer
        queue = allLocalSongs
        musicPlayer.setQueueWithQuery(queue)
        musicPlayer.repeatMode = MPMusicRepeatMode.All
        musicPlayer.shuffleMode = MPMusicShuffleMode.Off
        musicPlayer.prepareToPlay()
    }
    
    func updateUI() {
        if nowPlaying {
            musicControllToolBar.items?[playButtonIndex] = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playAction")
        } else {
            musicControllToolBar.items?[playButtonIndex] = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "playAction")
        }
        var title = "N/A"
        if let songTitle = musicPlayer.nowPlayingItem?.title {
            if let artistName = musicPlayer.nowPlayingItem?.artist {
                title = "\(songTitle) - \(artistName)"
            } else {
                title = songTitle
            }
        } else {}
        nowPlayingTitleButton.title = title
    }
    
    func prevAction() {
        dispatch_async(dispatch_get_main_queue()) {
            self.musicPlayer.skipToPreviousItem()
            self.updateUI()
        }
    }
    func playAction() {
        dispatch_async(dispatch_get_main_queue()) {
            self.nowPlaying = !self.nowPlaying
        }
    }
    func nextAction() {
        dispatch_async(dispatch_get_main_queue()) {
            self.musicPlayer.skipToNextItem()
            self.updateUI()
        }
    }
    func exitAction() {
        dispatch_async(dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
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
