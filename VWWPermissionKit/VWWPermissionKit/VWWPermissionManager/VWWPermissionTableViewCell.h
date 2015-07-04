//
//  VWWPermissionTableViewCell.h
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import <UIKit/UIKit.h>
@class VWWPermission;
@class VWWPermissionAppearance;

static NSString *VWWPermissionTableViewCellIdentifier = @"VWWPermissionTableViewCell";

@interface VWWPermissionTableViewCell : UITableViewCell
@property (nonatomic, strong) VWWPermission *permission;
@property (nonatomic, strong) VWWPermissionAppearance *appearance;
@end
