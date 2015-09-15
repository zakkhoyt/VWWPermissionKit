//
//  VWWRemindersPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWRemindersPermission.h"
@import EventKit;

@interface VWWRemindersPermission ()
@property (nonatomic, strong) EKEventStore *eventStore;
@end

@implementation VWWRemindersPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWRemindersPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if(status == EKAuthorizationStatusNotDetermined){
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == EKAuthorizationStatusAuthorized){
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == EKAuthorizationStatusDenied){
        self.status = VWWPermissionStatusDenied;
    } else if(status == EKAuthorizationStatusRestricted){
        self.status = VWWPermissionStatusRestricted;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.eventStore == nil){
        self.eventStore = [[EKEventStore alloc]init];
    }
    
    [self.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * __nullable error) {
        completionBlock(granted);
    }];
}

@end
