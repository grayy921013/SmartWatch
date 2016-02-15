//
//  Character.m
//  Test
//
//  Created by vincent on 2/15/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "Character.h"

@implementation Character
-(id)initWithHealth:(NSInteger)health attack:(NSInteger)attack defense:(NSInteger)defense timeToAttack:(NSInteger)timeToAttack{
    self = [super init];
    if (self) {
        self.health = health;
        self.attack = attack;
        self.defense = defense;
        self.timeToAttack = timeToAttack;
        self.timeNeedToAttack = timeToAttack;
    }
    return self;
}
-(NSInteger)attack:(Character*)opponent{
    // -1 for miss : 10%; 0 for normal attack : 80%; 1 for critical attack: 10%
    int dice = arc4random() % 10;
    if (dice == 0) {
        return -1;
    } else if (dice == 1) {
        opponent.health = opponent.health + opponent.defense - self.attack * 2;
        return 1;
    } else {
        opponent.health = opponent.health + opponent.defense - self.attack;
        return 0;
    }
}
-(BOOL)isAlive{
    return (self.health > 0);
}
-(void)resetTime{
    self.timeNeedToAttack = self.timeToAttack;
}
@end
