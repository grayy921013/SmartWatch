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
@property (assign, nonatomic) NSInteger timeToAttack;
@property (assign, nonatomic) NSInteger timeNeedToAttack;
@property (assign, nonatomic) NSInteger attack;
@property (assign, nonatomic) NSInteger defense;
@end
