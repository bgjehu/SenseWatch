//
//  ViewController.h
//  Muse
//
//  Created by Jieyi Hu on 6/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController<WCSessionDelegate>{
    BOOL isPlaying;
}
@property (strong, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *playSongButton;
- (IBAction)lastSongButtonClick:(id)sender;
- (IBAction)playSongButtonClick:(id)sender;
- (IBAction)nextSongButtonClick:(id)sender;

@end

