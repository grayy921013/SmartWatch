//
//  ShopTableViewCell.m
//  Test
//
//  Created by vincent on 3/31/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "ShopTableViewCell.h"

@interface ShopTableViewCell ()
@property(nonatomic, retain) CharacterMO* character;
@end

@implementation ShopTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setData:(CharacterMO*)c {
    self.character = c;
    [self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"char%@.png", self.character.character_id]]];
    [self.nameLabel setText:c.name];
    if ([self.character.character_id integerValue] == [CharacterMO getUserCharacterId]) {
        [self.selectBtn setTitle:@"Selected" forState:UIControlStateNormal];
    } else {
        [self.selectBtn setTitle:@"Select" forState:UIControlStateNormal];
    }
}


- (IBAction)didSelect:(id)sender {
    [CharacterMO setUserCharacterId:[self.character.character_id integerValue]];
    [self.delegate reloadData];
}
@end
