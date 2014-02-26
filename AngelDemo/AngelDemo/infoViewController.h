//
//  infoViewController.h
//  AngelDemo
//
//  Created by Guest Account on 2/24/14.
//  Copyright (c) 2014 Ugur Kirbac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLEDevice.h"
#import "BLEUtility.h"
#import "Sensors.h"

#define MIN_ALPHA_FADE 0.2f
#define ALPHA_FADE_STEP 0.05f

@interface infoViewController :  UIViewController<UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *tempValue;
@property (weak, nonatomic) IBOutlet UILabel *humidityValue;

@property (weak, nonatomic) IBOutlet UILabel *myRSSIValue;

@property (weak, nonatomic) IBOutlet UILabel *random;

-(void)setLabelValues:(NSString*)temp humidity:(NSString*)humidity motion:(NSString*)motion;
-(void)setTemp:(NSString*)temp;
-(void)setHumidity:(NSString*)humidity;
-(void)setRSSIValue:(NSNumber*)myRSSI;
-(void)deviceDisconnected;
//Motion Detection
-(void)sendWarningonMotion;
-(void)sendWarningonForget;
@property BOOL isMotionDetected;
@property BOOL motionAlertEnabled;
@property BOOL forgetAlertEnabled;
@property BOOL motionAlertIgnored;
@property BOOL forgetAlertIgnored;
@property BOOL userResponded;
@property (weak, nonatomic) IBOutlet UISwitch *motionSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *forgetSwitch;

@end
