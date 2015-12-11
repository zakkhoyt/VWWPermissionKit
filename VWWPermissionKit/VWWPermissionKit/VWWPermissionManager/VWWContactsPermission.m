//
//  VWWContactsPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWContactsPermission.h"

@import Contacts;

@interface VWWContactsPermission ()
@property (nonatomic, strong)  CNContactStore *contactStore;
@end

@implementation VWWContactsPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWContactsPermissionTypeContacts labelText:labelText];
}

-(void)updatePermissionStatus{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if(status == CNAuthorizationStatusNotDetermined){
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == CNAuthorizationStatusAuthorized){
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == CNAuthorizationStatusDenied){
        self.status = VWWPermissionStatusDenied;
    } else if(status == CNAuthorizationStatusRestricted){
        self.status = VWWPermissionStatusRestricted;
    }

}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.contactStore == nil) {
        self.contactStore = [[CNContactStore alloc]init];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            completionBlock();
        }];
    });
}

@end
