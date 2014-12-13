//
//  ViewController.m
//  LightIsAwesome
//
//  Created by Kenneth Siu on 11/21/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Pattern.h"
#import "PatternSlice.h"

#define NUM_LEGS 6

@interface ViewController ()
{
}

@end

@implementation ViewController
@synthesize bleModule;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.connected = NO;
    
    //initialize ble
    bleModule = [[BLE alloc] init];
    [bleModule controlSetup];
    bleModule.delegate = self;
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height - 49)];
    screenFrame = self.view.frame;
    
    float connectButtonHeight = screenFrame.size.height / 10.0f;
    float connectButtonStart = screenFrame.size.height / 8.0f;
    
    CGRect buttonFrame = CGRectMake(0, connectButtonStart, screenFrame.size.width, connectButtonHeight);
    
    //need to create a connect button
    self.connectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.connectButton.frame = buttonFrame;
    
    self.connectButton.titleLabel.font = [UIFont systemFontOfSize:connectButtonHeight];
    
    //now set title
    [self.connectButton setTitle:@"Connect!" forState:UIControlStateNormal];
    
    [self.connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.connectButton addTarget:self action:@selector(connectButton:) forControlEvents:UIControlEventTouchDown];
    
    //need to create a connect button
    self.disconnectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.disconnectButton.frame = buttonFrame;
    
    self.disconnectButton.titleLabel.font = [UIFont systemFontOfSize:connectButtonHeight];
    
    //now set title
    [self.disconnectButton setTitle:@"Disconnect!" forState:UIControlStateNormal];
    
    [self.disconnectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.disconnectButton addTarget:self action:@selector(disconnectButton:) forControlEvents:UIControlEventTouchDown];
    [self.disconnectButton setHidden:YES];
    
    //create spinner and hide
    self.spinner = [[UIActivityIndicatorView alloc] initWithFrame:buttonFrame];
    [self.spinner setHidden:YES];
    self.spinner.color = [UIColor blackColor];
    self.spinner.transform = CGAffineTransformMakeScale(2.f, 2.f);
    
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.spinner];
    [self.view addSubview:self.disconnectButton];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.legbuttons = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib
    float widthOfButton = screenFrame.size.width / NUM_LEGS;
    
    float startHeightOfbutton = screenFrame.size.height / 4.0f;
    float heightOfButton = screenFrame.size.height / 10.0f;
    
    //make dem buttoms
    UIButton *colorPickerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-49, [[UIScreen mainScreen] bounds].size.width/2, 49)];
    
    [colorPickerButton setTitle:@"Color Picker" forState:UIControlStateNormal];
    
    [colorPickerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [colorPickerButton addTarget:self action:@selector(showColorPicker:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *patternPickerButton = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height-49, [[UIScreen mainScreen] bounds].size.width/2, 49)];
    
    [patternPickerButton setTitle:@"Pattern Picker" forState:UIControlStateNormal];
    
    [patternPickerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [patternPickerButton addTarget:self action:@selector(showPatternPicker:) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *startStopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-100, [[UIScreen mainScreen] bounds].size.width, 51)];
    
    [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [startStopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [startStopButton addTarget:self action:@selector(startOrStop:) forControlEvents:UIControlEventTouchDown];

    
    
    
    
    [self.view addSubview:patternPickerButton];
    [self.view addSubview:colorPickerButton];
    for(int i = 0; i < NUM_LEGS; i++) {
        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(i * widthOfButton, startHeightOfbutton, widthOfButton, heightOfButton)];
        
        [tempButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [tempButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
        
        [tempButton setBackgroundColor:[UIColor whiteColor]];
        
        [self.view addSubview:tempButton];
        
        [self.legbuttons addObject:tempButton];
    }
    
    float startHeightOfWheel = screenFrame.size.height - screenFrame.size.width;
    float heightOfWheel = screenFrame.size.width;
    
    
    self.colorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(0, startHeightOfWheel, heightOfWheel, heightOfWheel)];
    
     self.patternPicker= [[UIPickerView alloc] initWithFrame:CGRectMake(0, startHeightOfWheel, heightOfWheel, heightOfWheel)];
    self.arrayOfPatterns = [[NSMutableArray alloc] init];
    
    
    //HERE BEGINS JIMMY'S PATTERN OF HORROR
    
    UIColor *tempColor;
    PatternSlice *tempSlice;
    int durationFactor = .1;
    //(1,0,0)-(1,1,0)
    NSMutableArray *redYellow = [[NSMutableArray alloc] init];
    for(float i=.1; i<=1; i=i+.1)
        
    {
        tempColor = [UIColor colorWithRed:1. green:i blue:0 alpha:1];
        tempSlice = [[PatternSlice alloc] initWithDuration:durationFactor withColor:tempColor];
        [redYellow addObject: tempSlice];
    }
    
    //(1,1,0)-(0,1,0)
    NSMutableArray *yellowGreen = [[NSMutableArray alloc] init];
    for(float i=.1; i<=1; i+=.1)
    {
        tempColor = [UIColor colorWithRed:1.-i green:1 blue:0 alpha:1];
        tempSlice = [[PatternSlice alloc] initWithDuration:durationFactor withColor:tempColor];
        [yellowGreen addObject: tempSlice];
    }
    //(0,1,0)-(0,1,1)
    NSMutableArray *greenCyan = [[NSMutableArray alloc] init];
    for(float i=.1; i<=1; i+=.1)
    {
        tempColor = [UIColor colorWithRed:0. green:1. blue:i alpha:1];
        tempSlice = [[PatternSlice alloc] initWithDuration:durationFactor withColor:tempColor];
        [greenCyan addObject: tempSlice];
    }
    //(0,1,1)-(0,0,1)
    NSMutableArray *cyanBlue = [[NSMutableArray alloc] init];
    for(float i=.1; i<=1; i+=.1)
    {
        tempColor = [UIColor colorWithRed:0. green:1.-i blue:1 alpha:1];
        tempSlice = [[PatternSlice alloc] initWithDuration:durationFactor withColor:tempColor];
        [cyanBlue addObject: tempSlice];
    }
    //(0,0,1)-(1,0,1)
    NSMutableArray *bluePurple = [[NSMutableArray alloc] init];
    for(float i=.1; i<=1; i+=.1)
    {
        tempColor = [UIColor colorWithRed:i green:0 blue:1 alpha:1];
        tempSlice = [[PatternSlice alloc] initWithDuration:durationFactor withColor:tempColor];
        [bluePurple addObject: tempSlice];
    }
    //(1,0,1)-(1,0,0)
    NSMutableArray *purpleRed = [[NSMutableArray alloc] init];
    for(float i=.1; i<=1; i+=.1)
    {
        tempColor = [UIColor colorWithRed:1. green:0 blue:1-i alpha:1];
        tempSlice = [[PatternSlice alloc] initWithDuration:durationFactor withColor:tempColor];
        [purpleRed addObject: tempSlice];
    }
    
    NSMutableSet *leg1Set = [NSMutableSet setWithArray:redYellow];
    [leg1Set addObjectsFromArray:yellowGreen];
    [leg1Set addObjectsFromArray:greenCyan];
    [leg1Set addObjectsFromArray:cyanBlue];
    [leg1Set addObjectsFromArray:bluePurple];
    [leg1Set addObjectsFromArray:purpleRed];
    NSMutableArray *leg1Pattern = [[leg1Set allObjects] mutableCopy];
    
    NSMutableSet *leg2Set = [NSMutableSet setWithArray:yellowGreen];
    [leg2Set addObjectsFromArray:greenCyan];
    [leg2Set addObjectsFromArray:cyanBlue];
    [leg2Set addObjectsFromArray:bluePurple];
    [leg2Set addObjectsFromArray:purpleRed];
    [leg2Set addObjectsFromArray:redYellow];
    NSMutableArray *leg2Pattern = [[leg2Set allObjects] mutableCopy];
    
    NSMutableSet *leg3Set = [NSMutableSet setWithArray:greenCyan];
    [leg3Set addObjectsFromArray:cyanBlue];
    [leg3Set addObjectsFromArray:bluePurple];
    [leg3Set addObjectsFromArray:purpleRed];
    [leg3Set addObjectsFromArray:redYellow];
    [leg3Set addObjectsFromArray:yellowGreen];
    NSMutableArray *leg3Pattern = [[leg3Set allObjects] mutableCopy];
    
    NSMutableSet *leg4Set = [NSMutableSet setWithArray:cyanBlue];
    [leg4Set addObjectsFromArray:bluePurple];
    [leg4Set addObjectsFromArray:purpleRed];
    [leg4Set addObjectsFromArray:redYellow];
    [leg4Set addObjectsFromArray:yellowGreen];
    [leg4Set addObjectsFromArray:greenCyan];
    NSMutableArray *leg4Pattern = [[leg4Set allObjects] mutableCopy];
    
    NSMutableSet *leg5Set = [NSMutableSet setWithArray:bluePurple];
    [leg5Set addObjectsFromArray:purpleRed];
    [leg5Set addObjectsFromArray:redYellow];
    [leg5Set addObjectsFromArray:yellowGreen];
    [leg5Set addObjectsFromArray:greenCyan];
    [leg5Set addObjectsFromArray:cyanBlue];
    NSMutableArray *leg5Pattern = [[leg5Set allObjects] mutableCopy];
    
    NSMutableSet *leg6Set = [NSMutableSet setWithArray:purpleRed];
    [leg6Set addObjectsFromArray:redYellow];
    [leg6Set addObjectsFromArray:yellowGreen];
    [leg6Set addObjectsFromArray:greenCyan];
    [leg6Set addObjectsFromArray:cyanBlue];
    [leg6Set addObjectsFromArray:bluePurple];
    NSMutableArray *leg6Pattern = [[leg6Set allObjects] mutableCopy];
    Pattern *jimmysPattern = [[Pattern alloc] initWithTitle: @"Rainbow Swirl" withLeg1Pattern:leg1Pattern withLeg2Pattern:leg2Pattern withLeg3Pattern: leg3Pattern withLeg4Pattern:leg4Pattern withLeg5Pattern:leg5Pattern withLeg6Pattern:leg6Pattern];
    
    //END PATTERN OF HORROr
    

    
    
    [_arrayOfPatterns addObject:jimmysPattern];
    
    self.patternPicker.dataSource = self;
    self.patternPicker.delegate = self;
    
    [self.view addSubview:self.colorWheel];
    [self.view addSubview:_patternPicker];
    [_patternPicker setHidden:YES];
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
- (IBAction)showColorPicker:(id)sender
{
    [self.colorWheel setHidden:0];
    [_patternPicker setHidden:YES];
    for(UIButton *tempButt in self.legbuttons)
    {
        [tempButt setEnabled:YES];
    }
}
- (IBAction)showPatternPicker:(id)sender
{
    [self.colorWheel setHidden:YES];
    [_patternPicker setHidden:NO];
    for(UIButton *tempButt in self.legbuttons)
    {
        [[tempButt layer] setBorderWidth:0.0f];
        [tempButt setSelected:NO];
        [tempButt setEnabled:NO];
        
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
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrayOfPatterns.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return ((Pattern*)[self.arrayOfPatterns objectAtIndex:row]).title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}
-(IBAction)startOrStop:(id)sender
{
    //for(PatternSlice *tempSlice in [_patterpicker])
}
-(UIColor*) inverseColor:(UIColor*) color
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

//ibaction that button is selected
- (IBAction) connectButton:(id)sender {
    [self.connectButton setHidden:YES];
    [self.spinner setHidden:NO];
    
    if (bleModule.activePeripheral) {
        if(bleModule.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[bleModule CM] cancelPeripheralConnection:[bleModule activePeripheral]];
            return;
        }
    }
    
    [bleModule findBLEPeripherals:3];
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(findPeriphalsTimer:) userInfo:nil repeats:NO];
    
    [self.spinner startAnimating];
}

-(IBAction)disconnectButton:(id)sender {
    
    //disconnects
    [[bleModule CM] cancelPeripheralConnection:[bleModule activePeripheral]];
    
    //invalidate timer
    if(self.sendDataTimer) {
        [self.sendDataTimer invalidate];
        self.sendDataTimer = nil;
    }
}

-(IBAction)findPeriphalsTimer:(id)sender {
    if(bleModule.peripherals.count > 0) {
        [bleModule connectPeripheral:[bleModule.peripherals objectAtIndex:0]];
    } else {
        //not found, connect
        [self.spinner stopAnimating];
        [self.spinner setHidden:YES];
        [self.connectButton setHidden:NO];
    }
}

//connection timer
-(void) bleDidConnect {
    [self.spinner stopAnimating];
    [self.spinner setHidden:YES];
    [self.disconnectButton setHidden:NO];
    self.connected = YES;
    
    self.sendDataTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendBTData:) userInfo:nil repeats:NO];
}

