//
//  InterfaceController.m
//  MuseTrainer WatchKit Extension
//
//  Created by Jieyi Hu on 6/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import "InterfaceController.h"

@interface InterfaceController()
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)TrainForUpBTNClicked {
    [self pushControllerWithName:@"TrainnerController" context:@{@"GestureName":@"UP"}];
}

- (IBAction)TrainForDownBTNClicked {
    [self pushControllerWithName:@"TrainnerController" context:@{@"GestureName":@"DOWN"}];
}

- (IBAction)TrainForLeftBTNClicked {
    [self pushControllerWithName:@"TrainnerController" context:@{@"GestureName":@"LEFT"}];
}

- (IBAction)TrainForRightBTNClicked {
    [self pushControllerWithName:@"TrainnerController" context:@{@"GestureName":@"RIGHT"}];
}

- (IBAction)TrainForPushBTNClicked {
    [self pushControllerWithName:@"TrainnerController" context:@{@"GestureName":@"PUSH"}];
}


@end



