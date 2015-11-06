//
//  Data.h
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
typedef enum {
    HEARTRATE = 0,
    ENERGY = 1,
} DataType;
@property (assign, nonatomic) int value;
@property (retain, nonatomic) NSDate* startDate;
@property (retain, nonatomic) NSDate* endDate;
@property (assign, nonatomic) DataType type;
-(id)initWithValue:(int)value startDate:(NSDate*)start endDate:(NSDate*)end dataType:(DataType)type;
-(NSDictionary*)convertToDic;
+(instancetype)initWithDic:(NSDictionary*)dic;
@end
