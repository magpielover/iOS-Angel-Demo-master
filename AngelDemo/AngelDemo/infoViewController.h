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
@interface infoViewController :  UIViewController <CBCentralManagerDelegate,CBPeripheralDelegate>


@property (weak, nonatomic) IBOutlet UILabel *tempValue;
@property (weak, nonatomic) IBOutlet UILabel *humidityValue;
@property (weak, nonatomic) IBOutlet UILabel *motionValue;




@property (strong,nonatomic) sensorIMU3000 *gyroSensor;


@property (strong,nonatomic) BLEDevice *d;
@property NSMutableArray *sensorsEnabled;


@property (strong,nonatomic) sensorTagValues *currentVal;
@property (strong,nonatomic) NSMutableArray *vals;


-(void) configureSensorTag;
-(void) deconfigureSensorTag;


- (IBAction) handleCalibrateMag;
- (IBAction) handleCalibrateGyro;

-(void) alphaFader:(NSTimer *)timer;
-(void) logValues:(NSTimer *)timer;


@end
