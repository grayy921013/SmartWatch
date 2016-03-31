//
//  CharacterMO.m
//  Test
//
//  Created by vincent on 2/18/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "CharacterMO.h"
#import "AppDelegate.h"
#import "Constants.h"

@implementation CharacterMO

// Insert code here to add functionality to your managed object subclass
-(Character*)convertToCharacter{
    NSInteger level = [self.level integerValue];
    NSInteger health = [self.health integerValue] + level * [self.healthinc integerValue];
    NSInteger attack = [self.attack integerValue] + level * [self.attackinc integerValue];
    NSInteger defense = [self.defense integerValue] + level * [self.defenseinc integerValue];
    NSInteger speed = [self.speed integerValue] + level * [self.speedinc integerValue];
    Character* character = [[Character alloc] initWithHealth:health attack:attack defense:defense speed:speed];
    return character;
}

+(CharacterMO*)getUserCharacter {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:CHARACTER_KEY] == nil) {
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:CHARACTER_KEY];
    }
    NSInteger id = [[NSUserDefaults standardUserDefaults] integerForKey:CHARACTER_KEY];
    return [self getRecordByID:id];
}

+(NSInteger)getUserCharacterId {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:CHARACTER_KEY] == nil) {
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:CHARACTER_KEY];
        return 0;
    }
    return [[NSUserDefaults standardUserDefaults] integerForKey:CHARACTER_KEY];
}

+(void)setUserCharacterId:(NSInteger)id {
    [[NSUserDefaults standardUserDefaults]setInteger:id forKey:CHARACTER_KEY];
}

+(CharacterMO*)getRecordByID:(NSInteger)Id{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Character" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(character_id == %d)",Id];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *array =[managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (array.count == 0) return nil;
    CharacterMO *item = [array objectAtIndex:0];
    return item;
}

+(NSArray*)getAvailableUserRecords{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Character" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(character_id <= 100)"];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *array =[managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return array;
}

+(Character*)getCharacterByID:(NSInteger)Id{
    CharacterMO *item = [self getRecordByID:Id];
    if (item != nil) return [item convertToCharacter];
    else return nil;
}
-(void)levelUp{
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.level = @([self.level integerValue] + 1);
    [ad saveContext];
}
+(void)init{
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = ad.managedObjectContext;
    if ([self getCharacterByID:0] != nil) return;
    //init user characters
    CharacterMO *character = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Character"
                        inManagedObjectContext:context];
    character.character_id = @0;
    character.name = @"Giant";
    character.experiencePerLevel = @10;
    character.level = @1;
    character.health = @100;
    character.healthinc = @10;
    character.attack = @20;
    character.attackinc = @2;
    character.defense = @10;
    character.defenseinc = @1;
    character.speed = @10;
    character.speedinc = @1;
    [ad saveContext];
    
    character = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Character"
                              inManagedObjectContext:context];
    character.character_id = @1;
    character.name = @"Hog Rider";
    character.experiencePerLevel = @10;
    character.level = @1;
    character.health = @100;
    character.healthinc = @10;
    character.attack = @20;
    character.attackinc = @2;
    character.defense = @10;
    character.defenseinc = @1;
    character.speed = @10;
    character.speedinc = @1;
    [ad saveContext];
    
    character = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Character"
                 inManagedObjectContext:context];
    character.character_id = @2;
    character.name = @"Archer";
    character.experiencePerLevel = @10;
    character.level = @1;
    character.health = @100;
    character.healthinc = @10;
    character.attack = @20;
    character.attackinc = @2;
    character.defense = @10;
    character.defenseinc = @1;
    character.speed = @10;
    character.speedinc = @1;
    [ad saveContext];
    
    character = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Character"
                 inManagedObjectContext:context];
    character.character_id = @101;
    character.name = @"stage 1";
    character.experiencePerLevel = @100;
    character.level = @1;
    character.health = @100;
    character.healthinc = @10;
    character.attack = @20;
    character.attackinc = @2;
    character.defense = @10;
    character.defenseinc = @1;
    character.speed = @10;
    character.speedinc = @1;
    [ad saveContext];
}
@end
