//
//  VWWAccountsPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWAccountsPermission.h"
@import Accounts;

@interface VWWAccountsPermission ()
@property (nonatomic, strong) ACAccountStore *accountStore;
@end

@implementation VWWAccountsPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWAccountsPermissionType labelText:labelText];
}


-(void)updatePermissionStatus{
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.accountStore == nil){
        self.accountStore = [[ACAccountStore alloc] init];
    }
    
    ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:twitterAccountType  options:nil completion:^(BOOL granted, NSError *error) { //completion handling is on indeterminate queue so I force main queue inside
        completionBlock();
    }];
    
}

@end
