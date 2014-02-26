//
//  infoViewController.m
//  AngelDemo
//
//  Created by Guest Account on 2/24/14.
//  Copyright (c) 2014 Ugur Kirbac. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController
@synthesize humidityValue,tempValue,myRSSIValue;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(alphaFader:) userInfo:nil repeats:YES];
    self.forgetAlertEnabled = FALSE;
    self.motionAlertEnabled = FALSE;
    self.motionAlertIgnored = FALSE;
    self.userResponded = TRUE;
    
	// Do any additional setup after loading the view.
}
- (IBAction)switchMotion:(id)sender {
    
    if(self.motionSwitch.on)
    {
        self.motionAlertEnabled = TRUE;
        self.motionAlertIgnored  = FALSE;
    }
    else{
        self.motionAlertEnabled = FALSE;
    }
}

- (IBAction)switchForget:(id)sender {
    
    if(self.forgetSwitch.on)
    {
        self.forgetAlertEnabled = TRUE;
    }
    else{
        self.forgetAlertEnabled = FALSE;
    }
}

// Motion detection and warning
-(void)sendWarningonMotion{
    
    if(self.userResponded)
    {
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
   
    if(self.motionAlertEnabled && !self.motionAlertIgnored){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Angel Moved!"
                                                        message:@"What do you want to do?"
                                                       delegate:self
                                              cancelButtonTitle:@"Ignore"
                                              otherButtonTitles:nil];
        
        [alert show];
         self.userResponded = FALSE;
    }
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        self.motionAlertIgnored = TRUE;
        self.userResponded = TRUE;
    }
        
}



-(void)deviceDisconnected{
    if(self.userResponded)
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Angel is lost!"
                                                    message:@"Do you know where it is?"
                                                   delegate:self
                                          cancelButtonTitle:@"Ignore"
                                          otherButtonTitles:nil];
    
    [alert show];
        self.userResponded = FALSE;
    
}
}


// Forget Alert Implement

-(void)sendWarningonForget{
    if(self.userResponded && self.forgetAlertEnabled)
    {
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self]
        
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Did you forget your angel?"
                                                        message:@"Go get it back!"
                                                       delegate:self
                                              cancelButtonTitle:@"Got it!"
                                              otherButtonTitles:nil];
        
        [alert show];
         self.userResponded = FALSE;
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setLabelValues:(NSString*)temp humidity:(NSString*)humidity RSSI:(NSString*)myRSSI{
   
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.tempValue.text = temp;

    });
    
  
}


-(void)setTemp:(NSString*)temp{
     self.tempValue.text = temp;
}

-(void)setHumidity:(NSString*)humidity{
     self.humidityValue.text = humidity;
}
-(void)setRSSIValue:(NSNumber*)myRSSI{
 if(myRSSI != nil)
 {
     NSString *numberStr = [NSNumberFormatter localizedStringFromNumber:myRSSI numberStyle:NSNumberFormatterDecimalStyle];

    self.myRSSIValue.text= numberStr;
     
     if([myRSSI intValue]>(-90) && [myRSSI intValue]<(-80)){
         [self sendWarningonForget];
     }
   
 }
   

}




-(void) alphaFader:(NSTimer *)timer {
    CGFloat w,a;
    if (self.tempValue) {
        [self.tempValue.textColor getWhite:&w alpha:&a];
        if (a > MIN_ALPHA_FADE) a -= ALPHA_FADE_STEP;
        self.tempValue.textColor = [self.tempValue.textColor colorWithAlphaComponent:a];
    }


    if (self.humidityValue) {
        [self.humidityValue.textColor getWhite:&w alpha:&a];
        if (a > MIN_ALPHA_FADE) a -= ALPHA_FADE_STEP;
        self.humidityValue.textColor = [self.humidityValue.textColor colorWithAlphaComponent:a];
    }
    
    if (self.myRSSIValue) {
        [self.myRSSIValue.textColor getWhite:&w alpha:&a];
        if (a > MIN_ALPHA_FADE) a -= ALPHA_FADE_STEP;
        self.myRSSIValue.textColor = [self.myRSSIValue.textColor colorWithAlphaComponent:a];
    }

}




@end
