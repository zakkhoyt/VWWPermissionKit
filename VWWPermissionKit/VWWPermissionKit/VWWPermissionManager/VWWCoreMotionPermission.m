//
//  VWWCoreMotionPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCoreMotionPermission.h"
@import  CoreMotion;

@interface VWWCoreMotionPermission ()
@property (nonatomic, strong) CMMotionActivityManager *motionManager;
@end

@implementation VWWCoreMotionPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWCoreMotionPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    self.status = VWWPermissionStatusNotDetermined;
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.motionManager == nil){
        self.motionManager = [[CMMotionActivityManager alloc]init];
    }
    
    [self.motionManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity * __nullable activity) {
        
        completionBlock();
        [self.motionManager stopActivityUpdates];
        NSLog(@"motion");
    }];

}

@end
