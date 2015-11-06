//
//  WatchSessionManager.h
//  Test
//
//  Created by vincent on 11/3/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchConnectivity;
#import <CoreData/CoreData.h>
#import "WatchSessionManager.h"
#import "AppDelegate.h"
#import "SensorData.h"
@interface WatchSessionManager : NSObject<WCSessionDelegate>
- (void)startSession;
+(instancetype)sharedInstance;
@end
