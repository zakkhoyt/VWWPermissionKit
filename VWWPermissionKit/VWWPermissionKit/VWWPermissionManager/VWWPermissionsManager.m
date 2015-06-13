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
@property (nonatomic, strong) NSMutableArray *permissions;
@property (nonatomic, strong) VWWPermissionsManagerResultsBlock resultsBlock;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) VWWPermissionsViewController *permissionsViewController;
@end

@implementation VWWPermissionsManager

#pragma mark Public methods

+(void)enforcePermissions:(NSArray*)permissions                                      // An array of VWWPermissions objects
                    title:(NSString*)title                                           // Decriptive text for the header label
       fromViewController:(UIViewController*)viewController                   // The view controller to present from
             resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock{
    VWWPermissionsManager *permissionsManager = [[self alloc]init];
    [permissionsManager ensurePermissions:permissions title:title fromViewController:viewController resultsBlock:resultsBlock];
}

#pragma mark Private methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:VWWPermissionNotificationsPromptAction object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            dispatch_async(dispatch_get_main_queue(), ^{
                VWWPermission *permission = note.userInfo[VWWPermissionNotificationsPermissionKey];
                [permission presentSystemPromtWithCompletionBlock:^{
                    permission.status = VWWPermissionStatusUninitialized;
                    [permission updatePermissionStatus];
                    [self checkAllPermissionsSatisfied];
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
    for(VWWPermission *permission in self.permissions) {
        if(permission.status != VWWPermissionStatusAuthorized){
            [self.permissionsViewController setCloseButtonTitle:nil];
            return NO;
        }
    }
    [self.permissionsViewController setCloseButtonTitle:@"Done"];
    return YES;
}

-(void)readPermissions{
    [self.permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
        [permission updatePermissionStatus];
    }];
}

-(void)showPermissionsViewControllerFromViewController:(UIViewController*)viewController{
//    NSString *i = [[NSBundle mainBundle] bundleIdentifier];
//    NSArray *bundles = [NSBundle allBundles];
//    [bundles enumerateObjectsUsingBlock:^(NSBundle *bundle, NSUInteger idx, BOOL *stop) {
//        NSLog(@"%@", bundle.description);
//    }];

    NSBundle* resourcesBundle = [NSBundle bundleForClass:[VWWPermissionsManager class]];
//    NSString *frameworkBundleID = @"VWWPermissionKitBundle.bundle";
//    NSBundle *frameworkBundle = [NSBundle bundleWithIdentifier:frameworkBundleID];
    self.permissionsViewController = [[resourcesBundle loadNibNamed:VWWPermissionsViewControllerIdentifier owner:self options:nil] firstObject];
    self.permissionsViewController.permissions = self.permissions;
    self.permissionsViewController.headerText = self.title;
    __weak VWWPermissionsManager *welf = self;
    [self.permissionsViewController setCompletionBlock:^{
        if(welf.resultsBlock){
            welf.resultsBlock(welf.permissions);
        }
    }];
    [viewController presentViewController:self.permissionsViewController animated:YES completion:NULL];
    
}

-(void)ensurePermissions:(NSArray*)permissions
                   title:(NSString*)title
             fromViewController:(UIViewController*)viewController
                   resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock{

    _permissions = [permissions copy];
    _title = title;
    _resultsBlock = resultsBlock;
    
    
    [self readPermissions];
    [self showPermissionsViewControllerFromViewController:viewController];
}

@end

