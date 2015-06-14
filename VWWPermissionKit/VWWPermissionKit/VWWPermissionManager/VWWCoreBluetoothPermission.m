//
//  VWWBluetoothPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCoreBluetoothPermission.h"
@import CoreBluetooth;
@interface VWWCoreBluetoothPermission ()
@property (nonatomic, strong) CBPeripheralManager *bluetoothManager;
@end

@implementation VWWCoreBluetoothPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWBluetoothPermissionType labelText:labelText];
}


-(void)updatePermissionStatus{
    CBPeripheralManagerAuthorizationStatus status = [CBPeripheralManager authorizationStatus];
    if(status == CBPeripheralManagerAuthorizationStatusNotDetermined){
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == CBPeripheralManagerAuthorizationStatusAuthorized){
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == CBPeripheralManagerAuthorizationStatusDenied){
        self.status = VWWPermissionStatusDenied;
    } else if(status == CBPeripheralManagerAuthorizationStatusRestricted){
        self.status = VWWPermissionStatusRestricted;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.bluetoothManager == nil){
        self.bluetoothManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:nil];
    }
    
    // No way to subscribe to authorization changes
    for(NSUInteger index = 0; index < 10; index++){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(index * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updatePermissionStatus];
        });
    }
}

@end
