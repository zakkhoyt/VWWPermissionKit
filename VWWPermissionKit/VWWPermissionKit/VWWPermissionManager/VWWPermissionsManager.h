//
//  VWWPermissionsManager.h
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//

#import <UIKit/UIKit.h>


#import "VWWCameraPermission.h"
#import "VWWCalendarsPermission.h"
#import "VWWContactsPermission.h"
#import "VWWCoreLocationAlwaysPermission.h"
#import "VWWCoreLocationWhenInUsePermission.h"
#import "VWWCoreMotionPermission.h"
#import "VWWNotificationsPermission.h"
#import "VWWMicrophonePermission.h"
#import "VWWRemindersPermission.h"
#import "VWWPhotosPermission.h"

// *** Deprecated:
//#import "VWWAssetLibraryPermission.h"

// *** Implementation not complete
//#import "VWWAccountsPermission.h"
//#import "VWWCoreBluetoothPermission.h"
//#import "VWWHealthPermission.h"
//#import "VWWHomePermission.h"


typedef void (^VWWPermissionsManagerResultsBlock)(NSArray *permissions);

@interface VWWPermissionsManager : NSObject

/*!
 @method     requirePermissions:title:fromViewController:resultsBlock:
 @abstract
 @discussion Display the permission sheet. User cannot exit the form until all permission requirements have been satisfied
 @param      permissions         An array of VWW(xxx)Permission instances. VWWPhotosPermission for example.
 @param      title               The title to display at the top of the presentation window.
 @param      fromViewController  The presenting view controller
 @param      resultsBlock        This block returns an array of VWW(xxx)Permission objects for inspection and is fired when the user taps close or all permissions are satisfied
 */
+(void)requirePermissions:(NSArray*)permissions
                    title:(NSString*)title
       fromViewController:(UIViewController*)viewController
             resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock;

/*!
 @method     optionPermissions:title:fromViewController:resultsBlock:
 @abstract
 @discussion Display the permission sheet but let the user close it without satisfying their respective required properties
 @param      permissions         An array of VWW(xxx)Permission instances. VWWPhotosPermission for example.
 @param      title               The title to display at the top of the presentation window.
 @param      fromViewController  The presenting view controller
 @param      resultsBlock        This block returns an array of VWW(xxx)Permission objects for inspection and is fired when the user taps close or all permissions are satisfied
 */
+(void)optionPermissions:(NSArray*)permissions
                   title:(NSString*)title
      fromViewController:(UIViewController*)viewController
            resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock;



/*!
 @method     readPermissions:resultsBlock:
 @abstract
 @discussion Read the permission status of each permission type
 @param      permissions         An array of VWW(xxx)Permission instances. VWWPhotosPermission for example.
 @param      resultsBlock        This block returns an array of VWW(xxx)Permission objects for inspection and is fired after all permission values have been read.
*/
+(void)readPermissions:(NSArray*)permissions resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock;

@end
