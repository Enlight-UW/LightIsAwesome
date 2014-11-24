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
#import <ISColorWheel.h>

@interface ViewController : UIViewController

@property NSMutableArray *legbuttons;

@property ISColorWheel *colorWheel;

@property NSTimer *loadColorTimer;

@end
