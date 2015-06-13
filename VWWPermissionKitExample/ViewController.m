//
//  ViewController.m
//  VWWPermissionKitExample
//
//  Created by Zakk Hoyt on 6/13/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ViewController.h"
#import <VWWPermissionKit/VWWPermissionKit.h>

@implementation ViewController

- (IBAction)permissionButtonTouchUpInside:(id)sender {
    NSArray *permissions = @[
                             [VWWAccountsPermission permissionWithLabelText:@"accounts"],
                             [VWWBluetoothPermission permissionWithLabelText:@"bluetooth"],
                             [VWWHealthPermission permissionWithLabelText:@"health"],
                             [VWWHomePermission permissionWithLabelText:@"home"],
                             [VWWCoreMotionPermission permissionWithLabelText:@"motion"],
                             [VWWAssetLibraryPermission permissionWithLabelText:@"assets library"],
                             [VWWCameraPermission permissionWithLabelText:@"camera"],
                             [VWWCalendarsPermission permissionWithLabelText:@"calendar"],
                             [VWWContactsPermission permissionWithLabelText:@"contacts"],
                             [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"location always"],
                             [VWWNotificationsPermission  permissionWithLabelText:@"notification"],
                             [VWWMicrophonePermission permissionWithLabelText:@"microphone"],
                             [VWWPhotosPermission permissionWithLabelText:@"photos"],
                             [VWWRemindersPermission permissionWithLabelText:@"reminders"],
                             ];
    
    [VWWPermissionsManager enforcePermissions:permissions
                                        title:@"We'll need some things from you before we get running"
                           fromViewController:self
                                 resultsBlock:^(NSArray *permissions) {
                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                     }];
                                 }];

}

@end
