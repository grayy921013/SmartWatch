//
//  WatchSessionManager.m
//  Test
//
//  Created by vincent on 11/3/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "WatchSessionManager.h"
@implementation WatchSessionManager
static WatchSessionManager *sharedInstance;
WCSession *session;
- (instancetype)init {
    if (self) {
        if ([WCSession isSupported]) {
            session = [WCSession defaultSession];
            session.delegate = self;
        }
    }
    return self;
}
- (void)startSession {
    [session activateSession];
}
+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}
-(id)copyWithZone:(NSZone *)zone
{
    return [[self class] sharedInstance];
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    Data *data = [Data initWithDic:message];
    if (data == nil) return;
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = ad.managedObjectContext;
    SensorData *rate = [NSEntityDescription
                        insertNewObjectForEntityForName:@"SensorData"
                        inManagedObjectContext:context];
    [rate copyValue:data];
    [ad saveContext];
    if (data.type == HEARTRATE) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"heartrate"
         object:data];
    } else if (data.type == ENERGY) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"energy"
         object:data];
    }
}
@end
