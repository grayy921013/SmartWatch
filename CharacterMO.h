//
//  CharacterMO.h
//  Test
//
//  Created by vincent on 2/18/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Character.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharacterMO : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(Character*)getCharacterByID:(NSInteger)Id;
+(void)init;
+(CharacterMO*)getRecordByID:(NSInteger)Id;
+(CharacterMO*)getUserCharacter;
+(NSInteger)getUserCharacterId;
+(void)setUserCharacterId:(NSInteger)id;
-(Character*)convertToCharacter;
+(NSArray*)getAvailableUserRecords;
-(void)levelUp;
@end

NS_ASSUME_NONNULL_END

#import "CharacterMO+CoreDataProperties.h"
