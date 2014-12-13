//
//  BluetoothSingleton.h
//  LightIsAwesome
//
//  Created by Kenneth Siu on 11/23/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import <Foundation/Foundation.h>

@import QuartzCore;
@import CoreBluetooth;

//this will contain all the bluetooth logic so that one could potentially easily use this to set each leg to a certain color
@interface BluetoothSingleton : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

//bluetooth objects
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
//used to hold the services so that one can use them later
@property (nonatomic, strong) NSMutableDictionary *servicesDict;
@property CBCharacteristicWriteType writeType;
//used to find the bluetooth module
@property (nonatomic, strong) NSArray *servicesArr;

//service defines on the BLE
#define LEG_0_SERVICE_UUID @""
#define LEG_1_SERVICE_UUID @""
#define LEG_2_SERVICE_UUID @""
#define LEG_3_SERVICE_UUID @""
#define LEG_4_SERVICE_UUID @""
#define LEG_5_SERVICE_UUID @""

//Leg 0
#define R_0_CHARACTERISTIC_UUID @""
#define G_0_CHARACTERISTIC_UUID @""
#define B_0_CHARACTERISTIC_UUID @""

//Leg 1
#define R_1_CHARACTERISTIC_UUID @""
#define G_1_CHARACTERISTIC_UUID @""
#define B_1_CHARACTERISTIC_UUID @""

//Leg 2
#define R_2_CHARACTERISTIC_UUID @""
#define G_2_CHARACTERISTIC_UUID @""
#define B_2_CHARACTERISTIC_UUID @""

//Leg 3
#define R_3_CHARACTERISTIC_UUID @""
#define G_3_CHARACTERISTIC_UUID @""
#define B_3_CHARACTERISTIC_UUID @""

//Leg 4
#define R_4_CHARACTERISTIC_UUID @""
#define G_4_CHARACTERISTIC_UUID @""
#define B_4_CHARACTERISTIC_UUID @""

//Leg 5
#define R_5_CHARACTERISTIC_UUID @""
#define G_5_CHARACTERISTIC_UUID @""
#define B_5_CHARACTERISTIC_UUID @""

//Leg 6
#define R_6_CHARACTERISTIC_UUID @""
#define G_6_CHARACTERISTIC_UUID @""
#define B_6_CHARACTERISTIC_UUID @""


//functions
-(void) disconnect;


//singleton function
+(id) singleton;


@end
