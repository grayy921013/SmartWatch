//
//  Util.m
//  Test
//
//  Created by vincent on 12/1/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "Util.h"

@implementation Util
+(NSDate *)beginningOfDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    return [calendar dateFromComponents:components];
}
@end
