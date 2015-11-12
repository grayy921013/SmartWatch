//
//  WatchSessionManager.m
//  Test
//
//  Created by vincent on 11/3/15.
//  Copyright © 2015 vincent. All rights reserved.
//
#import "WatchSessionManager.h"
@implementation WatchSessionManager
int last_heartrate_value;
NSDate *last_heartrate_time = nil;
NSTimer *timer;
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
//    if (GEN_DATA) {
//        [self shouldGenData:YES];
//    }
}
- (void)shouldGenData:(BOOL)generate {
    if (generate) {
    timer = [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(gendataentry)
                                   userInfo:nil
                                    repeats:YES];
    } else {
        [timer invalidate];
        timer = nil;
    }
}
- (void)gendataentry {
    NSDictionary *data = @{@"value": [NSNumber numberWithInt:arc4random_uniform(180)],@"startDate":[NSDate date],@"endDate":[NSDate date],@"type":[NSNumber numberWithInt:HEARTRATE]};
    [self session:nil didReceiveMessage:data];
    
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
    if ([message objectForKey:@"control"]) {
        NSString *control = [message objectForKey:@"control"];
        if ([control isEqualToString:@"end"]) {
            last_heartrate_value = 0;
            last_heartrate_time = nil;
        }
    } else {
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
            //get time interval since last data, and point = (time) * exp(heartrate - 100)
            if (last_heartrate_time != nil) {
                if (last_heartrate_value > THRESHOLD) {
                    NSTimeInterval diff = [data.startDate timeIntervalSinceDate:last_heartrate_time]; // in seconds
                    if (diff > 0 && diff < 300) {
                        //filter error value
                        int point = (int)(pow(1.1,last_heartrate_value - THRESHOLD) * diff / 100);
                        NSInteger newpoint = point + [[NSUserDefaults standardUserDefaults] integerForKey:POINT_KEY];
                        [[NSUserDefaults standardUserDefaults] setInteger:newpoint forKey:POINT_KEY];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }
            }
            last_heartrate_time = data.startDate;
            last_heartrate_value = data.value;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"heartrate"
             object:data];
        } else if (data.type == ENERGY) {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"energy"
             object:data];
        }
    }
}
@end
