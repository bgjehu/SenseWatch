//
//  InterfaceController.h
//  Muse WatchKit Extension
//
//  Created by Jieyi Hu on 6/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <CoreMotion/CoreMotion.h>

@interface InterfaceController : WKInterfaceController<WCSessionDelegate>
- (IBAction)lastSongButtonClick;
- (IBAction)playSongButtonClick;
- (IBAction)nextSongButtonClick;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *songTitleLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *dataLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *playSongButton;
@end
