//
//  VWWCalendarsPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWCalendarsPermission.h"
@import EventKit;

@interface VWWCalendarsPermission ()
@property (nonatomic, strong) EKEventStore *eventStore;
@end

@implementation VWWCalendarsPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWCalendarsPermissionType labelText:labelText];
}


-(void)updatePermissionStatus{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
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
    
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * __nullable error) {
        completionBlock();
    }];
    
}

@end
