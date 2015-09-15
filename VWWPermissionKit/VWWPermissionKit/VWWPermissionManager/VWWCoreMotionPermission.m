//
//  VWWCoreMotionPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCoreMotionPermission.h"
@import  CoreMotion;

static NSString *VWWCoreMotionPermissionMotionReceivedKey = @"VWWCoreMotionPermissionMotionReceivedKey";

@interface VWWCoreMotionPermission ()
@property (nonatomic, strong) CMMotionActivityManager *motionManager;
@end

@implementation VWWCoreMotionPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWCoreMotionPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    if([CMMotionActivityManager isActivityAvailable] == NO){
        self.status = VWWPermissionStatusServiceNotAvailable;
    } else {
        if([[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])] == nil){
            // Prompt has never been presented
            self.status = VWWPermissionStatusNotDetermined;
        } else {
            // Prompt has been presented in the past
            if([[NSUserDefaults standardUserDefaults] objectForKey:VWWCoreMotionPermissionMotionReceivedKey] == nil){
                self.status = VWWPermissionStatusDenied;
            } else {
                self.status = VWWPermissionStatusAuthorized;
            }
        }
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    [super presentSystemPromtWithCompletionBlock:completionBlock];
    
    if(self.motionManager == nil){
        self.motionManager = [[CMMotionActivityManager alloc]init];
    }
    
    // Mark permission as been prompted
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:NSStringFromClass([self class])];
    
    // Clear reading key
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:VWWCoreMotionPermissionMotionReceivedKey];
    
    [self.motionManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity * __nullable activity) {
        // Now that we've recieved a reading, mark it as such and stop reading.
        [self.motionManager stopActivityUpdates];
        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:VWWCoreMotionPermissionMotionReceivedKey];
        return completionBlock();
    }];
    
    // TODO: Figure out a way to capture denied permission
    //    return completionBlock();
}

@end
