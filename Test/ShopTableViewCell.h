//
//  ShopTableViewCell.h
//  Test
//
//  Created by vincent on 3/31/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterMO.h"
@protocol UITableViewReload
- (void)reloadData;
@end

@interface ShopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) id<UITableViewReload> delegate;
- (void)setData:(CharacterMO*)c;
- (IBAction)didSelect:(id)sender;
@end

