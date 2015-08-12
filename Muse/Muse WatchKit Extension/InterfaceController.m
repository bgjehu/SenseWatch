//
//  InterfaceController.m
//  Muse WatchKit Extension
//
//  Created by Jieyi Hu on 6/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property WCSession *session;
@property CMMotionManager* cmMotionManager;
@property NSTimeInterval lastGestureTimestamp;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self setUpProperties];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
//    [self.cmMotionManager stopAccelerometerUpdates];
    [super didDeactivate];
}

- (IBAction)lastSongButtonClick {
    NSLog(@"lastSongButton On Watch is clicked.");
    [self sendGesture:@"LEFT"];
}

- (IBAction)playSongButtonClick {
    NSLog(@"playSongButton On Watch is clicked.");
    [self sendGesture:@"PUSH"];
}

- (IBAction)nextSongButtonClick {
    NSLog(@"nextSongButton On Watch is clicked.");
    [self sendGesture:@"RIGHT"];
}

- (void)setUpProperties{
    self.lastGestureTimestamp = 0;
    [self setUpWCSession];
    [self setUpMontionSensor];
}

- (void)setUpWCSession{
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    NSLog(@"WCSession On Watch is activated.");
}

- (void)setUpMontionSensor{
    _cmMotionManager = [[CMMotionManager alloc] init];
    NSLog(@"CMMontionManager on Watch is initialized.");
    if([self.cmMotionManager isAccelerometerAvailable]){
        NSLog(@"Accelerometer on Watch is available.");
        _cmMotionManager.accelerometerUpdateInterval = 0.1;
        [self.cmMotionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData* data,NSError* error){
            dispatch_async(dispatch_get_main_queue(), ^{
                //  Handler Code
                [_dataLabel setText:[NSString stringWithFormat:@"x:%.02f   y:%.02f   z:%.02f",data.acceleration.x,data.acceleration.y,data.acceleration.z]];
                [self handleAccelerometerData:data];
            });
        }];

    } else{
        NSLog(@"Accelerometer on Watch is not available.");
    }
}

- (void)handleAccelerometerData:(CMAccelerometerData*)data{
    float x = data.acceleration.x;
    float y = data.acceleration.y;
    float z = data.acceleration.z;
    NSString* gestureName = @"null";

    if(sqrt(x*x+y*y+z*z) > 1.25){
        //  has gesture made
        if(z > y){
            //  gesture UP
            gestureName = @"UP";
        } else if(fabs(z) > fabs(x)){
            //  gesture DOWN/PUSH
            gestureName = @"PUSH";
        } else{
            //  gesture LEFT/RIGHT
            gestureName = @"RIGHT";
        }
    } else{
        //  do nothing
    }
    
    if([gestureName isEqualToString:@"null"]){
        //no gesture made
    } else{
        //  there is gesture made
        if(self.lastGestureTimestamp == 0){
            //  there is no last gesture
            [self sendGesture:gestureName];
            _lastGestureTimestamp = data.timestamp;
        } else{
            //  there is a last gesture
            if(data.timestamp - self.lastGestureTimestamp >= 1){
                //  last gesture was made at least one sec ago
                [self sendGesture:gestureName];
                _lastGestureTimestamp = data.timestamp;
            } else{
                //  do nothing
            }
        }
    }
}


- (void)sendGesture:(NSString*)gesture{
    if([_session isReachable]){
        [_session sendMessage:@{@"type":@"Gesture",
                                @"content":gesture} replyHandler:nil errorHandler:nil];
        NSLog(@"Gesture on Watch is sent");
    } else{
        NSLog(@"WCSession on Watch is not reachable");
    }
}

- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message{
    NSString* type = [message objectForKey:@"type"];
    if([type isEqualToString:@"UIUpdateInfo"]){
        NSLog(@"Watch receives UI update info");
        [self handleUIUpdateInfo:[message objectForKey:@"content"]];
    }
}

- (void)handleUIUpdateInfo:(NSDictionary*)updateInfo{
    [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeClick];
    [self.songTitleLabel setText:[updateInfo objectForKey:@"nowPlayingSongTitle"]];
    [self.playSongButton setBackgroundImage:[UIImage imageNamed:[updateInfo objectForKey:@"playButtonImageName"]]];
}

@end



