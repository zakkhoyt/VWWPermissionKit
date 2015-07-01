//
//  VWWHealthPermission.h
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWPermission.h"
@import  HealthKit;

// NSHealthShareUsageDescription
// NSHealthUpdateUsageDescription

static NSString *VWWHealthPermissionType = @"Health";

@interface VWWHealthPermission : VWWPermission

/*!
 @method     permissionWithLabelText:shareTypes:readTypes
 @abstract
 @discussion Created a permission object for HealthKit. This permission is different in that you need to include a set of types.
 
 @param      labelText      Text for the display label above the button
 @param      shareTypes     A set of HKObjectType which will be shared (same set that you'll pass to HealthKit later)
 @param      readTypes      A set of HKObjectType which will be read (same set that you'll pass to HealthKit later)
 */

+(instancetype)permissionWithLabelText:(NSString*)labelText
                            shareTypes:(NSSet*)shareTypes
                             readTypes:(NSSet*)readTypes;

@end
