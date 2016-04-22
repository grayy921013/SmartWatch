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
    character.experiencePerLevel = @50;
    character.level = @1;
    character.health = @2000;
    character.healthinc = @200;
    character.attack = @50;
    character.attackinc = @5;
    character.defense = @0;
    character.defenseinc = @0;
    character.speed = @40;
    character.speedinc = @0;
    [ad saveContext];
    
    character = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Character"
                              inManagedObjectContext:context];
    character.character_id = @1;
    character.name = @"Hog Rider";
    character.experiencePerLevel = @40;
    character.level = @1;
    character.health = @800;
    character.healthinc = @80;
    character.attack = @160;
    character.attackinc = @16;
    character.defense = @0;
    character.defenseinc = @0;
    character.speed = @40;
    character.speedinc = @0;
    [ad saveContext];
    
    character = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Character"
                 inManagedObjectContext:context];
    character.character_id = @2;
    character.name = @"Archer";
    character.experiencePerLevel = @30;
    character.level = @1;
    character.health = @250;
    character.healthinc = @30;
    character.attack = @250;
    character.attackinc = @30;
    character.defense = @0;
    character.defenseinc = @0;
    character.speed = @50;
    character.speedinc = @0;
    [ad saveContext];
    
    character = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Character"
                 inManagedObjectContext:context];
    character.character_id = @101;
    character.name = @"Boss";
    character.experiencePerLevel = @100;
    character.level = @1;
    character.health = @340;
    character.healthinc = @30;
    character.attack = @130;
    character.attackinc = @15;
    character.defense = @0;
    character.defenseinc = @0;
    character.speed = @35;
    character.speedinc = @0;
    [ad saveContext];
}
@end
