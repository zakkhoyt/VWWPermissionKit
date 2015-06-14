//
//  VWWPermission.m
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import "VWWPermission.h"

@interface VWWPermission ()

@end

@implementation VWWPermission


- (instancetype)initWithType:(NSString*)type labelText:(NSString*)labelText{
    self = [super init];
    if (self) {
        _type = type;
        _labelText = labelText;
        _status = VWWPermissionStatusUninitialized;
    }
    return self;
}

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    NSAssert(NO, @"Child class must impelment");
    return nil;    
}

-(instancetype)initWithLabelText:(NSString*)labelText{
    NSAssert(NO, @"Child class must impelment");
    return nil;
}

-(void)updatePermissionStatus{
    NSAssert(NO, @"Child class must impelment");
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    NSAssert(NO, @"Child class must impelment");
}

-(NSString*)description{
    return [NSString stringWithFormat:@"%@ - %@", NSStringFromClass([self class]), [self stringForStatus]];
}

-(NSString*)stringForStatus{
    switch (self.status) {
        case VWWPermissionStatusAuthorized:
            return @"Authorized";
            break;
        case VWWPermissionStatusNotDetermined:
            return @"Not determined";
            break;
        case VWWPermissionStatusDenied:
            return @"Denied";
            break;
        case VWWPermissionStatusRestricted:
            return @"Restricted";
            break;
        case VWWPermissionStatusUninitialized:
        default:
            return @"Not initialized";
            break;
    }
}

@end
