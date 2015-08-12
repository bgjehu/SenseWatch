//
//  AlertViewController.m
//  MuseTrainer
//
//  Created by Jieyi Hu on 6/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self setTitle:@"OK"];
    _TitleLabel.text = [context objectForKey:@"Title"];
    _ContentLabel.text = [context objectForKey:@"Content"];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)CancelBTNClicked {
    [self popController];
    NSLog(@"AlertViewController is popped");
}
@end



