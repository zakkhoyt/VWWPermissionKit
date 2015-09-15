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
        setupAppearance()
        showPermissions()
    }
    
    func setupAppearance() {
        UILabel.appearance().textColor = UIColor.cyanColor()
        UILabel.appearance().font = UIFont(name: "Marker Felt", size: 14)
        UIButton.appearance().tintColor = UIColor.magentaColor()
        UIButton.appearance().setTitleColor(UIColor.orangeColor(), forState: .Normal)
        UIButton.appearance().titleLabel!.font = UIFont(name: "Marker Felt", size: 20)
    }
    
    func showPermissions() {
        let photos = VWWPhotosPermission.permissionWithLabelText("In order to write to your Camera Roll")
        let camera = VWWCameraPermission.permissionWithLabelText("In order to access your camera to record video.")
        let coreLocationAlways = VWWCoreLocationAlwaysPermission.permissionWithLabelText("To calculate your heading, altitude, speed, distance home, etc...")
        
        let shareTypes = [HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodAlcoholContent),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierRespiratoryRate),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)] as [AnyObject]
        let readTypes = shareTypes
        let health: VWWHealthPermission = VWWHealthPermission.permissionWithLabelText("")
//        let health: VWWHealthPermission = VWWHealthPermission.permissionWithLabelText("test", shareTypes: shareTypes, readTypes: readTypes)
        
        let permissions = [photos, camera, coreLocationAlways, health]
        
        // Using requirePermissions:permissions, the user cannot proceed until all permissions are authorized
        VWWPermissionsManager.requirePermissions(permissions, title: "We need your approvoal before we get running", fromViewController: self) { (permissions: [AnyObject]!) -> Void in
            print("permission")
        }
        
    }
}

