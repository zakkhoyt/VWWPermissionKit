//
//  VWWPermissionsManager.h
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//
//
//  Specify a string for these keys to your info.plist. This string will be presented with they system prompt
//  Context click on your info.plist then select "Open As" -> "Source Code". You can then paste these in place
//        <key>NSBluetoothPeripheralUsageDescription</key>
//        <string>My custom bluetooth prompt</string>
//        <key>NSHealthShareUsageDescription</key>
//        <string>My custom health share prompt</string>
//        <key>NSHealthUpdateUsageDescription</key>
//        <string>My custom health usage promt</string>
//        <key>NSMotionUsageDescription</key>
//        <string>My custom motion prompt</string>
//        <key>NSCameraUsageDescription</key>
//        <string>My custom camera prompt</string>
//        <key>NSContactsUsageDescription</key>
//        <string>My custom contacts prompt</string>
//        <key>NSCalendarsUsageDescription</key>
//        <string>My custom calendars prompt</string>
//        <key>NSLocationAlwaysUsageDescription</key>
//        <string>My custom location always prompt</string>
//        <key>NSLocationWhenInUseUsageDescription</key>
//        <string>My custom location when in use prompt</string>
//        <key>NSMicrophoneUsageDescription</key>
//        <string>My custom microphone prompt</string>
//        <key>NSPhotoLibraryUsageDescription</key>
//        <string>My custom photos prompt</string>
//        <key>NSRemindersUsageDescription</key>
//        <string>My custom reminders prompt</string>


#import <UIKit/UIKit.h>

#import "VWWAccountsPermission.h"
#import "VWWAssetLibraryPermission.h"
#import "VWWBluetoothPermission.h"
#import "VWWHealthPermission.h"
#import "VWWHomePermission.h"
#import "VWWCoreMotionPermission.h"
#import "VWWCameraPermission.h"
#import "VWWCalendarsPermission.h"
#import "VWWContactsPermission.h"
#import "VWWCoreLocationAlwaysPermission.h"
#import "VWWCoreLocationWhenInUsePermission.h"
#import "VWWNotificationsPermission.h"
#import "VWWMicrophonePermission.h"
#import "VWWRemindersPermission.h"
#import "VWWPhotosPermission.h"

typedef void (^VWWPermissionsManagerResultsBlock)(NSArray *permissions);

@interface VWWPermissionsManager : NSObject

/*!
    @method     requirePermissions:title:fromViewController:resultsBlock:
    @abstract
    @discussion Display the permission sheet. User cannot exit the form until all permission requirements have been satisfied
 
    @param      permissions         An array of VWW(xxx)Permission instances. VWWPhotosPermission for example.
    @param      title               The title to display at the top of the presentation window.
    @param      fromViewController  The presenting view controller
    @param      resultsBlock        This block returns an array of VWW(xxx)Permission objects for inspection. 
                                    This block is fired when the user taps close or all permissions are satisfied
 */
+(void)requirePermissions:(NSArray*)permissions
                    title:(NSString*)title
       fromViewController:(UIViewController*)viewController
             resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock;

/*!
 @method     requirePermissions:title:fromViewController:resultsBlock:
 @abstract
 @discussion Display the permission sheet but let the user close it without satisfying their respective required properties
 
 @param      permissions         An array of VWW(xxx)Permission instances. VWWPhotosPermission for example.
 @param      title               The title to display at the top of the presentation window.
 @param      fromViewController  The presenting view controller
 @param      resultsBlock        This block returns an array of VWW(xxx)Permission objects for inspection.
 This block is fired when the user taps close or all permissions are satisfied
 
*/

+(void)optionPermissions:(NSArray*)permissions
                    title:(NSString*)title
       fromViewController:(UIViewController*)viewController
             resultsBlock:(VWWPermissionsManagerResultsBlock)resultsBlock;



@end
