//
//  ViewController.h
//  Test
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensorData.h"
#import "AppDelegate.h"
#import "DataTableViewCell.h"
@interface DataTableViewController : UITableViewController <WCSessionDelegate>
@property (assign, nonatomic) DataType type;
- (id) initWithType:(DataType)type;
@end

