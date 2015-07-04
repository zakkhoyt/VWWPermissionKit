//
//  VWWPermissionTitleTableViewCell.m
//  VWWPermissionKit
//
//  Created by Zakk Hoyt on 7/3/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWPermissionTitleTableViewCell.h"
#import "VWWPermissionAppearance.h"

@interface VWWPermissionTitleTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@end

@implementation VWWPermissionTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setTitleText:(NSString *)titleText{
    self.titleTextLabel.text = titleText;
}
-(void)setAppearance:(VWWPermissionAppearance *)appearance{
    _appearance = appearance;
    self.backgroundColor = self.appearance.backgroundColor;
}

@end
