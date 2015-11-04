//
//  InterfaceController.m
//  Test WatchKit Extension
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *heartrateLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *calLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *button;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *heartIcon;
@property (strong, nonatomic) HKHealthStore *healthStore;
@property (strong, nonatomic) HKWorkoutSession *workoutSession;
@property (strong, nonatomic) WCSession *session;
@property (strong, nonatomic) NSMutableArray *anchors;
@property (strong, nonatomic) NSMutableArray *queries;
@end


@implementation InterfaceController
- (id)init {
    self = [super init];
    if (self) {
        self.healthStore = [[HKHealthStore alloc] init];
        self.anchors = [[NSMutableArray alloc]initWithObjects:[HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor],[HKQueryAnchor anchorFromValue:HKAnchoredObjectQueryNoAnchor], nil];
        self.queries = [[NSMutableArray alloc] init];
    }
    return self;
}
- (IBAction)onClick {
    if (self.workoutSession == nil) {
        self.workoutSession = [[HKWorkoutSession alloc] initWithActivityType:HKWorkoutActivityTypeRunning locationType:HKWorkoutSessionLocationTypeOutdoor];
        self.workoutSession.delegate = self;
    }
    if ([self.workoutSession state] == HKWorkoutSessionStateNotStarted) {
        [self.healthStore startWorkoutSession:self.workoutSession];
    }
}
- (IBAction)onCancel {
    if (self.workoutSession != nil && [self.workoutSession state] == HKWorkoutSessionStateRunning) {
        [self.healthStore endWorkoutSession:self.workoutSession];
    }
}
- (void)workoutSession:(HKWorkoutSession *)workoutSession
      didChangeToState:(HKWorkoutSessionState)toState
             fromState:(HKWorkoutSessionState)fromState
                  date:(NSDate *)date {
    switch (toState) {
        case HKWorkoutSessionStateRunning:
            [self workoutDidStart:date];
            break;
        case HKWorkoutSessionStateEnded:
            [self workoutDidEnd:date];
            break;
        default:
            break;
    }
}
- (void)workoutSession:(HKWorkoutSession *)workoutSession didFailWithError:(NSError *)error{
    NSLog(@"error");
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if(![HKHealthStore isHealthDataAvailable]) {
        [self.heartrateLabel setText:@"heath not available"];
    } else {
        
        NSSet <HKQuantityType *> * dataTypes = [NSSet setWithObjects:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], nil];
        
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:dataTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                [self.heartrateLabel setText:@"heath not available"];
            } }];
    }

    // Configure interface objects here.
}
- (void)workoutDidStart:(NSDate *)date {
    [self.queries addObject:[self createHeartRateQuery:date quantity:HKQuantityTypeIdentifierHeartRate updateHandler:@selector(updateHeartRate:) index:0]];
    [self.queries addObject:[self createHeartRateQuery:date quantity:HKQuantityTypeIdentifierStepCount updateHandler:@selector(updateStepCount:) index:1]];
    for (HKAnchoredObjectQuery *query in self.queries) {
        [self.healthStore executeQuery:query];
    }
    [self.heartrateLabel setText:@"started"];
}
- (void)workoutDidEnd:(NSDate *)date {
    for (HKAnchoredObjectQuery *query in self.queries) {
        [self.healthStore stopQuery:query];
    }
    [self.queries removeAllObjects];
    [self.heartrateLabel setText:@"ended"];
    self.workoutSession = nil;
}
- (HKAnchoredObjectQuery*) createHeartRateQuery:(NSDate *)startDate quantity:(NSString *)quantity updateHandler:(SEL)handlerMethod index:(int) index {
    
    HKQuantityType * quantityType = [HKQuantityType quantityTypeForIdentifier:quantity];
    HKAnchoredObjectQuery * query = [[HKAnchoredObjectQuery alloc] initWithType:quantityType predicate:nil anchor:[self.anchors objectAtIndex:index] limit:HKObjectQueryNoLimit resultsHandler:^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable sampleObjects, NSArray<HKDeletedObject *> * _Nullable deletedObjects, HKQueryAnchor * _Nullable newAnchor, NSError * _Nullable error) {
        if (newAnchor != nil) {
            [self.anchors replaceObjectAtIndex:index withObject:newAnchor];
            if ([self respondsToSelector:handlerMethod]) {
                [self performSelector:handlerMethod withObject:sampleObjects];
            }
            //[self updateHeartRate:sampleObjects];
        }
    }];
    query.updateHandler = ^(HKAnchoredObjectQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable sampleObjects, NSArray<HKDeletedObject *> * _Nullable deletedObjects, HKQueryAnchor * _Nullable newAnchor, NSError * _Nullable error) {
        if (newAnchor != nil) {
            [self.anchors replaceObjectAtIndex:index withObject:newAnchor];
            [self performSelector:handlerMethod withObject:sampleObjects];
        }
    };
    return query;
}
- (void) updateHeartRate:(NSArray<HKSample *> *) sampleObjects {
    dispatch_async(dispatch_get_main_queue(), ^{
        HKSample * sample = sampleObjects.firstObject;
        if (sample != nil && [sample isKindOfClass:[HKQuantitySample class]]) {
            double value = [((HKQuantitySample *)sample).quantity doubleValueForUnit:[HKUnit unitFromString:@"count/min"]];
            int intValue = (int)value;
            [self.heartrateLabel setText:[NSString stringWithFormat:@"%d",intValue]];
            NSString *counterString = [NSString stringWithFormat:@"%d", intValue];
            NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"heartrate"]];
            
            [self.session sendMessage:applicationData replyHandler:nil errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"sent error");
            }];
            [self animateWithDuration:0.5 animations:^{
                [self.heartIcon setWidth:68.8];
                [self.heartIcon setHeight:52.8];
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC),
                           dispatch_get_main_queue(), ^{
                               [self animateWithDuration:0.5 animations:^{
                                   [self.heartIcon setWidth:76];
                                   [self.heartIcon setHeight:66];
                               }];
            });

        }
    });
}

- (void) updateStepCount:(NSArray<HKSample *> *) sampleObjects {
    dispatch_async(dispatch_get_main_queue(), ^{
        HKSample * sample = sampleObjects.firstObject;
        if (sample != nil && [sample isKindOfClass:[HKQuantitySample class]]) {
            double value = [((HKQuantitySample *)sample).quantity doubleValueForUnit:[HKUnit countUnit]];
            int intValue = (int)value;
            [self.calLabel setText:[NSString stringWithFormat:@"%d",intValue]];
            NSString *counterString = [NSString stringWithFormat:@"%d", intValue];
            NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"stepcount"]];
            
            [self.session sendMessage:applicationData replyHandler:nil errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"sent error");
            }];
        }
    });
}


- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if ([WCSession isSupported]) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
        [self.session activateSession];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



