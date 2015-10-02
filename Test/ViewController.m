//
//  ViewController.m
//  Test
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString *heartrate = [message objectForKey:@"heartrate"];
    NSString *stepcount = [message objectForKey:@"stepcount"];
    if (heartrate != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.textLabel setText:heartrate];
        });
    }
    if (stepcount != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.stepLabel setText:stepcount];
        });
    }
}

@end
