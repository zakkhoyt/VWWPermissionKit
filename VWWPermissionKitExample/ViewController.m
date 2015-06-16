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

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSArray *permissions =
    @[
      [VWWCameraPermission permissionWithLabelText:@"In order to access your camera to record video."],
      [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"To calculate your heading, altitude, speed, distance home, etc..."],
      [VWWPhotosPermission permissionWithLabelText:@"To save your videos to your Photos library."],
      ];
    
    // Using requirePermissions:permissions, the user cannot proceed until all permissions are authorized
    [VWWPermissionsManager requirePermissions:permissions
                                        title:@"We need your approvoal before we get running"
                           fromViewController:self
                                 resultsBlock:^(NSArray *permissions) {
                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                     }];
                                 }];
    
//    // Using optionPermissions, a done button will always appear regardless of authorization status
//    [VWWPermissionsManager optionPermissions:permissions
//                                        title:@"We need your approvoal before we get running"
//                           fromViewController:self
//                                 resultsBlock:^(NSArray *permissions) {
//                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
//                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
//                                     }];
//                                 }];

    
}

@end
