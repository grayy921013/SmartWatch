//
//  HomeViewController.m
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "HomeViewController.h"
#import "WatchSessionManager.h"
#import "FightViewController.h"
#import "CharacterMO.h"
@interface HomeViewController ()

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
        TrainingTime* time = [[WatchSessionManager sharedInstance]getTrainingTimeToday];
        NSInteger duration = [time.totalTime integerValue];
        if (duration < 60*60) {
            [self.timeLabel setText:[NSString stringWithFormat:@"%ld min", duration/60]];
        } else {
            double hour = (double)duration/3600;
            [self.timeLabel setText:[NSString stringWithFormat:@"%.2f hour", hour]];
        }
        CharacterMO* character = [CharacterMO getRecordByID:0];
        NSInteger expNeeded = [character.experiencePerLevel integerValue] * [character.level integerValue];
        [self.infoLabel setText:[NSString stringWithFormat:@"Exp need:%ld\nLevel now:%ld",expNeeded,[character.level integerValue]]];
        if (point >= expNeeded) [self.levelUpBtn setEnabled:YES];
        else [self.levelUpBtn setEnabled:NO];
    });
}
- (void)setPoint:(NSInteger)point {
    [[NSUserDefaults standardUserDefaults] setInteger:point forKey:POINT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateUI:nil];
}
- (IBAction)levelUp:(id)sender {
    CharacterMO* character = [CharacterMO getRecordByID:0];
    NSInteger expNeeded = [character.experiencePerLevel integerValue] * [character.level integerValue];
    NSInteger point = [[NSUserDefaults standardUserDefaults] integerForKey:POINT_KEY];
    if (point >= expNeeded) {
        point -= expNeeded;
        [self setPoint:point];
        [character levelUp];
    }
}
- (IBAction)shouldGenData:(id)sender {
    [[WatchSessionManager sharedInstance] shouldGenData:[sender isOn]];
}
- (IBAction)gotoFight:(id)sender {
    FightViewController *fight = [[FightViewController alloc] initWithNibName:@"FightViewController" bundle:nil];
    fight.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fight animated:YES];
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
