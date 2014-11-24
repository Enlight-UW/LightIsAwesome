//
//  Leg.m
//  LightMagic
//
//  Created by Kenneth Siu on 11/14/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "Leg.h"

@implementation Leg

-(id) initWithCurrentColor:(UIColor*)currColor isOn:(BOOL) isOn {
    
    self = [super init];
    
    if(self) {
        self.currColor = currColor;
        self.isOn = isOn;
        self.patternList = [[NSMutableArray alloc] init];
        return self;
    }
    
    return nil;
}

@end
