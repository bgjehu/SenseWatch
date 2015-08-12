//
//  ViewController.m
//  SenseWatch
//
//  Created by Jieyi Hu on 6/9/15.
//  Copyright © 2015 SharpPug. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#pragma mark - Properties
@property (weak,nonatomic)MSBClient *client;
@property int connectionState;
// -3:disconnected failed
// -2:disconnected
// -1:disconnecting
//  1:connecting
//  2:connected
//  3:connected failed
@property BOOL cloudOn;
@property BOOL accelerometerOn;
@property BOOL gyroscopeOn;
@property BOOL spheroRollOn;
@property BOOL spheroLightOn;
@property float gyroX;
@property float gyroY;
@property float gyroZ;
@property BOOL isDebugging;

@end

@implementation ViewController

#pragma mark - ViewController Delegates

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view, typically from a nib.
    [self initializeModels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General Utilities

-(void)initializeModels{
    
    _isDebugging = true;
    
    if(self.isDebugging){
        _vLabel.hidden = false;
        _dLabel.hidden = false;
    }
    
    _connectionState = -2;
    _accelerometerOn = false;
    _gyroscopeOn = false;
    _spheroRollOn = false;
    _spheroLightOn = false;
    
    _gyroX = 0;
    _gyroY = 0;
    _gyroZ = 0;
    
    //  set clientMgr delegate
    [MSBClientManager sharedManager].delegate = self;
}

-(void)popAlertWithTitle:(NSString *)title withMessage:(NSString *)message{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

#pragma mark - Client Manager Delegates

-(void)clientManager:(MSBClientManager *)clientManager clientDidConnect:(MSBClient *)client{
    //  adjust model
    _connectionState = 2;
    
    //  adjust UI
    _ConnectionSwitch.enabled = true;
    _ConnectionSwitch.on = true;
    _AccelerometerSwitch.enabled = true;
    _GyroscopeSwitch.enabled = true;
    _SpheroRollSwitch.enabled = true;
    
    NSLog(@"Band is connnected!");
}

-(void)clientManager:(MSBClientManager *)clientManager clientDidDisconnect:(MSBClient *)client{
    //  adjust model
    _connectionState = -2;
    
    //  adjust UI
    _ConnectionSwitch.enabled = true;
    _ConnectionSwitch.on = false;
    _AccelerometerSwitch.enabled = false;
    _AccelerometerSwitch.on = false;
    _GyroscopeSwitch.enabled = false;
    _GyroscopeSwitch.on = false;
    _SpheroRollSwitch.enabled = false;
    _SpheroRollSwitch.on = false;
    
    NSLog(@"Band is disconnnected!");
}

-(void)clientManager:(MSBClientManager *)clientManager client:(MSBClient *)client didFailToConnectWithError:(NSError *)error{


}

#pragma mark - Connection Utilities

-(void)tryToConnectToBand{
    //  change UI
    
    _ConnectionSwitch.enabled = false;
    _connectionState = 1;
    
    //  get client
    _client = [[[MSBClientManager sharedManager] attachedClients]firstObject];
    
    if(_client == nil){
        //  no client found
        //  reset UI
        _ConnectionSwitch.enabled = true;
        _ConnectionSwitch.on = false;
        _connectionState = -2;
        //  show UIAlertView
        [self popAlertWithTitle:@"Band Connected Failed" withMessage:@"No Band is paired"];
        NSLog(@"Band connected failed: No Band paired");
        return;
    }
    else{
        //  client attached, try connect
        [[MSBClientManager sharedManager] connectClient:_client];
        NSLog(@"Trying to connect to Band...");
    }
}

-(void)tryToDisconnectToBand{
    if(self.client && self.client.isDeviceConnected){
        [self stopAccelerometer];
        [self stopGyroscope];
        [[MSBClientManager sharedManager] cancelClientConnection:_client];
        
        NSLog(@"Trying to disconnect to Band...");
    }else{
        NSLog(@"Band is disconnected already!");
    }
}


#pragma mark - Accelerometer Utilities

-(void)startAccelerometer{
    _accelerometerOn = true;
    _AccelerometerLabelX.hidden = false;
    _AccelerometerLabelY.hidden = false;
    _AccelerometerLabelZ.hidden = false;
    [self.client.sensorManager startAccelerometerUpdatesToQueue:nil errorRef:nil withHandler:^(MSBSensorAccelerometerData *accelerometerData, NSError *error) {
        _AccelerometerLabelX.text = [NSString stringWithFormat:@"%+08.5f",accelerometerData.x];
        _AccelerometerLabelY.text = [NSString stringWithFormat:@"%+08.5f",accelerometerData.y];
        _AccelerometerLabelZ.text = [NSString stringWithFormat:@"%+08.5f",accelerometerData.z];
        if(self.ParseSwitch.on){
            
        }
        if(self.spheroRollOn){
            [self sendDataToSphero:accelerometerData];
        }
    }];
    NSLog(@"Accelerometer Started");
}
-(void)stopAccelerometer{
    _accelerometerOn = false;
    _AccelerometerLabelX.hidden = true;
    _AccelerometerLabelY.hidden = true;
    _AccelerometerLabelZ.hidden = true;
    [self.client.sensorManager stopAccelerometerUpdatesErrorRef:nil];
    NSLog(@"Accelerometer Stopped");
}

#pragma mark - Gyroscope Utilities

-(void)startGyroscope{
    _gyroscopeOn = true;
    _GyroscopeLabelX.hidden = false;
    _GyroscopeLabelY.hidden = false;
    _GyroscopeLabelZ.hidden = false;
    [self.client.sensorManager startGyroscopeUpdatesToQueue:nil errorRef:nil withHandler:^(MSBSensorGyroscopeData *gyroscopeData, NSError *error) {
        _GyroscopeLabelX.text = [NSString stringWithFormat:@"%+08.5f",gyroscopeData.x];
        _GyroscopeLabelY.text = [NSString stringWithFormat:@"%+08.5f",gyroscopeData.y];
        _GyroscopeLabelZ.text = [NSString stringWithFormat:@"%+08.5f",gyroscopeData.z];
        if(self.ParseSwitch.on){
            
        }
    }];
    NSLog(@"Gyroscope Started");
}
-(void)stopGyroscope{
    _gyroscopeOn = false;
    _GyroscopeLabelX.hidden = true;
    _GyroscopeLabelY.hidden = true;
    _GyroscopeLabelZ.hidden = true;
    [self.client.sensorManager stopGyroscopeUpdatesErrorRef:nil];
    NSLog(@"Gyroscope Stopped");
}

#pragma mark - Sphero Utilities

-(void)sendDataToSphero:(MSBSensorAccelerometerData *)data{
    float x = data.x;
    float y = data.y;
    float z = data.z;
//    float v = fabsf(x) / 3;
//    float c = 360.0;
//    float sign = (x >= 0) ? 1 : -1;
//    float rawD = atanf( z / y) * 2 * 180 / M_PI + 90 + 90 * sign;
//    float d = fmodf(rawD, c);
//    _vLabel.text = [NSString stringWithFormat:@"%+08.5f",v];
//    _dLabel.text = [NSString stringWithFormat:@"%+08.5f",d];
    float d = atan2f(y, -x);
    
    if (d < 0.0) { // adjust for range between 0 and 2π
        d += 2.0 * M_PI;
    }
    // correct angle
    //self.angle -= correctionAngle;
    if (d < 0.0) {
        d += 2.0 * M_PI;
    }
    
    d *= 180.0/M_PI;
    
    float v = sqrtf(x * x + y * y ) / 2;
        _vLabel.text = [NSString stringWithFormat:@"%+08.5f",v];
        _dLabel.text = [NSString stringWithFormat:@"%+08.5f",d];
    [RKRollCommand sendCommandWithHeading:d velocity:v];
}

#pragma mark - IBActions

- (IBAction)ConnectionSwitchTouchUpInside:(id)sender {
    switch (self.connectionState) {
        case -2:
            [self tryToConnectToBand];
            break;
        case 2:
            [self tryToDisconnectToBand];
            _ConnectionSwitch.enabled = false;
            _connectionState = -1;
            break;
        default:
            [NSException raise:@"Invalid case." format:@"case %d is invalid",self.connectionState];
            break;
    }
}

- (IBAction)AccelerometerSwitchTouchUpInside:(id)sender {
    if(self.accelerometerOn){
        [self stopAccelerometer];
    }else{
        [self startAccelerometer];
    }
}

- (IBAction)GyroscopeSwitchTouchUpInside:(id)sender {
    if(self.gyroscopeOn){
        [self stopGyroscope];
    }else{
        [self startGyroscope];
    }
}
-(IBAction)SpheroRollSwitchTouchUpInside:(id)sender{
    if(self.spheroRollOn){
        [[RKRobotProvider sharedRobotProvider] closeRobotConnection];
        _spheroRollOn = false;
    }else{
        [[RKRobotProvider sharedRobotProvider] openRobotConnection];
        // tail light always on
        RKGetOptionFlagsMask optionFlags = 0;
        optionFlags |= RKGetOptionFlagsTailLightAlwaysOn;
        [RKSetOptionFlagsCommand sendCommandWithOptionFlags:optionFlags];
        [RKRGBLEDOutputCommand sendCommandWithRed:1 green:0 blue:0];
        _spheroRollOn = true;
        [NSThread sleepForTimeInterval:3];
        [RKRollCommand sendCommandWithHeading:180 velocity:0];
        [NSThread sleepForTimeInterval:1];
        [RKCalibrateCommand sendCommandWithHeading:0.0f];
//        [NSThread sleepForTimeInterval:1];
        [RKRollCommand sendCommandWithHeading:0 velocity:0.5];
    }
}

- (IBAction)SpheroLightUpSwitchTouchUpInside:(id)sender {
    if(self.spheroLightOn){
        
    }else{
        
    }
}


@end
