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
    //    HKObjectType *type = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    HKObjectType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:type];
    if(status == HKAuthorizationStatusNotDetermined){
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == HKAuthorizationStatusSharingAuthorized){
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == HKAuthorizationStatusSharingDenied){
        self.status = VWWPermissionStatusDenied;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.healthStore == nil){
        self.healthStore = [[HKHealthStore alloc]init];
        
    }
    
    HKObjectType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    NSSet *readTypes = [NSSet setWithObject:type];
    
    //    HKObjectType *bacType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    //    NSSet *writeTypes = [NSSet setWithObject:bacType];
    
    [self.healthStore requestAuthorizationToShareTypes:readTypes readTypes:readTypes completion:^(BOOL success, NSError * __nullable error) {
        if(error){
            NSLog(@"HealthKit permission error: %@", error.localizedDescription);
        }
        completionBlock();
    }];
    
}

@end
