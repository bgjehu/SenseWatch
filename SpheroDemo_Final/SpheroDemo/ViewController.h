//
//  ViewController.h
//  SenseWatch
//
//  Created by Jieyi Hu on 6/9/15.
//  Copyright © 2015 SharpPug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MicrosoftBandKit_iOS/MicrosoftBandKit_iOS.h>
#import <RobotKit/RobotKit.h>

@interface ViewController : UIViewController<MSBClientManagerDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ConnectionIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ParseIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *AccelerometerIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *GyroscopeIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *SpheroIndicator;
@property (strong, nonatomic) IBOutlet UISwitch *ConnectionSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *ParseSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *AccelerometerSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *GyroscopeSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *SpheroRollSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *SpheroLightUpSwitch;
@property (strong, nonatomic) IBOutlet UILabel *AccelerometerLabelX;
@property (strong, nonatomic) IBOutlet UILabel *AccelerometerLabelY;
@property (strong, nonatomic) IBOutlet UILabel *AccelerometerLabelZ;
@property (strong, nonatomic) IBOutlet UILabel *GyroscopeLabelX;
@property (strong, nonatomic) IBOutlet UILabel *GyroscopeLabelY;
@property (strong, nonatomic) IBOutlet UILabel *GyroscopeLabelZ;
- (IBAction)ConnectionSwitchTouchUpInside:(id)sender;
- (IBAction)AccelerometerSwitchTouchUpInside:(id)sender;
- (IBAction)GyroscopeSwitchTouchUpInside:(id)sender;
- (IBAction)SpheroRollSwitchTouchUpInside:(id)sender;
- (IBAction)SpheroLightUpSwitchTouchUpInside:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *vLabel;
@property (weak, nonatomic) IBOutlet UILabel *dLabel;

@end

