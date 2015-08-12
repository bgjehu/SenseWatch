//
//  TrainnerController.m
//  MuseTrainer
//
//  Created by Jieyi Hu on 6/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import "TrainnerController.h"

@interface TrainnerController ()

@property NSMutableArray* accelerometerData;
@property CMMotionManager* cmMotionManager;
@property NSString* Gesture;
@property NSMutableArray* AccelerometerDataSet;
@property NSString* dataSetTimeStamp;

@end

@implementation TrainnerController

- (void) pushAlertViewWithTitle:(NSString *)title withContent:(NSString *)content{
    [self pushControllerWithName:@"AlertViewController" context:@{@"Title":title,@"Content":content}];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    [self setTitle:nil];
    _Gesture = [context objectForKey:@"GestureName"];
    _GestureNameLabel.text = self.Gesture;
    _dataSetTimeStamp = @"";
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if([self setUpWCSession]){
        [self setUpMontionSensor];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (BOOL)setUpWCSession{
    if([WCSession isSupported]){
        NSLog(@"WCSession on Watch is supported.");
        _session = [WCSession defaultSession];
        _session.delegate = self;
        [_session activateSession];
        NSLog(@"WCSession on Watch is activated.");
        return true;
    } else{
        NSLog(@"WCSession on Watch is not supported.");
        [self popController];
        [self pushAlertViewWithTitle:@"Warning" withContent:@"WCSession on Watch is not supported."];
        return false;
    }
}

- (void)setUpMontionSensor{
    _cmMotionManager = [[CMMotionManager alloc] init];
    NSLog(@"CMMontionManager on Watch is initialized.");
    if([self.cmMotionManager isAccelerometerAvailable]){

        [self performSelector:@selector(playHaptic) withObject:nil afterDelay:2.0f];
        [self performSelector:@selector(setUpMontionSensorTask) withObject:nil afterDelay:2.8f];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.dataSetTimeStamp = [dateFormatter stringFromDate:[[NSDate alloc] init]];
    } else{
        NSLog(@"Accelerometer on Watch is not available");
        [self popController];
        [self pushAlertViewWithTitle:@"Warning" withContent:@"Accelerometer on Watch is not available."];
    }
}

- (void)setUpMontionSensorTask{
    NSLog(@"Accelerometer on Watch is available.");
    _AccelerometerDataSet = [[NSMutableArray alloc] init];
    _cmMotionManager.accelerometerUpdateInterval = 0.01;
    [self.cmMotionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData* data,NSError* error){
        dispatch_async(dispatch_get_main_queue(), ^{
            //  Handler Code
            NSDictionary* accelerometerData = @{
                                     @"classifier":self.Gesture,
                                     @"datasettimestamp": self.dataSetTimeStamp,
                                     @"timestamp":[NSString stringWithFormat:@"%f",data.timestamp],
                                     @"x":[NSString stringWithFormat:@"%f",data.acceleration.x],
                                     @"y":[NSString stringWithFormat:@"%f",data.acceleration.y],
                                     @"z":[NSString stringWithFormat:@"%f",data.acceleration.z],
                                     };
            [_AccelerometerDataSet addObject:accelerometerData];
            NSLog(@"Data on Watch is added to dataset");
        });
    }];
    NSLog(@"Accelerometer on Watch is started.");
    //  Stop update in 10 seconds
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Accelerometer on Watch is stopped.");
        [self.cmMotionManager stopAccelerometerUpdates];
        [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
        [self.session transferUserInfo:@{@"dataset":self.AccelerometerDataSet}];
        [self popController];
    });

}

- (IBAction)CancelBTNClicked {
    [self dismissController];
    NSLog(@"TrainnerController is dismissed");
}

- (void)playHaptic{
   [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
}
@end



