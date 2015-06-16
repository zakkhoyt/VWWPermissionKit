## VWWPermissionKit

We've all been there. You get started on your latest and greatest app when you have to add logic to prompt the user for permissions before you can perform any actions. These permissions use many different classes and frameworks, and they don't share the same data type regarding status. 

VWWPermissionKit solves these problems. VWWPermissionKit allows you to inform your user exactly what they will be prompted for before presentation. Buttons trigger the prompts one at a time. All from one central screen. 

First, import VWWPermissionKit to your file if using Obj-C or your Bridging Header if using Swift.

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
![](http://i.imgur.com/8viPrQS.png)
![](http://i.imgur.com/rcF8DOb.png)
![](http://i.imgur.com/kv52xTy.png)
![](http://i.imgur.com/mwPoOYv.png)


## Adding the cocoa framework to your iOS project ##
To add VWWPermissionKit to your application, drag the VWWPermissionKit.xcodeproj project file into your application's project. XCode will add the VWWPermissionKit project and source files.

Next tell XCode to embed VWWPermissionKit into your app. Go to your app's target build settings and choose the "General" tab. Under the "Embedded Binaries" grouping, add VWWPermissionKit. XCode should automatically add link references for you.

Next MAY need to tell it where to find the headers. Go to the Build Settings tab. Type "header " in the search bar. The go to the section "Search Paths" and add an entry to "Header Search Paths"

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

