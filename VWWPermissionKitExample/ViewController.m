//
//  ViewController.m
//  VWWPermissionKitExample
//
//  Created by Zakk Hoyt on 6/13/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ViewController.h"
#import <VWWPermissionKit/VWWPermissionKit.h>

@implementation ViewController

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSArray *permissions =
    @[
      [VWWCameraPermission permissionWithLabelText:@"In order to access your camera to record video."],
      [VWWMicrophonePermission permissionWithLabelText:@"In order to access your microphone to add audio to videos"],
      [VWWCoreLocationAlwaysPermission permissionWithLabelText:@"To calculate your heading, altitude, speed, distance home, etc..."],
      [VWWPhotosPermission permissionWithLabelText:@"To save your videos to your Photos library."],
      ];
    
    [VWWPermissionsManager requirePermissions:permissions
                                        title:@"We need your approvoal before we get running"
                           fromViewController:self
                                 resultsBlock:^(NSArray *permissions) {
                                     [permissions enumerateObjectsUsingBlock:^(VWWPermission *permission, NSUInteger idx, BOOL *stop) {
                                         NSLog(@"%@ - %@", permission.type, [permission stringForStatus]);
                                     }];
                                 }];
    
}

////************ Swift example
//override func viewDidAppear(animated: Bool) {
//    super.viewDidAppear(animated)
//    let photos = VWWPhotosPermission.permissionWithLabelText("In order to write to your Camera Roll")
//    let camera = VWWCameraPermission.permissionWithLabelText("In order to access your camera to record video.")
//    let microphone = VWWMicrophonePermission.permissionWithLabelText("In order to access your microphone to add audio to videos")
//    let coreLocationAlways = VWWCoreLocationAlwaysPermission.permissionWithLabelText("To calculate your heading, altitude, speed, distance home, etc...")
//    let permissions = [photos, camera, microphone, coreLocationAlways]
//    VWWPermissionsManager.requirePermissions(permissions, title: "Swift Test", fromViewController: self) { (permissions: [AnyObject]!) -> Void in
//        println("permission")
//    }
//}


- (IBAction)permissionButtonTouchUpInside:(id)sender {

}

@end
