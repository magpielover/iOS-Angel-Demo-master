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

@interface infoViewController :  UIViewController


@property (weak, nonatomic) IBOutlet UILabel *tempValue;
@property (weak, nonatomic) IBOutlet UILabel *humidityValue;

@property (weak, nonatomic) IBOutlet UILabel *motionValue;


-(void)setLabelValues:(NSString*)temp humidity:(NSString*)humidity motion:(NSString*)motion;
-(void)setTemp:(NSString*)temp;
-(void)setHumidity:(NSString*)humidity;
-(void)setMotion:(NSString*)motion;
- (void)test;
@end
