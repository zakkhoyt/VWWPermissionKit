//
//  VWWCoreLocationWhenInUsePermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCoreLocationWhenInUsePermission.h"
@import CoreLocation;

@interface VWWCoreLocationWhenInUsePermission () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) VWWPermissionEmptyBlock locationStatusChangeBlock;
@end

@implementation VWWCoreLocationWhenInUsePermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWCoreLocationWhenInUserPermissionType labelText:labelText];
}


-(void)updatePermissionStatus{
    if([CLLocationManager significantLocationChangeMonitoringAvailable] == NO){
        self.status = VWWPermissionStatusServiceNotAvailable;
    } else {        
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
            self.status = VWWPermissionStatusAuthorized;
        } else if(status == kCLAuthorizationStatusAuthorizedAlways){
            self.status = VWWPermissionStatusDenied;
        } else if(status == kCLAuthorizationStatusNotDetermined) {
            self.status = VWWPermissionStatusNotDetermined;
        } else if(status == kCLAuthorizationStatusDenied) {
            self.status = VWWPermissionStatusDenied;
        } else if(status == kCLAuthorizationStatusRestricted) {
            self.status = VWWPermissionStatusRestricted;
        }
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    self.locationStatusChangeBlock = completionBlock;
    if(self.locationManager == nil){
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
    }
    
    
    [self.locationManager requestWhenInUseAuthorization];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    self.locationStatusChangeBlock();
}


@end
