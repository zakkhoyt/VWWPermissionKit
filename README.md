## VWWPermissionKit

We've all been there. You get started on your latest and greatest app when you have to add logic to prompt the user for permissions before your app can access any of these resources. Many users will deny access unless you convince them that your app can be trusted. If they deny access, you must then try to convince them to go to iOS Privacy Settings, find your app, enable those permissions, switch back to your app, read permissions again, etc...

Another difficulty: The permissions from Apple's frameworks use many different classes, and they don't share the same data type regarding status. PhotoKit uses PHAuthorizationStatus, EventKit uses EKAuthorizationStatus, Core Location uses CLAuthorizationStatus, and so on.

VWWPermissionKit solves these problems by presenting your user with an easy to read list of permissions that they need to approve before iOS prompts them. This makes it simple for a user to understand why they should approve permissions. Each button triggers an iOS prompt one at a time all from one central view. VWWPermissionKit will also automatically detect changes if the user changes a setting in your app's privacy settings.

## How to use VWWPermissionKit

Although written in Obj-C, it is easy to use VWWPermissionKit from both Obj-C and Swift. An example project is included for each language. 

To get started, first import VWWPermissionKit to your file if using Obj-C or your Bridging Header if using Swift.

```
#import "VWWPermissionKit.h"
```

Next create an array of VWWPermission types

###ObjC
```
@[
  [VWWCameraPermission permissionWithLabelText:@"We need to access your camera to record video."],
  [VWWMicrophonePermission permissionWithLabelText:@"We need to access your microphone to add audio to videos"],
  [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"For rendering your heading, altitude, speed, distance home, etc..."],
  [VWWPhotosPermission permissionWithLabelText:@"To save your videos to your Photos library."],
];

```

###Swift
```
let photos = VWWPhotosPermission.permissionWithLabelText("In order to write to your Camera Roll")
let camera = VWWCameraPermission.permissionWithLabelText("In order to access your camera to record video.")
let microphone = VWWMicrophonePermission.permissionWithLabelText("In order to access your microphone to add audio to videos")
let coreLocationAlways = VWWCoreLocationAlwaysPermission.permissionWithLabelText("To calculate your heading, altitude, speed, distance home, etc...")
let permissions = [photos, camera, microphone, coreLocationAlways]
```


Finally display the permissions window. Once that all the permissions are authorized the form is dimissed and the resultsBlock is called. You can inspect each permission here. 

###ObjC
```
[VWWPermissionsManager requirePermissions:permissions
                                    title:@"We'll need some things from you before we get started."
                       fromViewController:self
                             resultsBlock:^(NSArray *permissions) {
                                 [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                     NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                 }];
                             }];
```

###Swift
```
VWWPermissionsManager.requirePermissions(permissions, title: "Swift Test", fromViewController: self) { (permissions: [AnyObject]!) -> Void in
        println("permission")
}

```



Alternatively, there is a permissions readonly function which shows no GUI. It simply reads each permission type and returns with the benefit that all permissions share the same datatype. 

```
[VWWPermissionsManager readPermissions:permissions resultsBlock:^(NSArray *permissions) {
    [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
    }];
}];
```

Tapping on the "Privacy" button will navigate the user to your iOS app's privacy settings where they can change permissions. The user is also navigated here if they tap a red button. Once the user switches back to your app, the permissions are re-read and the screen is updated.

## Sample images ##
![](http://i.imgur.com/ZT9rl3b.png)
![](http://i.imgur.com/n8FSXnn.png)
![](http://i.imgur.com/ir28YCI.png)
![](http://i.imgur.com/WKugIoX.png)
![](http://i.imgur.com/tz6k6eL.png)
![](http://i.imgur.com/2UjjAgu.png)
![](http://i.imgur.com/T3G6Rkb.png)


## Adding the cocoa framework to your iOS project ##
To add VWWPermissionKit to your application, drag the VWWPermissionKit.xcodeproj project file into your application's project. XCode will add the VWWPermissionKit project and source files.

Next tell XCode to embed VWWPermissionKit into your app. Go to your app's target build settings and choose the "General" tab. Under the "Embedded Binaries" grouping, add VWWPermissionKit. XCode should automatically add link references for you.

Finally you'll need to tell XCode where to find the proper headers. Go to the Build Settings tab. Type "header " in the search bar. The go to the section "Search Paths" and add an the VWWPermissionKit file path to "Header Search Paths" (recursive: YES)

## Functional Permission classes ##
- **VWWAssetLibraryPermission**: AssetsLibrary
- **VWWCameraPermission**: AVFoundation and UIImagePickerController
- **VWWCalendarsPermission**: EventKit framework
- **VWWCoreLocationAlwaysPermission**: CoreLocation framework
- **VWWCoreLocationWhenInUsePermission**: CoreLocatoin framework
- **VWWMicrophonePermission**: AVFoundation framework
- **VWWNotificationsPermission**: UIApplication (remote, user, and local)
- **VWWRemindersPermission**: EventKit framework
- **VWWPhotosPermission**: Photos framework

## In-Development Permission classes ##
- **VWWAccountsPermission**: Accounts framework
- **VWWBluetoothPermission**: CoreBluetooth framework
- **VWWCoreMotionPermission**: CoreMotion framework
- **VWWHealthPermission**: HealthKit framework
- **VWWHomePermission**: HomeKit framework

