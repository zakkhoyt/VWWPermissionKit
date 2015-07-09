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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self setupAppearance];
    [self showPermissions];
}

-(void)setupAppearance{
    [[UILabel appearance] setTextColor:[UIColor cyanColor]];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Marker Felt" size:14]];
    [[UIButton appearance] setTintColor:[UIColor magentaColor]];
    [[UIButton appearance] setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [[UIButton appearance].titleLabel setFont:[UIFont fontWithName:@"Marker Felt" size:20]];
}

-(void)showPermissions{
    
    NSSet *shareTypes = [NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent],
                         [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate],
                         [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
                         nil];
    NSSet *readTypes = shareTypes;
    
    VWWHealthPermission *health = [VWWHealthPermission permissionWithLabelText:@"This app will analyize how drunk you've been and how your body likes it." shareTypes:shareTypes readTypes:readTypes];
    VWWCameraPermission *camera = [VWWCameraPermission permissionWithLabelText:@"This app lets your record videos, so we need to access your camera"];
    VWWPhotosPermission *photos = [VWWPhotosPermission permissionWithLabelText:@"We can save recorded videos to your Photos library."];
    VWWCoreLocationAlwaysPermission *locationAlways = [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"For calculating your heading, altitude, speed, distance home, etc... This is a bunch of nonsense text to show that labels will grow with the size of the defined text. This text that you are reading right now. Period."];


    NSArray *permissions = @[health, camera, locationAlways, photos];
    
    [VWWPermissionsManager optionPermissions:permissions
                                        title:@"Welcome to the VWWPermissionKitExample app. Our app uses many of your device's sensors. We'll help you set up some permissions, then get started."
                           fromViewController:self
                                 resultsBlock:^(NSArray *permissions) {
                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                     }];
                                 }];
    
    

}


@end
