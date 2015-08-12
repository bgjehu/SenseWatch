//
//  ViewController.h
//  MuseTrainer
//
//  Created by Jieyi Hu on 6/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController<WCSessionDelegate>

@property (strong, nonatomic) WCSession* session;
@property (strong, nonatomic) IBOutlet UISwitch *ParseSwitch;

@end

