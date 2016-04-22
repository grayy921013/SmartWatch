//
//  SensorData+CoreDataProperties.h
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SensorData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SensorData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSNumber *value;

@end

NS_ASSUME_NONNULL_END
