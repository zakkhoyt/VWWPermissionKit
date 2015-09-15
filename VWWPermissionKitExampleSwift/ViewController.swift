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
        showPermissions()
    }
    
    func showPermissions() {
        let photos = VWWPhotosPermission.permissionWithLabelText("In order to write to your Camera Roll")
        let camera = VWWCameraPermission.permissionWithLabelText("In order to access your camera to record video.")
        let coreLocationAlways = VWWCoreLocationAlwaysPermission.permissionWithLabelText("To calculate your heading, altitude, speed, distance home, etc...")
        let permissions = [photos, camera, coreLocationAlways]
        
        // Using requirePermissions:permissions, the user cannot proceed until all permissions are authorized
        VWWPermissionsManager.requirePermissions(permissions, title: "We need your approvoal before we get running", fromViewController: self) { (permissions: [AnyObject]!) -> Void in
            print("permission")
        }        
    }
}

