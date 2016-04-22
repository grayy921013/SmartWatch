//
//  RankTableViewController.m
//  Test
//
//  Created by vincent on 2/16/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "RankTableViewController.h"
#import "DataTableViewCell.h"

@interface RankTableViewController ()

@end

@implementation RankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

- (void)configureCell:(DataTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [cell.label1 setText:[@(indexPath.row) stringValue]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    DataTableViewCell *cell = (DataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DataTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}
@end
