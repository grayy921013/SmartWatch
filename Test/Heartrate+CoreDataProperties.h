//
//  Heartrate+CoreDataProperties.h
//  Test
//
//  Created by vincent on 11/3/15.
//  Copyright © 2015 vincent. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Heartrate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heartrate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *point;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
