//
//  InterfaceController.h
//  Test WatchKit Extension
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <HealthKit/HealthKit.h>
#import <Foundation/Foundation.h>
@import WatchConnectivity;

@interface InterfaceController : WKInterfaceController<HKWorkoutSessionDelegate,WCSessionDelegate>

@end
