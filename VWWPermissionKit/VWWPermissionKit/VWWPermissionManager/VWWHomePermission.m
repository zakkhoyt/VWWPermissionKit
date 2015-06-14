//
//  VWWHomePermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWHomePermission.h"
@import HomeKit;

@interface VWWHomePermission ()
@property (nonatomic, strong) HMHomeManager *homeManager;
@end

@implementation VWWHomePermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWHomePermissionType labelText:labelText];
}


-(void)updatePermissionStatus{
    self.status = VWWPermissionStatusNotDetermined;
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.homeManager == nil){
        self.homeManager = [[HMHomeManager alloc]init];
        //        self.homeManager.delegate = self;
    }
    
}

@end
