//
//  Leg.h
//  LightMagic
//
//  Created by Kenneth Siu on 11/14/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PatternSlice.h"

@interface Leg : NSObject

@property UIColor* currColor;
@property BOOL isOn;
@property NSMutableArray *patternList;

@end
