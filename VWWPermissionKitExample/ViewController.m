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
    
////    NSSet *shareTypes = [NSSet setWithObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent]];
////    NSSet *readTypes = shareTypes;
//    
//    NSArray *permissions =
//    @[
////      [VWWHealthPermission permissionWithLabelText:@"healthKit" shareTypes:shareTypes readTypes:readTypes]
//      [VWWCoreMotionPermission permissionWithLabelText:@"Core Motion"],
//      ];
//    
//    // Using requirePermissions:permissions, the user cannot proceed until all permissions are authorized
//    [VWWPermissionsManager requirePermissions:permissions
//                                        title:@"We need your approvoal before we get running"
//                           fromViewController:self
//                                 resultsBlock:^(NSArray *permissions) {
//                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
//                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
//                                     }];
//                                 }];
//    
//    //    // Using optionPermissions, a done button will always appear regardless of authorization status
//    //    [VWWPermissionsManager optionPermissions:permissions
//    //                                        title:@"We need your approvoal before we get running"
//    //                           fromViewController:self
//    //                                 resultsBlock:^(NSArray *permissions) {
//    //                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
//    //                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
//    //                                     }];
//    //                                 }];
//    
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor magentaColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor yellowColor]];
    [[UILabel appearance] setTextColor:[UIColor greenColor]];
    [[[UIButton appearance] titleLabel] setTextColor:[UIColor purpleColor]];
    
    
    
    
    VWWCameraPermission *camera = [VWWCameraPermission permissionWithLabelText:@"We need to access your camera to record video. We need to access your camera to record video. We need to access your camera to record video."];
    VWWCoreLocationAlwaysPermission *locationAlways = [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"For calculating your heading, altitude, speed, distance home, etc... For calculating your heading, altitude, speed, distance home, etc... For calculating your heading, altitude, speed, distance home, etc..."];
    VWWPhotosPermission *photos = [VWWPhotosPermission permissionWithLabelText:@"To save your videos to your Photos library. To save your videos to your Photos library. To save your videos to your Photos library."];
    VWWCalendarsPermission *calendar = [VWWCalendarsPermission permissionWithLabelText:@"ad fasdf asd fas dfasdfasdf asdfasdfljad adlldjads faldfjaljfksad slf adfl aldf asdfj "];
    VWWRemindersPermission *reminders = [VWWRemindersPermission permissionWithLabelText:@"ad fasdf asd fas dfasdfasdf asdfasdfljad adlldjads faldfjaljfksad slf adfl aldf asdfj "];
    NSArray *permissions = @[camera, locationAlways, photos, calendar, reminders];
    
    VWWPermissionAppearance *appearance = [VWWPermissionAppearance new];
    
    appearance.backgroundColor = [UIColor orangeColor];
    appearance.tintColor = [UIColor purpleColor];
    
    appearance.authorizedColor = [UIColor blueColor];
    appearance.authorizedTextColor = [UIColor orangeColor];
    
    appearance.deniedColor = [UIColor yellowColor];
    appearance.deniedTextColor = [UIColor blackColor];
    
    appearance.restrictedColor = [UIColor blackColor];
    appearance.restrictedTextColor = [UIColor blackColor];
    
    appearance.notDeterminedColor = [UIColor cyanColor];
    appearance.notDeterminedTextColor = [UIColor magentaColor];
    
    [VWWPermissionsManager optionPermissions:permissions
                                        title:@"We'll need some things from you before we get started. We'll need some things from you before we get started. We'll need some things from you before we get started. We'll need some things from you before we get started."
                           fromViewController:self
                                  appearance:nil
                                 resultsBlock:^(NSArray *permissions) {
                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                     }];
                                 }];
}

@end
