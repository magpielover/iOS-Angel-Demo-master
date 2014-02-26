/*
 *  deviceSelector.m
 *
 * Created by Ole Andreas Torvmark on 10/2/12.
 * Copyright (c) 2012 Texas Instruments Incorporated - http://www.ti.com/
 * ALL RIGHTS RESERVED
 */

#import "deviceSelector.h"
#import "infoTabBarController.h"
@interface deviceSelector ()

@end

@implementation deviceSelector
@synthesize m,nDevices,sensorTags;





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.m = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.nDevices = [[NSMutableArray alloc]init];
    self.sensorTags = [[NSMutableArray alloc]init];
    NSLog(@"DEvice selector View DID load");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    self.m.delegate = self;

}


- (IBAction)angelIconClicked{
    CBPeripheral *p = [self.sensorTags objectAtIndex: 0];
    
    BLEDevice *d = [[BLEDevice alloc]init];
    
    d.p = p;
    d.manager = self.m;
    d.setupData = [self makeSensorTagConfiguration];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    
    infoTabBarController *infoTab = (infoTabBarController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"infoTabBar"];
    
    
    [infoTab initBLE:d];
    
     [self presentViewController:infoTab animated:YES completion:nil];
    
    //[self performSegueWithIdentifier:@"InfoView2" sender:self];
}






#pragma mark - CBCentralManager delegate

-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state != CBCentralManagerStatePoweredOn) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BLE not supported !" message:[NSString stringWithFormat:@"CoreBluetooth return state: %d",central.state] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        [central scanForPeripheralsWithServices:nil options:nil];
    }
}




-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"Found a BLE Device : %@",peripheral);
    
    /* iOS 6.0 bug workaround : connect to device before displaying UUID !
       The reason for this is that the CFUUID .UUID property of CBPeripheral
       here is null the first time an unkown (never connected before in any app)
       peripheral is connected. So therefore we connect to all peripherals we find.
    */
    
    peripheral.delegate = self;
    [central connectPeripheral:peripheral options:nil];
    
    [self.nDevices addObject:peripheral];
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [peripheral discoverServices:nil];
}

#pragma  mark - CBPeripheral delegate

-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    BOOL replace = NO;
    BOOL found = NO;
    NSLog(@"Services scanned !");
    [self.m cancelPeripheralConnection:peripheral];
    for (CBService *s in peripheral.services) {
        NSLog(@"Service found : %@",s.UUID);
        if ([s.UUID isEqual:[CBUUID UUIDWithString:@"F000AA00-0451-4000-B000-000000000000"]])  {
            NSLog(@"This is a SensorTag !");
            found = YES;
        }
    }
    if (found) {
        // Match if we have this device from before
        for (int ii=0; ii < self.sensorTags.count; ii++) {
            CBPeripheral *p = [self.sensorTags objectAtIndex:ii];
            if ([p isEqual:peripheral]) {
                    [self.sensorTags replaceObjectAtIndex:ii withObject:peripheral];
                    replace = YES;
                }
            }
        if (!replace) {
            [self.sensorTags addObject:peripheral];
           
        }
    }
    // angel appears
    [self.angelIcon setHidden:NO];

}

-(void) peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"didUpdateNotificationStateForCharacteristic %@ error = %@",characteristic,error);
}

-(void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"didWriteValueForCharacteristic %@ error = %@",characteristic,error);
}


#pragma mark - SensorTag configuration

-(NSMutableDictionary *) makeSensorTagConfiguration {
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    // First we set ambient temperature
    [d setValue:@"1" forKey:@"Ambient temperature active"];
    // Then we set IR temperature
    [d setValue:@"1" forKey:@"IR temperature active"];
    // Append the UUID to make it easy for app
    [d setValue:@"F000AA00-0451-4000-B000-000000000000"  forKey:@"IR temperature service UUID"];
    [d setValue:@"F000AA01-0451-4000-B000-000000000000" forKey:@"IR temperature data UUID"];
    [d setValue:@"F000AA02-0451-4000-B000-000000000000"  forKey:@"IR temperature config UUID"];
    // Then we setup the accelerometer
    [d setValue:@"1" forKey:@"Accelerometer active"];
    [d setValue:@"500" forKey:@"Accelerometer period"];
    [d setValue:@"F000AA10-0451-4000-B000-000000000000"  forKey:@"Accelerometer service UUID"];
    [d setValue:@"F000AA11-0451-4000-B000-000000000000"  forKey:@"Accelerometer data UUID"];
    [d setValue:@"F000AA12-0451-4000-B000-000000000000"  forKey:@"Accelerometer config UUID"];
    [d setValue:@"F000AA13-0451-4000-B000-000000000000"  forKey:@"Accelerometer period UUID"];
    
    //Then we setup the rH sensor
    [d setValue:@"1" forKey:@"Humidity active"];
    [d setValue:@"F000AA20-0451-4000-B000-000000000000"   forKey:@"Humidity service UUID"];
    [d setValue:@"F000AA21-0451-4000-B000-000000000000" forKey:@"Humidity data UUID"];
    [d setValue:@"F000AA22-0451-4000-B000-000000000000" forKey:@"Humidity config UUID"];
    
    //Then we setup the magnetometer
    [d setValue:@"1" forKey:@"Magnetometer active"];
    [d setValue:@"500" forKey:@"Magnetometer period"];
    [d setValue:@"F000AA30-0451-4000-B000-000000000000" forKey:@"Magnetometer service UUID"];
    [d setValue:@"F000AA31-0451-4000-B000-000000000000" forKey:@"Magnetometer data UUID"];
    [d setValue:@"F000AA32-0451-4000-B000-000000000000" forKey:@"Magnetometer config UUID"];
    [d setValue:@"F000AA33-0451-4000-B000-000000000000" forKey:@"Magnetometer period UUID"];
    
    //Then we setup the barometric sensor
    [d setValue:@"1" forKey:@"Barometer active"];
    [d setValue:@"F000AA40-0451-4000-B000-000000000000" forKey:@"Barometer service UUID"];
    [d setValue:@"F000AA41-0451-4000-B000-000000000000" forKey:@"Barometer data UUID"];
    [d setValue:@"F000AA42-0451-4000-B000-000000000000" forKey:@"Barometer config UUID"];
    [d setValue:@"F000AA43-0451-4000-B000-000000000000" forKey:@"Barometer calibration UUID"];
    
    [d setValue:@"1" forKey:@"Gyroscope active"];
    [d setValue:@"F000AA50-0451-4000-B000-000000000000" forKey:@"Gyroscope service UUID"];
    [d setValue:@"F000AA51-0451-4000-B000-000000000000" forKey:@"Gyroscope data UUID"];
    [d setValue:@"F000AA52-0451-4000-B000-000000000000" forKey:@"Gyroscope config UUID"];

    NSLog(@"%@",d);
    return d;
}

@end
