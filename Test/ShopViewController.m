//
//  ShopViewController.m
//  Test
//
//  Created by vincent on 2/16/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()
@property(nonatomic, retain) NSArray *array;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shop";
    self.array = [CharacterMO getAvailableUserRecords];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Methods

- (void)configureCell:(ShopTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    CharacterMO* item = [self.array objectAtIndex:indexPath.row];
    [cell setData:item];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    ShopTableViewCell *cell = (ShopTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShopTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [self configureCell:cell forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array == nil? 0:[self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
@end
