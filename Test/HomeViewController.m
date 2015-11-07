//
//  HomeViewController.m
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (assign, nonatomic) int level_now;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Home";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateUI:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI:)
                                                 name:@"heartrate"
                                               object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)updateUI:(NSNotification*) notification {
    dispatch_async (dispatch_get_main_queue(), ^{
        NSInteger point = [[NSUserDefaults standardUserDefaults] integerForKey:POINT_KEY];
        [self.pointLabel setText:[@(point) stringValue]];
        int level = (int)log10(point+1);
        if (self.level_now != level) {
            [self.levelLabel setText:[@(level) stringValue]];
            NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"gif%d",level]withExtension:@"gif"];
            if (url != nil) {
                self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
            }
        }
        self.level_now = level;
    });
}
- (IBAction)resetClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:POINT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateUI:nil];
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
