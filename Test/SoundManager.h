//
//  SoundManager.h
//  Test
//
//  Created by vincent on 4/5/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject
-(void)playReachSound;
-(void)playDropSound;
-(void)setReachSound:(NSInteger)index;
-(void)setDropSound:(NSInteger)index;
-(NSArray*)getSoundArray;
+(instancetype)sharedInstance;
-(NSInteger)getReachSound;
-(NSInteger)getDropSound;
@end
