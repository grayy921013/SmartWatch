//
//  Character.m
//  Test
//
//  Created by vincent on 2/15/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "Character.h"

@implementation Character
-(id)initWithHealth:(NSInteger)health attack:(NSInteger)attack defense:(NSInteger)defense speed:(NSInteger)speed{
    self = [super init];
    if (self) {
        self.health = health;
        self.healthNow = health;
        self.attack = attack;
        self.defense = defense;
        self.speed = speed;
    }
    return self;
}
-(NSInteger)attack:(Character*)opponent{
    // -1 for miss : 10%; 0 for normal attack : 80%; 1 for critical attack: 10%
    // if buff: no miss and double possibilty of critical hit
    int dice = arc4random() % 10;
    if (!self.hasBuff && dice == 0) {
        return -1;
    } else if ((!self.hasBuff &&dice == 1)||(self.hasBuff && dice <=1)) {
        opponent.healthNow = opponent.healthNow + opponent.defense - self.attack * 2;
        if (opponent.healthNow < 0) opponent.healthNow = 0;
        return 1;
    } else {
        opponent.healthNow = opponent.healthNow + opponent.defense - self.attack;
        if (opponent.healthNow < 0) opponent.healthNow = 0;
        return 0;
    }
}
-(BOOL)isAlive{
    return (self.healthNow > 0);
}
-(void)resetTime{
    self.timeNeedToAttack = self.timeToAttack;
}
@end
