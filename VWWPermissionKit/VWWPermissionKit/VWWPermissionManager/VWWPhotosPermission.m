//
//  VWWPhotosPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWPhotosPermission.h"
@import Photos;

@implementation VWWPhotosPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWPhotosPermissionType labelText:labelText];
}


-(void)updatePermissionStatus{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusAuthorized){
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == PHAuthorizationStatusNotDetermined) {
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == PHAuthorizationStatusDenied) {
        self.status = VWWPermissionStatusDenied;
    } else if(status == PHAuthorizationStatusRestricted) {
        self.status = VWWPermissionStatusRestricted;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        completionBlock();
    }];
}
@end
