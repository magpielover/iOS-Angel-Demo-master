//
//  infoTabBarController.h
//  AngelDemo
//
//  Created by Ugur Kirbac on 2/25/14.
//  Copyright (c) 2014 Ugur Kirbac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLEDevice.h"
#import "BLEUtility.h"
#import "Sensors.h"
#import "infoViewController.h"
@interface infoTabBarController : UITabBarController<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (strong,nonatomic) infoViewController *infoView;

@property (strong,nonatomic) BLEDevice *m_bleDevice;
@property NSMutableArray *sensorsEnabled;
@property (strong,nonatomic) sensorIMU3000 *gyroSensor;
- (void)initBLE:(BLEDevice*) bleDevice;

@property (strong,nonatomic) sensorTagValues *currentVal;
@property (strong,nonatomic) NSMutableArray *vals;
@property (strong,nonatomic) NSTimer *logTimer;

@property float logInterval;

-(void) configureSensorTag;
-(void) deconfigureSensorTag;




- (IBAction) handleCalibrateMag;
- (IBAction) handleCalibrateGyro;

-(void) alphaFader:(NSTimer *)timer;
-(void) logValues:(NSTimer *)timer;




@end
