//
//  AlertViewController.h
//  MuseTrainer
//
//  Created by Jieyi Hu on 6/21/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface AlertViewController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *TitleLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *ContentLabel;

@end
