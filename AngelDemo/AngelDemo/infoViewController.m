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
@synthesize humidityValue,tempValue,motionValue;


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
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setLabelValues:(NSString*)temp humidity:(NSString*)humidity motion:(NSString*)motion{
   
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.tempValue.text = temp;
        self.humidityValue.text = humidity;
        self.motionValue.text = motion;
    });
    
  
}


-(void)setTemp:(NSString*)temp{
     self.tempValue.text = temp;
}

-(void)setHumidity:(NSString*)humidity{
     self.humidityValue.text = humidity;
}
-(void)setMotion:(NSString*)motion{
      self.motionValue.text = motion;
}


- (void)test{
    NSLog(@"TEST GIRDI");
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
    
    if (self.motionValue) {
        [self.motionValue.textColor getWhite:&w alpha:&a];
        if (a > MIN_ALPHA_FADE) a -= ALPHA_FADE_STEP;
        self.motionValue.textColor = [self.motionValue.textColor colorWithAlphaComponent:a];
    }

}




@end
