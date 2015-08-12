//
//  ViewController.m
//  MuseTrainer
//
//  Created by Jieyi Hu on 6/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if([WCSession isSupported]){
        NSLog(@"WCSession on iPhone is supported.");
        _session = [WCSession defaultSession];
        _session.delegate = self;
        [_session activateSession];
        NSLog(@"WCSession on iPhone is activated.");
    } else{
        NSLog(@"WCSession on iPhone is not supported.");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)session:(nonnull WCSession *)session didReceiveUserInfo:(nonnull NSDictionary<NSString *,id> *)userInfo{
    NSLog(@"DataSet received by iPhone");
    if([self.ParseSwitch isOn]){
        [self uploadToParse:userInfo];
    } else{
        [self storeToLocal:userInfo];
    }
}

-(void)uploadToParse:(nonnull NSDictionary<NSString*,id>*)userInfo{

    
    NSMutableArray* array = [userInfo objectForKey:@"dataset"];
    NSDictionary* lastDict = [array objectAtIndex:[array count] - 1];
    
    for(id dict in array){
        PFObject* data = [PFObject objectWithClassName:@"accelerometerData"];
        data[@"datetime"] = [dict objectForKey:@"datasettimestamp"];
        data[@"classifier"] = [dict objectForKey:@"classifier"];
        data[@"timestamp"] = [dict objectForKey:@"timestamp"];
        data[@"x"] = [dict objectForKey:@"x"];
        data[@"y"] = [dict objectForKey:@"y"];
        data[@"z"] = [dict objectForKey:@"z"];
        [data saveInBackgroundWithBlock:^(BOOL succeeded, NSError * __nullable error) {
            if(succeeded){
                NSLog(@"Data is uploaded to Parse");
                if(dict ==  lastDict){
                    NSLog(@"DataSet is uploaded to Parse");
                }
            }
            else{
                NSLog(@"Data is not uploaded to Parse");
                if(dict ==  lastDict){
                    NSLog(@"DataSet is uploaded to Parse");
                }
            }
        }];
    }

}

-(void)storeToLocal:(nonnull NSDictionary<NSString*,id>*)userInfo{
    NSMutableArray* dataset = [userInfo objectForKey:@"dataset"];
    if(dataset == nil){
        NSLog(@"dataset is nil");
    } else{
        NSError* error;
        NSString* datasetJsonString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dataset options:NSJSONWritingPrettyPrinted error:&error] encoding:NSUTF8StringEncoding];
        NSString* fileName = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[self datetimeNowString]] stringByAppendingString:@".txt"];
        [datasetJsonString writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"DataSet is stored locally.");
    }
}

-(NSString*)datetimeNowString{
    NSDate * datetimeNow = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"'D_'yyyy'_'MM'_'dd'_T_'HH'_'mm'_'ss'_'SSS"];
    NSString *datetimeNowString = [dateFormatter stringFromDate:datetimeNow];
    return datetimeNowString;
}

@end
