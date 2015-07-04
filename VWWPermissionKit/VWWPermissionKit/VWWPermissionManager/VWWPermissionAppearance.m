//
//  VWWPermissionAppearance.m
//  VWWPermissionKit
//
//  Created by Zakk Hoyt on 7/3/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWPermissionAppearance.h"

@implementation VWWPermissionAppearance

+(instancetype)appearanceFromViewController:(UIViewController*)viewController{
    VWWPermissionAppearance *appearance = [[self alloc]init];
    
    appearance.backgroundColor = [UIColor whiteColor];
    
    appearance.tintColor = viewController.view.tintColor;
    
    appearance.uninitializedTextColor = appearance.tintColor;
    appearance.uninitializedColor = [UIColor whiteColor];
    
    appearance.notDeterminedTextColor = appearance.tintColor;
    appearance.notDeterminedColor = [UIColor whiteColor];
    
    appearance.authorizedTextColor = [UIColor whiteColor];
    appearance.authorizedColor = [UIColor colorWithRed:0 green:0.7 blue:0 alpha:1]; // Darkish green
    
    appearance.deniedTextColor = [UIColor whiteColor];
    appearance.deniedColor = [UIColor redColor];
    
    appearance.restrictedTextColor = [UIColor whiteColor];
    appearance.restrictedColor = [UIColor redColor];

    appearance.serviceNotAvailableTextColor = [UIColor lightGrayColor];
    appearance.serviceNotAvailableColor = [UIColor whiteColor];
    
    return appearance;
}
@end
