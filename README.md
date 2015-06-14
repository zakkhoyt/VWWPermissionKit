We've all been there. You get started on your latest and greatest app when you have to add logic to prompt the user for permissions before you can perform any actions. These permissions use many different classes and frameworks, and they don't share the same data type regarding status. 

VWWPermissionKit solves these problems. VWWPermissionKit allows you to inform your user exactly what they will be prompted for before presentation. Buttons trigger the prompts one at a time. All from one central screen. 

First create an array of VWWPermission types

```
@[
  [VWWCameraPermission permissionWithLabelText:@"We need to access your camera to record video."],
  [VWWMicrophonePermission permissionWithLabelText:@"We need to access your microphone to add audio to videos"],
  [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"For rendering your heading, altitude, speed, distance home, etc..."],
  [VWWPhotosPermission permissionWithLabelText:@"To save your videos to your Photos library."],
];

```

Next display the permissions window like so:
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
Once that all the permissions are authorized the form is dimissed and the resultsBlock is called. You can inspect each permission here. 


There is a read permissions function which shows no GUI. It simply reads each permission type and returns. 
```
[VWWPermissionsManager readPermissions:permissions resultsBlock:^(NSArray *permissions) {
    [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
    }];
}];
```


![](http://i.imgur.com/8viPrQS.png)
![](http://i.imgur.com/rcF8DOb.png)
![](http://i.imgur.com/kv52xTy.png)
![](http://i.imgur.com/mwPoOYv.png)




 




