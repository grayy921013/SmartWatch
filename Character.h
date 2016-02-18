//
//  Character.h
//  Test
//
//  Created by vincent on 2/15/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject
@property (assign, nonatomic) NSInteger health;
@property (assign, nonatomic) NSInteger healthNow;
@property (assign, nonatomic) NSInteger speed;
@property (assign, nonatomic) NSInteger timeToAttack;
@property (assign, nonatomic) NSInteger timeNeedToAttack;
@property (assign, nonatomic) NSInteger attack;
@property (assign, nonatomic) NSInteger defense;
-(NSInteger)attack:(Character*)opponent;
-(BOOL)isAlive;
-(void)resetTime;
-(id)initWithHealth:(NSInteger)health attack:(NSInteger)attack defense:(NSInteger)defense speed:(NSInteger)speed;
@end
