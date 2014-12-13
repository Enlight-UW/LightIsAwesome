//
//  Pattern.m
//  LightIsAwesome
//
//  Created by Jimmy Dallman on 12/5/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "Pattern.h"

@implementation Pattern
-(id) initWithTitle:(NSString*)title
    withLeg1Pattern:(NSMutableArray*)leg1Pattern
    withLeg2Pattern:(NSMutableArray*)leg2Pattern
    withLeg3Pattern:(NSMutableArray*)leg3Pattern
    withLeg4Pattern:(NSMutableArray*)leg4Pattern
    withLeg5Pattern:(NSMutableArray*)leg5Pattern
    withLeg6Pattern:(NSMutableArray*)leg6Pattern





{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.legPattern = @[leg1Pattern, leg2Pattern, leg3Pattern, leg4Pattern, leg5Pattern, leg6Pattern];
    }
    return self;
}
@end
