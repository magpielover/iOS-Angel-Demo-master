//
//  InventoryViewController.m
//  AngelInventory
//
//  Created by Ugur Kirbac on 2/27/14.
//  Copyright (c) 2014 Ugur Kirbac. All rights reserved.
//

#import "InventoryViewController.h"


@implementation InventoryViewController

@synthesize imgPicker,resultTextView;

-(IBAction)StartScan:(id) sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    reader.readerView.torchMode = 0;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
   //[reader release];
    
    resultTextView.hidden=NO;
}

- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry{
    NSLog(@"the image picker failing to read");
    
}

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    
    
    NSLog(@"the image picker is calling successfully %@",info);
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    NSString *hiddenData;
    for(symbol in results)
        hiddenData=[NSString stringWithString:symbol.data];
    NSLog(@"the symbols  is the following %@",symbol.data);
    // EXAMPLE: just grab the first barcode
    //  break;
    
    // EXAMPLE: do something useful with the barcode data
    //resultText.text = symbol.data;
    resultTextView.text=symbol.data;
    
    
    NSLog(@"BARCODE= %@",symbol.data);
    
    NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
    [storeData setObject:hiddenData forKey:@"CONSUMERID"];
    NSLog(@"SYMBOL : %@",hiddenData);
    resultTextView.text=hiddenData;
    [reader dismissModalViewControllerAnimated: NO];
    
}
@end

