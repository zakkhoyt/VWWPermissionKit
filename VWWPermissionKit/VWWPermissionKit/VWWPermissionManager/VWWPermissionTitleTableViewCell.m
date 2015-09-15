//
//  VWWPermissionTitleTableViewCell.m
//  VWWPermissionKit
//
//  Created by Zakk Hoyt on 7/3/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWPermissionTitleTableViewCell.h"

@interface VWWPermissionTitleTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@end

@implementation VWWPermissionTitleTableViewCell

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIContentSizeCategoryDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.titleTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    }];
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"permission.status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setTitleText:(NSString *)titleText{
    self.titleTextLabel.text = titleText;
}

@end
