//
//  VWWContactsPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWContactsPermission.h"
@import AddressBook;

@interface VWWContactsPermission ()

@end

@implementation VWWContactsPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWContactsPermissionTypeCalendars labelText:labelText];
}

-(void)updatePermissionStatus{
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if(status == kABAuthorizationStatusNotDetermined){
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == kABAuthorizationStatusAuthorized){
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == kABAuthorizationStatusDenied){
        self.status = VWWPermissionStatusDenied;
    } else if(status == kABAuthorizationStatusRestricted){
        self.status = VWWPermissionStatusRestricted;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    CFErrorRef abError = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &abError);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        completionBlock();
    });
    
}

@end
