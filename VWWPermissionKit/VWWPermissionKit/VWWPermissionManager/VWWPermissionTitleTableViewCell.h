//
//  VWWPermissionTitleTableViewCell.h
//  VWWPermissionKit
//
//  Created by Zakk Hoyt on 7/3/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VWWPermissionAppearance;

static NSString *VWWPermissionTitleTableViewCellIdentifier = @"VWWPermissionTitleTableViewCellIdentifier";

@interface VWWPermissionTitleTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) VWWPermissionAppearance *appearance;
@end
