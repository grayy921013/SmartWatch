//
//  FightViewController.m
//  Test
//
//  Created by vincent on 2/15/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "FightViewController.h"
#import "GameViewController.h"
#import "Character.h"
#import "CharacterMO.h"

@interface FightViewController ()

@end

@implementation FightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Fight"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gotoSingleGame:(id)sender {
    GameViewController *game = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil against:[CharacterMO getRecordByID:101]];
    [self.navigationController pushViewController:game animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
