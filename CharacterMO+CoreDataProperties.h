//
//  CharacterMO+CoreDataProperties.h
//  Test
//
//  Created by vincent on 2/18/16.
//  Copyright © 2016 vincent. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CharacterMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharacterMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *attack;
@property (nullable, nonatomic, retain) NSNumber *character_id;
@property (nullable, nonatomic, retain) NSNumber *defense;
@property (nullable, nonatomic, retain) NSNumber *health;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *speed;
@property (nullable, nonatomic, retain) NSNumber *attackinc;
@property (nullable, nonatomic, retain) NSNumber *defenseinc;
@property (nullable, nonatomic, retain) NSNumber *experiencePerLevel;
@property (nullable, nonatomic, retain) NSNumber *healthinc;
@property (nullable, nonatomic, retain) NSNumber *speedinc;

@end

NS_ASSUME_NONNULL_END
