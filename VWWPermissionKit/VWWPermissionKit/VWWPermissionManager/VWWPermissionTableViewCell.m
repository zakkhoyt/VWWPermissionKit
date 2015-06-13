//
//  VWWPermissionTableViewCell.m
//  
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import "VWWPermissionTableViewCell.h"
#import "VWWPermission.h"
#import "VWWPermissionNotifications.h"

@interface VWWPermissionTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *permissionLabel;
@property (weak, nonatomic) IBOutlet UIButton *permissionButton;
@end

@implementation VWWPermissionTableViewCell

-(void)setPermission:(VWWPermission *)permission{
    _permission = permission;
    self.permissionLabel.text = permission.labelText;
    
    [self addObserver:self forKeyPath:@"permission.status" options:NSKeyValueObservingOptionNew context:nil];
    [self skinButton];
}

#pragma mark Private methods
- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.permissionButton.layer.borderColor = self.tintColor.CGColor;
    self.permissionButton.layer.borderWidth = 1.0;
    self.permissionButton.layer.cornerRadius = 4.0;
    self.permissionButton.layer.masksToBounds = YES;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"permission.status"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self skinButton];
    });
}

-(void)skinButton{
    switch (self.permission.status) {
        case VWWPermissionStatusAuthorized:{
//            [self.permissionButton setBackgroundColor:self.tintColor];
            [self.permissionButton setBackgroundColor:[UIColor greenColor]];
            [self.permissionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            NSString *buttonTitle = [[NSString stringWithFormat:@"%@ allowed", self.permission.type] uppercaseString];
            [self.permissionButton setTitle:buttonTitle forState:UIControlStateNormal];
        }
            break;
        case VWWPermissionStatusDenied:{
            [self.permissionButton setBackgroundColor:[UIColor redColor]];
            [self.permissionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            NSString *buttonTitle = [[NSString stringWithFormat:@"%@ denied", self.permission.type] uppercaseString];
            [self.permissionButton setTitle:buttonTitle forState:UIControlStateNormal];
        }
            break;
        case VWWPermissionStatusRestricted:{
            [self.permissionButton setBackgroundColor:[UIColor redColor]];
            [self.permissionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            NSString *buttonTitle = [[NSString stringWithFormat:@"%@ restricted", self.permission.type] uppercaseString];
            [self.permissionButton setTitle:buttonTitle forState:UIControlStateNormal];
        }
            break;
        case VWWPermissionStatusUninitialized:{
            [self.permissionButton setBackgroundColor:[UIColor orangeColor]];
            [self.permissionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            NSString *buttonTitle = [[NSString stringWithFormat:@"%@ ???", self.permission.type] uppercaseString];
            [self.permissionButton setTitle:buttonTitle forState:UIControlStateNormal];
        }
            break;
        case VWWPermissionStatusNotDetermined:{
            [self.permissionButton setBackgroundColor:[UIColor whiteColor]];
            [self.permissionButton setTitleColor:self.tintColor forState:UIControlStateNormal];
            NSString *buttonTitle = [[NSString stringWithFormat:@"allow %@", self.permission.type] uppercaseString];
            [self.permissionButton setTitle:buttonTitle forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (IBAction)promptButtonTouchUpInside:(id)sender {
    if(self.permission.status == VWWPermissionStatusDenied ||
       self.permission.status == VWWPermissionStatusRestricted){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else if(self.permission.status == VWWPermissionStatusNotDetermined ||
              self.permission.status == VWWPermissionStatusUninitialized){
        NSDictionary *userInfo = @{VWWPermissionNotificationsPermissionKey : self.permission};
        [[NSNotificationCenter defaultCenter] postNotificationName:VWWPermissionNotificationsPromptAction object:nil userInfo:userInfo];
    }
    
}

@end
