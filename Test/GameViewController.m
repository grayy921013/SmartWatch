//
//  GameViewController.m
//  Test
//
//  Created by vincent on 2/15/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (retain, nonatomic) Character* char1;
@property (retain, nonatomic) Character* char2;
@end

@implementation GameViewController

-(id)initWithNibName:(NSString*) String bundle:(NSBundle*)bundle Character1:(Character*)char1 Character2:(Character*)char2{
    self = [super initWithNibName:String bundle:bundle];
    if (self) {
        self.char1 = char1;
        self.char2 = char2;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self gameStart];
}
- (NSInteger)attackByChar:(Character*)char1 atChar:(Character*)char2 {
    NSInteger result = [char1 attack:char2];
    char2.timeNeedToAttack -= char1.timeNeedToAttack;
    [char1 resetTime];
    return result;
}
- (void)updateUI {
    if (self.char1.hasBuff) [self.buffView setHidden:false];
    [self.progress1 setProgress:(float)self.char1.healthNow/self.char1.health animated:YES];
    [self.progress2 setProgress:(float)self.char2.healthNow/self.char2.health animated:YES];
    [self.label1 setText:[NSString stringWithFormat:@"%ld | %ld",self.char1.healthNow,(long)self.char1.health]];
    [self.label2 setText:[NSString stringWithFormat:@"%ld | %ld",self.char2.healthNow,self.char2.health]];
}
- (void)gameRunning {
    NSInteger result;
    if (self.char1.timeNeedToAttack <= self.char2.timeNeedToAttack) {
        result = [self attackByChar:self.char1 atChar:self.char2];
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.imageView1X.constant = 50;
            self.imageView1Y.constant = 50;
            [self.imageView1 setNeedsLayout];
            [self.imageView1 layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.imageView1X.constant = 30;
                self.imageView1Y.constant = 30;
                [self.imageView1 setNeedsLayout];
                [self.imageView1 layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }];
    } else {
        result = [self attackByChar:self.char2 atChar:self.char1];
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.imageView2X.constant = 50;
            self.imageView2Y.constant = 50;
            [self.imageView2 setNeedsLayout];
            [self.imageView2 layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.imageView2X.constant = 30;
                self.imageView2Y.constant = 30;
                [self.imageView2 setNeedsLayout];
                [self.imageView2 layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    if (result != 0) {
        if (result == -1) {
            [self.notif setText:@"Miss!"];
        } else {
            [self.notif setText:@"Critical!"];
        }
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.notif.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.notif.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    [self updateUI];
    if ([self.char1 isAlive] && [self.char2 isAlive]) {
        [self performSelector:@selector(gameRunning) withObject:self afterDelay:2.0 ];
    }
}

- (void)checkTotalTime {
    TrainingTime *timeslot = [[WatchSessionManager sharedInstance] getTrainingTimeToday];
    if ([timeslot.totalTime intValue] >= 60 * 30) {
        //add buff
        self.char1.hasBuff = true;
    }
}

- (void)gameStart {
    [self checkTotalTime];
    [self updateUI];
    [self performSelector:@selector(gameRunning) withObject:self afterDelay:2.0 ];
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

@end
