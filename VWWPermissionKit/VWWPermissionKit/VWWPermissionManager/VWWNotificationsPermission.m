//
//  VWWNotifictionsPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWNotificationsPermission.h"
@import UIKit;

static NSString *VWWPermissionsManagerNotificationsPromptedKey = @"notificationsPrompted";

@interface VWWNotificationsPermission ()

@end

@implementation VWWNotificationsPermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWNotificationsPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    UIUserNotificationSettings *settings = [UIApplication sharedApplication].currentUserNotificationSettings;
    if(settings.types == UIUserNotificationTypeNone){
        NSNumber *promptedNumber = [[NSUserDefaults standardUserDefaults] objectForKey:VWWPermissionsManagerNotificationsPromptedKey];
        if(promptedNumber == nil){
            self.status = VWWPermissionStatusNotDetermined;
        } else {
            if(promptedNumber.unsignedIntegerValue == 0){
                self.status = VWWPermissionStatusDenied;
            } else {
                self.status = VWWPermissionStatusDenied;
            }
        }
    } else {
        self.status = VWWPermissionStatusAuthorized;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __nonnull note) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
        
        [self updatePermissionStatus];
        completionBlock();
    }];
    
    // Set a flag that says the prompt has been displayed
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:VWWPermissionsManagerNotificationsPromptedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Generate iOS prompt
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
}

@end
