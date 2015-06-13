//
//  VWWCoreLocationAlwaysPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCoreLocationAlwaysPermission.h"
@import CoreLocation;


@interface VWWCoreLocationAlwaysPermission () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) VWWPermissionEmptyBlock locationStatusChangeBlock;
@end

@implementation VWWCoreLocationAlwaysPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWCoreLocationAlwaysPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    dispatch_async(dispatch_get_main_queue(), ^{
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
            self.status = VWWPermissionStatusDenied;
        } else if(status == kCLAuthorizationStatusAuthorizedAlways){
            self.status = VWWPermissionStatusAuthorized;
        } else if(status == kCLAuthorizationStatusNotDetermined) {
            self.status = VWWPermissionStatusNotDetermined;
        } else if(status == kCLAuthorizationStatusDenied) {
            self.status = VWWPermissionStatusDenied;
        } else if(status == kCLAuthorizationStatusRestricted) {
            self.status = VWWPermissionStatusRestricted;
        }
    });
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    self.locationStatusChangeBlock = completionBlock;
    if(self.locationManager == nil){
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
    }
    
    [self.locationManager requestAlwaysAuthorization];
    
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedAlways){
        self.locationStatusChangeBlock();
    }
}


@end
