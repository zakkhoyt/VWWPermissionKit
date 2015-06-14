//
//  VWWAssetLibraryPermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWAssetLibraryPermission.h"
@import AssetsLibrary;

@interface VWWAssetLibraryPermission ()
@property (nonatomic, strong) ALAssetsLibrary *library;
@end

@implementation VWWAssetLibraryPermission
+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWAssetLibraryPermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if(status == ALAuthorizationStatusNotDetermined){
        self.status = VWWPermissionStatusNotDetermined;
    } else if(status == ALAuthorizationStatusAuthorized) {
        self.status = VWWPermissionStatusAuthorized;
    } else if(status == ALAuthorizationStatusDenied) {
        self.status = VWWPermissionStatusDenied;
    } else if(status == ALAuthorizationStatusRestricted) {
        self.status = VWWPermissionStatusRestricted;
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.library == nil){
        self.library = [[ALAssetsLibrary alloc]init];
    }
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        *stop = YES;
        return completionBlock();
    } failureBlock:^(NSError *error) {
        return completionBlock();
    }];
}

@end