-(IBAction)sendBTData:(id)sender {
    
    NSData *dataToSend;
    NSString *sendString;
    NSString *stringSend = @"";
    
    for(int i = 0; i < [self.legbuttons count]; i++) {
        UIButton* butt = (UIButton*)[self.legbuttons objectAtIndex:i];
        
        UIColor *buttonColor = [butt backgroundColor];
        
        CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
        [buttonColor getRed:&red green:&green blue:&blue alpha:&alpha];
        
        int redSend = (int)(red * 255);
        int greenSend = (int)(green * 255);
        int blueSend = (int)(blue * 255);
        
        //has rgb
        sendString = [NSString stringWithFormat:@"%d|%d|%d|%d", i+1, redSend, greenSend, blueSend];
        
        if(i != 0) {
            stringSend = [NSString stringWithFormat:@"%@^%@", stringSend, sendString];
        } else {
            stringSend = sendString;
        }
    }
    
    stringSend = [NSString stringWithFormat:@"%@*", stringSend];
    
    dataToSend = [stringSend dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(stringSend);
    
    [bleModule write:dataToSend];
}

-(void) bleDidDisconnect {
    [self.disconnectButton setHidden:YES];
    self.connected = NO;
    [self.connectButton setHidden:NO];
}

-(void) bleDidUpdateRSSI:(NSNumber *) rssi {

}

-(void) bleDidReceiveData:(unsigned char *) data length:(int) length {
    
}

@end
