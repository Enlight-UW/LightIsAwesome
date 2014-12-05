//
//  PatternSlice.m
//  LightMagic
//
//  Created by Kenneth Siu on 11/14/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "PatternSlice.h"

@implementation PatternSlice

-(id) initWithDuration:(float)duration withColor:(UIColor*)color withLegNumber:(int)nLegNum {
    
    self = [super init];
    
    if(self) {
        self.duration = duration;
        self.color = color;
        self.legNumber = nLegNum;
        return self;
    }
    
    return nil;
}


@end
