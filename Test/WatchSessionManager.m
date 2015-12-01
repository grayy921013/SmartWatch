//
//  WatchSessionManager.m
//  Test
//
//  Created by vincent on 11/3/15.
//  Copyright © 2015 vincent. All rights reserved.
//
#import "WatchSessionManager.h"
@implementation WatchSessionManager
NSInteger last_heartrate_value;
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
                NSTimeInterval time = [data.startDate timeIntervalSinceDate:last_heartrate_time]; // in seconds
                int diff = round(time);
                if (diff > 0 && diff < 300) {
                    NSInteger max = 220-[[NSUserDefaults standardUserDefaults] integerForKey:AGE_KEY];
                    NSInteger rest = [[NSUserDefaults standardUserDefaults] integerForKey:RATE_KEY];
                    NSInteger point = 0;
                    int totalTime = 0;
                    double multi = 1;
                    
                    //add duration to work out time of today
                    if (last_heartrate_value > max*0.6+rest*0.4) {
                        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                        NSEntityDescription *entity = [NSEntityDescription
                                                       entityForName:@"TrainingTime" inManagedObjectContext:context];
                        [fetchRequest setEntity:entity];
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date == %@)",[Util beginningOfDay:data.startDate]];
                        [fetchRequest setPredicate:predicate];
                        NSError *error;
                        NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
                        if (array == nil || [array count] == 0) {
                            TrainingTime *timeSlot = [NSEntityDescription
                                                      insertNewObjectForEntityForName:@"TrainingTime"
                                                      inManagedObjectContext:context];
                            timeSlot.date = [Util beginningOfDay:data.startDate];
                            timeSlot.totalTime = [NSNumber numberWithInt:diff];
                            totalTime = diff;
                            [ad saveContext];
                        } else {
                            TrainingTime *timeSlot = [array objectAtIndex:0];
                            totalTime = diff+[timeSlot.totalTime intValue];
                            timeSlot.totalTime = [NSNumber numberWithInt:totalTime];
                            
                        }
                    }
                    if (totalTime > 1.5*3600) {
                        multi = 0.5;
                    }
                    
                    //add point
                    if (last_heartrate_value > max*0.8+rest*0.2) {
                        //zone1
                        point = round(diff*multi);
                    } else if (last_heartrate_value > max*0.7+rest*0.3) {
                        //zone2
                        point = round(0.8*diff*multi);
                    } else if (last_heartrate_value > max*0.6+rest*0.4) {
                        //zone3
                        point = round(0.6*diff*multi);
                    }
                    NSInteger newpoint = point + [[NSUserDefaults standardUserDefaults] integerForKey:POINT_KEY];
                    [[NSUserDefaults standardUserDefaults] setInteger:newpoint forKey:POINT_KEY];
                    [[NSUserDefaults standardUserDefaults] synchronize];
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
