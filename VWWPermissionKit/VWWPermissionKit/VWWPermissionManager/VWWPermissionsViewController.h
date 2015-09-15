//
//  VWWPermissionsViewController.h
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import <UIKit/UIKit.h>
@class VWWPermission;

static NSString *VWWPermissionsViewControllerIdentifier = @"VWWPermissionsViewController";

typedef void (^VWWPermissionsViewControllerEmptyBlock)();

@interface VWWPermissionsViewController : UIViewController
@property (nonatomic, strong) NSArray *permissions;
@property (nonatomic, strong) NSString *titleText;
-(void)refresh;
-(void)setCloseButtonTitle:(NSString*)title;
-(void)setCompletionBlock:(VWWPermissionsViewControllerEmptyBlock)completionBlock;
-(void)displayDeniedAlertForPermission:(VWWPermission*)permission;
@end
