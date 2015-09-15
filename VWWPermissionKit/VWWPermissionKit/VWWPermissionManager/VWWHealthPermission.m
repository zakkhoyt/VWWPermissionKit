//
//  VWWHealthPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWHealthPermission.h"



@interface VWWHealthPermission ()
@property (nonatomic, strong) HKHealthStore *healthStore;
@property (nonatomic, strong) NSSet *shareTypes;
@property (nonatomic, strong) NSSet *readTypes;
@end

@implementation VWWHealthPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText
                            shareTypes:(NSSet*)shareTypes
                             readTypes:(NSSet*)readTypes{
    VWWHealthPermission *healthPermission = [[super alloc] initWithType:VWWHealthPermissionType labelText:labelText];
    healthPermission.shareTypes = shareTypes;
    healthPermission.readTypes = readTypes;
    return healthPermission;
}

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    NSAssert(NO, @"VWWHealthPermission requires the use of permissionWithLabelText:labelText:shareTypes:readTypes");
    return nil;
}


-(void)updatePermissionStatus{
    if([HKHealthStore isHealthDataAvailable] == NO){
        self.status = VWWPermissionStatusServiceNotAvailable;
    } else {
        // We really only care about the permission prompt in general, not each share and read type. Use first available type
        HKObjectType *type = [self.shareTypes anyObject];
        if(type == nil) {
            type = [self.readTypes anyObject];
        }
        
        HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:type];
        if(status == HKAuthorizationStatusNotDetermined){
            self.status = VWWPermissionStatusNotDetermined;
        } else if(status == HKAuthorizationStatusSharingAuthorized){
            self.status = VWWPermissionStatusAuthorized;
        } else if(status == HKAuthorizationStatusSharingDenied){
            self.status = VWWPermissionStatusDenied;
        }
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.healthStore == nil){
        self.healthStore = [[HKHealthStore alloc]init];
    }
    
    [self.healthStore requestAuthorizationToShareTypes:self.shareTypes readTypes:self.readTypes completion:^(BOOL success, NSError * __nullable error) {
        if(error){
            NSLog(@"HealthKit permission error: %@", error.localizedDescription);
        }
        completionBlock();
    }];
}

@end
