//
//  VWWPermission.h
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    VWWPermissionStatusUninitialized = 0,
    VWWPermissionStatusNotDetermined,
    VWWPermissionStatusAuthorized,
    VWWPermissionStatusDenied,
    VWWPermissionStatusRestricted,
    VWWPermissionStatusServiceNotAvailable = 0xFF
} VWWPermissionStatus;

typedef void (^VWWPermissionEmptyBlock)();

@protocol VWWPermissionProtocol <NSObject>
@required
+(instancetype)permissionWithLabelText:(NSString*)labelText;
-(void)updatePermissionStatus;
-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock;
@end



@interface VWWPermission : NSObject  <VWWPermissionProtocol>
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *labelText;
@property (nonatomic) VWWPermissionStatus status;
@property (nonatomic) BOOL required;
-(instancetype)initWithType:(NSString*)type labelText:(NSString*)labelText;
-(NSString*)stringForStatus;
@end


