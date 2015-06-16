//
//  ViewController.swift
//  VWWPermissionKitExampleSwift
//
//  Created by Zakk Hoyt on 6/15/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let photos = VWWPhotosPermission.permissionWithLabelText("In order to write to your Camera Roll")
        let camera = VWWCameraPermission.permissionWithLabelText("In order to access your camera to record video.")
        let microphone = VWWMicrophonePermission.permissionWithLabelText("In order to access your microphone to add audio to videos")
        let coreLocationAlways = VWWCoreLocationAlwaysPermission.permissionWithLabelText("To calculate your heading, altitude, speed, distance home, etc...")
        let permissions = [photos, camera, microphone, coreLocationAlways]
        VWWPermissionsManager.requirePermissions(permissions, title: "Swift Test Required", fromViewController: self) { (permissions: [AnyObject]!) -> Void in
            println("permission")
        }

        VWWPermissionsManager.optionPermissions(permissions, title: "Swift Test Required", fromViewController: self) { (permissions: [AnyObject]!) -> Void in
            println("permission")
        }

    }
}

