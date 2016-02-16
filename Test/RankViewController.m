//
//  RankViewController.m
//  Test
//
//  Created by vincent on 2/16/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "RankViewController.h"
#import "RankTableViewController.h"

@interface RankViewController ()
@property (weak, nonatomic) IBOutlet UIView *childView;
@property (nonatomic, retain) IBOutlet UITabBar *mainTabBar;
@property (nonatomic, retain) UIViewController *tab1vc;
@property (nonatomic, retain) UIViewController *tab2vc;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mainTabBar setSelectedItem:[[self.mainTabBar items] objectAtIndex:0]];
    if (self.tab2vc == nil) {
        self.tab2vc = [[RankTableViewController alloc] init];
    }
    [self addChildViewController:self.tab2vc];
    self.tab2vc.view.bounds = self.childView.bounds;
    [self.childView addSubview:self.tab2vc.view];
    [self.tab2vc didMoveToParentViewController:self];
    if (self.tab1vc == nil) {
        self.tab1vc =[[RankTableViewController alloc] init];
    }
    [self addChildViewController:self.tab1vc];
    self.tab1vc.view.bounds = self.childView.bounds;
    [self.childView addSubview:self.tab1vc.view];
    [self.tab1vc didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (item.tag) {
        case 1:
            if (self.tab1vc == nil) {
                self.tab1vc =[[RankTableViewController alloc] init];
            }
            [self addChildViewController:self.tab1vc];
            self.tab1vc.view.bounds = self.childView.bounds;
            [self.childView addSubview:self.tab1vc.view];
            [self.tab1vc didMoveToParentViewController:self];
            break;
        case 2:
            if (self.tab2vc == nil) {
                self.tab2vc = [[RankTableViewController alloc] init];
            }
            [self addChildViewController:self.tab2vc];
            self.tab2vc.view.bounds = self.childView.bounds;
            [self.childView addSubview:self.tab2vc.view];
            [self.tab2vc didMoveToParentViewController:self];
            break;
        default:
            break;
    }
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
