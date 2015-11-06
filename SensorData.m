//
//  SensorData.m
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "SensorData.h"

@implementation SensorData
-(DataType)itemTypeRaw {
    return (DataType)[[self type] intValue];
}

-(void)setDataTypeRaw:(DataType)type {
    [self setType:[NSNumber numberWithInt:type]];
}
+(NSSet *)keyPathsForValuesAffectingDataTypeRaw {
    return [NSSet setWithObject:@"type"];
}
- (void)copyValue:(Data *)sensorData {
    self.value = [NSNumber numberWithInt:sensorData.value];
    self.startDate = sensorData.startDate;
    self.endDate = sensorData.endDate;
    self.type = [NSNumber numberWithInt:sensorData.type];
}
// Insert code here to add functionality to your managed object subclass

@end
