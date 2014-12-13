//
//  ViewController.h
//  LightIsAwesome
//
//  Created by Kenneth Siu on 11/21/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Leg.h"
#import "PatternSlice.h"
#import "BLE/BLE.h"
#import <ISColorWheel.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, BLEDelegate>


@property NSMutableArray *legbuttons;

@property ISColorWheel *colorWheel;

@property NSTimer *loadColorTimer;

@property NSMutableArray *arrayOfPatterns;

@property UIPickerView *patternPicker;

@property BLE *bleModule;

@property UIButton *connectButton;

@property UIButton *disconnectButton;

@property UIActivityIndicatorView *spinner;

@property BOOL connected;

@property NSTimer *sendDataTimer;

@end
