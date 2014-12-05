//
//  ViewController.m
//  LightIsAwesome
//
//  Created by Kenneth Siu on 11/21/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


#define NUM_LEGS 6

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height - 49)];
    screenFrame = self.view.frame;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.legbuttons = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib
    float widthOfButton = screenFrame.size.width / NUM_LEGS;
    
    float startHeightOfbutton = screenFrame.size.height / 7.0f;
    float heightOfButton = screenFrame.size.height / 10.0f;
    
    //make dem buttoms
    for(int i = 0; i < NUM_LEGS; i++) {
        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(i * widthOfButton, startHeightOfbutton, widthOfButton, heightOfButton)];
        
        [tempButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [tempButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview:tempButton];
        
        [self.legbuttons addObject:tempButton];
    }
    
    float startHeightOfWheel = screenFrame.size.height / 3.0f;
    float heightOfWheel = screenFrame.size.width;
    
    
    self.colorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(0, startHeightOfWheel, heightOfWheel, heightOfWheel)];
    
    [self.view addSubview:self.colorWheel];
    
    self.loadColorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(checkColors:) userInfo:nil repeats:YES];
    
    
}

- (IBAction)checkColors:(id)sender {
    for(UIButton *tempButt in self.legbuttons) {
        
        //see if button is selected, if so, change color
        if([tempButt isSelected]) {
            UIColor *inverted = [self inverseColor:[self.colorWheel currentColor]];
            
            [[tempButt layer] setBorderWidth:2.0f];
            [[tempButt layer] setBorderColor:inverted.CGColor];
            
            [tempButt setBackgroundColor:[self.colorWheel currentColor]];
            [tempButt setTitleColor:inverted forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSelected:(id)sender {
    UIButton *tempButt = (UIButton*) sender;
    
    //removes border if button is already selected
    if([tempButt isSelected]) {
        [[tempButt layer] setBorderWidth:0.0f];
        [tempButt setSelected:NO];
    } else {
        //adds border if button is selected
        UIColor *inverted = [self inverseColor:[self.colorWheel currentColor]];
        
        [[tempButt layer] setBorderWidth:2.0f];
        [[tempButt layer] setBorderColor:inverted.CGColor];
        
        [tempButt setBackgroundColor:[self.colorWheel currentColor]];
        [tempButt setTitleColor:inverted forState:UIControlStateNormal];
        [tempButt setSelected:YES];
    }
}

-(UIColor*) inverseColor:(UIColor*) color
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

@end
