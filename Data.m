//
//  Data.m
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "Data.h"

@implementation Data

-(id)initWithValue:(int)value startDate:(NSDate*)start endDate:(NSDate*)end dataType:(DataType)type{
    self = [super init];
    if (self) {
        self.value = value;
        self.startDate = start;
        self.endDate = end;
        self.type = type;
    }
    return self;
}
-(NSDictionary*)convertToDic {
    NSDictionary *data = @{@"value": [NSNumber numberWithInt:self.value],@"startDate":self.startDate,@"endDate":self.endDate,@"type":[NSNumber numberWithInt:self.type]};
    return data;
}
+(instancetype)initWithDic:(NSDictionary*)dic{
    Data *instance = [[Data alloc]init];
    instance.value = [[dic objectForKey:@"value"] intValue];
    instance.startDate = [dic objectForKey:@"startDate"];
    instance.endDate = [dic objectForKey:@"endDate"];
    instance.type = (DataType)[[dic objectForKey:@"type"] intValue];
    return instance;
}
@end
