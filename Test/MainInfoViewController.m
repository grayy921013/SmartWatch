//
//  MainInfoViewController.m
//  Test
//
//  Created by vincent on 3/26/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "MainInfoViewController.h"
#import "InfoViewController.h"
#import "DataTableViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MainInfoViewController ()

@end

@implementation MainInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Info";
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)oepnSetting:(id)sender {
    InfoViewController *info = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
- (IBAction)openActivity:(id)sender {
    DataTableViewController *data = [[DataTableViewController alloc] initWithType:HEARTRATE];
    data.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:data animated:YES];
}

@end
