//
//  TrainingTime+CoreDataProperties.h
//  Test
//
//  Created by vincent on 12/1/15.
//  Copyright © 2015 vincent. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TrainingTime.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainingTime (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *totalTime;

@end

NS_ASSUME_NONNULL_END
