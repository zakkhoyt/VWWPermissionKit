//
//  VWWPermissionsManager.m
//
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import "VWWPermissionsManager.h"
#import "VWWPermissionsViewController.h"
#import "VWWPermissionNotifications.h"

typedef void (^VWWPermissionsManagerEmptyBlock)();

@interface VWWPermissionsManager ()
@property (nonatomic, strong) NSArray *permissions;
@property (nonatomic, strong) VWWPermissionsManagerResultsBlock resultsBlock;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) VWWPermissionsViewController *permissionsViewController;
@property (nonatomic) BOOL required;
@end

@implementation VWWPermissionsManager

#pragma mark Public methods

+(void)requirePermissions:(NSArray*)permissions
                    title:(NSString*)title
       fromViewController:(UIViewController*)viewController
             resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock {
    VWWPermissionsManager *permissionsManager = [[self alloc]init];
    [permissionsManager displayPermissions:permissions
                                  required:YES title:title
                        fromViewController:viewController
                              resultsBlock:resultsBlock];
}

+(void)optionPermissions:(NSArray*)permissions
                   title:(NSString*)title
      fromViewController:(UIViewController*)viewController
            resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock {
    VWWPermissionsManager *permissionsManager = [[self alloc]init];
    [permissionsManager displayPermissions:permissions required:NO title:title fromViewController:viewController resultsBlock:resultsBlock];
}

+(void)readPermissions:(NSArray*)permissions resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock{
    VWWPermissionsManager *permissionsManager = [[self alloc]init];
    [permissionsManager readPermissions:permissions resultsBlock:resultsBlock];
}

#pragma mark Private methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:VWWPermissionNotificationsPromptAction object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            dispatch_async(dispatch_get_main_queue(), ^{
                VWWPermission *permission = note.userInfo[VWWPermissionNotificationsPermissionKey];
                [permission presentSystemPromtWithCompletionBlock:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [permission updatePermissionStatus];
                        
                        if(permission.status == VWWPermissionStatusDenied){
                            [self.permissionsViewController displayDeniedAlertForPermission:permission];
                        }
                        
                        
                        
                        [self checkAllPermissionsSatisfied];
                    });
                }];
            });
        }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self readPermissions];
            });
        }];
        
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)checkAllPermissionsSatisfied{
    if(self.required){
        for(VWWPermission *permission in self.permissions) {
            if(permission.status != VWWPermissionStatusAuthorized){
                [self.permissionsViewController setCloseButtonTitle:nil];
                return NO;
            }
        }
        [self.permissionsViewController setCloseButtonTitle:@"Done"];
        return YES;
        
    } else {
        [self.permissionsViewController setCloseButtonTitle:@"Done"];
        for(VWWPermission *permission in self.permissions) {
            if(permission.status != VWWPermissionStatusAuthorized){
                return NO;
            }
        }
        return YES;
    }
}

-(void)readPermissions{
    [self.permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
        [permission updatePermissionStatus];
    }];
}

-(void)showPermissionsViewControllerFromViewController:(UIViewController*)viewController{
    NSBundle* resourcesBundle = [NSBundle bundleForClass:[VWWPermissionsManager class]];
    self.permissionsViewController = [[resourcesBundle loadNibNamed:VWWPermissionsViewControllerIdentifier owner:self options:nil] firstObject];
    self.permissionsViewController.permissions = self.permissions;
    self.permissionsViewController.titleText = self.title;
    __weak VWWPermissionsManager *welf = self;
    [self.permissionsViewController setCompletionBlock:^{
        if(welf.resultsBlock){
            welf.resultsBlock(welf.permissions);
        }
    }];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:self.permissionsViewController];
    [viewController presentViewController:nc animated:YES completion:NULL];
}


-(void)displayPermissions:(NSArray*)permissions
                 required:(BOOL)required
                    title:(NSString*)title
       fromViewController:(UIViewController*)viewController
             resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock{
    
    _permissions = [permissions copy];
    _required = required;
    _title = title;
    _resultsBlock = resultsBlock;
    
    
    [self readPermissions];
    if([self checkAllPermissionsSatisfied] == YES){
        // Return if all permissions are all authorized
        return resultsBlock(self.permissions);
    } else {
        [self showPermissionsViewControllerFromViewController:viewController];
        [self checkAllPermissionsSatisfied];
    }
}

-(void)readPermissions:(NSArray*)permissions resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock{
    _permissions = permissions;
    [self readPermissions];
    resultsBlock(_permissions);
}

@end

