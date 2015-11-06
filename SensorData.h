//
//  SensorData.h
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Data.h"

NS_ASSUME_NONNULL_BEGIN

@interface SensorData : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
-(void)copyValue:(Data*)sensorData;
-(DataType)itemTypeRaw;
-(void)setDataTypeRaw:(DataType)type;
@end

NS_ASSUME_NONNULL_END

#import "SensorData+CoreDataProperties.h"
