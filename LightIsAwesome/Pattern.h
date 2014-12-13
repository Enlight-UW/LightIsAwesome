//
//  Pattern.h
//  LightIsAwesome
//
//  Created by Jimmy Dallman on 12/5/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pattern : NSObject
@property NSString *title;

@property NSArray *legPattern;
-(id) initWithTitle:(NSString*)title
    withLeg1Pattern:(NSMutableArray*)leg1Pattern
    withLeg2Pattern:(NSMutableArray*)leg2Pattern
    withLeg3Pattern:(NSMutableArray*)leg3Pattern
    withLeg4Pattern:(NSMutableArray*)leg4Pattern
    withLeg5Pattern:(NSMutableArray*)leg5Pattern
    withLeg6Pattern:(NSMutableArray*)leg6Pattern;

@end
