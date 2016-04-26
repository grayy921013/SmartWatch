//
//  MainInfoViewController.m
//  Test
//
//  Created by vincent on 3/26/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "MainInfoViewController.h"
#import "InfoViewController.h"
#import "Constants.h"
#import "DataTableViewController.h"

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
    loginButton.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    if(!error && !result.isCancelled) {
        NSLog(@"Logged in");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:result.token.userID forKey:USER_ID_KEY];
    }
}
/*!
 @abstract Sent to the delegate when the button was used to logout.
 @param loginButton The button that was clicked.
 */
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID_KEY];
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
