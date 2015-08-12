//
//  TrainnerController.h
//  MuseTrainer
//
//  Created by Jieyi Hu on 6/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface TrainnerController : WKInterfaceController<WCSessionDelegate>

@property (strong, nonatomic) WCSession* session;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *GestureNameLabel;
- (IBAction) CancelBTNClicked;
- (void) pushAlertViewWithTitle:(NSString*)title withContent:(NSString*)content;

@end
