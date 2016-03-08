//
//  HomeViewController.h
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIImage+animatedGIF.h"
#import "Util.h"
#import "YLProgressBar.h"
@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *levelUpBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet YLProgressBar *dayProgress;
@property (weak, nonatomic) IBOutlet UIImageView *progressIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorX;

@end
