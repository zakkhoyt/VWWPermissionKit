//
//  VWWPermissionsViewController.m
//
//
//  Created by Zakk Hoyt on 6/11/15.
//
//

#import "VWWPermissionsViewController.h"
#import "VWWPermissionTableViewCell.h"
#import "VWWPermissionTitleTableViewCell.h"
#import "VWWPermission.h"

typedef enum {
    VWWPermissionsViewControllerSectionTitle = 0,
    VWWPermissionsViewControllerSectionPermissions = 1,
} VWWPermissionsViewControllerSection;

@interface VWWPermissionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *privacyButton;
@property (nonatomic, strong) VWWPermissionsViewControllerEmptyBlock completionBlock;
@end

@interface VWWPermissionsViewController (UITableView) <UITableViewDataSource, UITableViewDelegate>
@end


@implementation VWWPermissionsViewController

#pragma mark Private methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 76.0;
    NSBundle* bundle = [NSBundle bundleForClass:[VWWPermissionTableViewCell class]];
    [self.tableView registerNib:[UINib nibWithNibName:@"VWWPermissionTableViewCell" bundle:bundle] forCellReuseIdentifier:VWWPermissionTableViewCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"VWWPermissionTitleTableViewCell" bundle:bundle] forCellReuseIdentifier:VWWPermissionTitleTableViewCellIdentifier];
    [self willTransitionToTraitCollection:self.traitCollection withTransitionCoordinator:self.transitionCoordinator];
}


-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [UIApplication sharedApplication].statusBarHidden = newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? YES : NO;
}

-(void)refresh{
    [self.tableView reloadData];
}

#pragma mark IBActions
- (IBAction)privacyBarButtonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (IBAction)doneBarButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    if(_completionBlock){
        _completionBlock();
    }
}

#pragma mark Public methods

-(void)setCloseButtonTitle:(NSString*)title{
    if(title == nil){
        [self.navigationItem setRightBarButtonItem:nil];
    } else {
        [self.navigationItem setRightBarButtonItem:self.doneButton];
    }
}

-(void)setCompletionBlock:(VWWPermissionsViewControllerEmptyBlock)completionBlock{
    _completionBlock = completionBlock;
}

-(void)displayDeniedAlertForPermission:(VWWPermission*)permission{
    NSString *message = [NSString stringWithFormat:@"It looks like you denied access to %@. We will take you to iOS Settings.", permission.type];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Uh oh!" message:message preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    
    [self presentViewController:ac animated:YES completion:NULL];
    
}

@end

@implementation VWWPermissionsViewController (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // First section is one cell, the titleText
    // Second section is the permissions
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case VWWPermissionsViewControllerSectionTitle:
            return self.titleText == nil ? 0 : 1;
            break;
        case VWWPermissionsViewControllerSectionPermissions:
        default:
            return self.permissions.count; // + the title cell
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case VWWPermissionsViewControllerSectionTitle:{
            VWWPermissionTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VWWPermissionTitleTableViewCellIdentifier];
            cell.titleText = self.titleText;
            return cell;
        }
            break;
        case VWWPermissionsViewControllerSectionPermissions:
        default:{
            VWWPermissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VWWPermissionTableViewCellIdentifier];
            if(cell == nil){
                cell = [[VWWPermissionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VWWPermissionTableViewCellIdentifier];
            }
            cell.permission = self.permissions[indexPath.row];
            return cell;
            
        }
            break;
    }
}

@end
