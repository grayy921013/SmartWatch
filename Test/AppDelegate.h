//
//  AppDelegate.h
//  Test
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
@import WatchConnectivity;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WCSessionDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

