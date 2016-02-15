//
//  GameViewController.h
//  Test
//
//  Created by vincent on 2/15/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIProgressView *progress1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIProgressView *progress2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView1X;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView1Y;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView2X;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView2Y;
@property (weak, nonatomic) IBOutlet UILabel *notif;
-(id)initWithNibName:(NSString*) String bundle:(NSBundle*)bundle Character1:(Character*)char1 Character2:(Character*)char2;
@end
