//
//  BluetoothSingleton.m
//  LightIsAwesome
//
//  Created by Kenneth Siu on 11/23/14.
//  Copyright (c) 2014 Kenneth Siu. All rights reserved.
//

#import "BluetoothSingleton.h"

@implementation BluetoothSingleton

+(id)singleton {
    static BluetoothSingleton* singleton;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        singleton = [[self alloc] init];
        singleton.servicesDict = [[NSMutableDictionary alloc] init];
    });
    
    return singleton;
}

- (void) initBluetooth {
    if(self.centralManager == nil) {
        //setup services
        self.servicesArr = @[[CBUUID UUIDWithString:LEG_0_SERVICE_UUID], [CBUUID UUIDWithString:LEG_1_SERVICE_UUID], [CBUUID UUIDWithString:LEG_2_SERVICE_UUID], [CBUUID UUIDWithString:LEG_3_SERVICE_UUID], [CBUUID UUIDWithString:LEG_4_SERVICE_UUID], [CBUUID UUIDWithString:LEG_5_SERVICE_UUID]];
        
        //set write type
        self.writeType = CBCharacteristicWriteWithoutResponse;
        
        //initialize the central manager
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        [self.centralManager scanForPeripheralsWithServices:self.servicesArr options:nil];
    } //if central manager is allocated
    else {
        
    }
}

# pragma mark - CBCentralManagerDelegate
- (void) centralManagerDidUpdateState:(CBCentralManager *)central {
    //determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}

//this will help use know more about the peripheral found
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString *localName = [advertisementData objectForKeyedSubscript:CBAdvertisementDataLocalNameKey];
    
    if([localName length] > 0) {
        NSLog(@"Found the Peripheral: %@", localName);
        [self.centralManager stopScan];
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        // Connect to peripheral and read/write data
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

//method called when successfully connected to BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Did connect to Peripheral");
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
}

#pragma mark - CBPeripheralDelegate

//this will be invoked when one discovers the peripheral's available services
- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"Services Discovered!");
    
    self.peripheral = peripheral;
    
    for(CBService *service in peripheral.services) {
        NSLog(@"Service: %@", service.UUID);
        //figure out the legs of each service
        [self.peripheral discoverCharacteristics:nil forService:service];
    }
}

//invoke when discover characteristics of specified service
- (void)peripheral:(CBPeripheral*) peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    //set services into dictionary to be used for later
    if([service.UUID isEqual:[CBUUID UUIDWithString:LEG_0_SERVICE_UUID]]) {
        [self.servicesDict setValue:service forKey:LEG_0_SERVICE_UUID];
    } else if([service.UUID isEqual:[CBUUID UUIDWithString:LEG_1_SERVICE_UUID]]) {
        [self.servicesDict setValue:service forKey:LEG_1_SERVICE_UUID];
    } else if([service.UUID isEqual:[CBUUID UUIDWithString:LEG_2_SERVICE_UUID]]) {
        [self.servicesDict setValue:service forKey:LEG_2_SERVICE_UUID];
    } else if([service.UUID isEqual:[CBUUID UUIDWithString:LEG_3_SERVICE_UUID]]) {
        [self.servicesDict setValue:service forKey:LEG_3_SERVICE_UUID];
    } else if([service.UUID isEqual:[CBUUID UUIDWithString:LEG_4_SERVICE_UUID]]) {
        [self.servicesDict setValue:service forKey:LEG_4_SERVICE_UUID];
    } else if([service.UUID isEqual:[CBUUID UUIDWithString:LEG_5_SERVICE_UUID]]) {
        [self.servicesDict setValue:service forKey:LEG_5_SERVICE_UUID];
    }
}

- (void) disconnect {
    if(self.centralManager != nil) {
        [self.centralManager cancelPeripheralConnection:self.peripheral];
        self.centralManager = nil;
    }
}

@end
