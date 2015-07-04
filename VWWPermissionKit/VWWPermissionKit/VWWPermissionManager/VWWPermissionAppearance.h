//
//  VWWPermissionAppearance.h
//  VWWPermissionKit
//
//  Created by Zakk Hoyt on 7/3/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VWWPermissionAppearance : NSObject

@property (nonatomic, strong) NSString *navigationBarText;
@property (nonatomic, strong) NSString *tableHeaderText;
@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, strong) UIColor *uninitializedColor;
@property (nonatomic, strong) UIColor *uninitializedTextColor;

@property (nonatomic, strong) UIColor *notDeterminedColor;
@property (nonatomic, strong) UIColor *notDeterminedTextColor;

@property (nonatomic, strong) UIColor *authorizedColor;
@property (nonatomic, strong) UIColor *authorizedTextColor;

@property (nonatomic, strong) UIColor *deniedColor;
@property (nonatomic, strong) UIColor *deniedTextColor;

@property (nonatomic, strong) UIColor *restrictedColor;
@property (nonatomic, strong) UIColor *restrictedTextColor;

@property (nonatomic, strong) UIColor *serviceNotAvailableColor;
@property (nonatomic, strong) UIColor *serviceNotAvailableTextColor;

+(instancetype)appearanceFromViewController:(UIViewController*)viewController;

@end
