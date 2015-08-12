//
//  InterfaceController.h
//  MuseTrainer WatchKit Extension
//
//  Created by Jieyi Hu on 6/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

- (IBAction)TrainForUpBTNClicked;
- (IBAction)TrainForDownBTNClicked;
- (IBAction)TrainForLeftBTNClicked;
- (IBAction)TrainForRightBTNClicked;
- (IBAction)TrainForPushBTNClicked;

@end
