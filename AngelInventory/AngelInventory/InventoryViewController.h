//
//  InventoryViewController.h
//  AngelInventory
//
//  Created by Ugur Kirbac on 2/27/14.
//  Copyright (c) 2014 Ugur Kirbac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface InventoryViewController : UIViewController <UIImagePickerControllerDelegate,ZBarReaderDelegate>{
    
    IBOutlet UITextView *resultTextView;
}
@property (nonatomic, retain) IBOutlet UITextView *resultTextView;
@property (nonatomic, retain) UIImagePickerController *imgPicker;

-(IBAction)StartScan:(id) sender;

@end