//
//  VWWCameraPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCameraPermission.h"
@import AVFoundation;

@interface VWWCameraPermission ()

@end

@implementation VWWCameraPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWCameraPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    // Check for availablity
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if(videoDevices.count == 0){
        self.status = VWWPermissionStatusServiceNotAvailable;
    } else {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusNotDetermined){
            self.status = VWWPermissionStatusNotDetermined;
        } else if(status == AVAuthorizationStatusAuthorized){
            self.status = VWWPermissionStatusAuthorized;
        } else if(status == AVAuthorizationStatusDenied) {
            self.status = VWWPermissionStatusDenied;
        } else if(status == AVAuthorizationStatusRestricted) {
            self.status = VWWPermissionStatusRestricted;
        }
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            completionBlock();
        }];
    });
}

@end
