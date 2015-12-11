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
    VWWContactsPermission *contacts = [VWWContactsPermission permissionWithLabelText:@"The app will merge duplicate contacts."];
    VWWPhotosPermission *photos = [VWWPhotosPermission permissionWithLabelText:@"We can save recorded videos to your Photos library."];
    VWWCoreLocationAlwaysPermission *locationAlways = [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"For calculating your heading, altitude, speed, distance home, and more."];
    
    NSArray *permissions = @[contacts, locationAlways, photos];

    
    [VWWPermissionsManager optionPermissions:permissions
                                       title:@"Welcome! To get the most out of this Fancy App, we will need your permission to use some things. Let's get started."
                          fromViewController:self
                                resultsBlock:^(NSArray *permissions) {
                                    [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                        NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                    }];
                                }];
}

@end
