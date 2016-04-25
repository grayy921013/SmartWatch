//
//  RankTableViewController.m
//  Test
//
//  Created by vincent on 2/16/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "RankTableViewController.h"
#import "DataTableViewCell.h"
#import "FBSDKGraphRequest.h"

@interface RankTableViewController ()
@property (nonatomic, retain) NSMutableArray *friendIds;
@end

@implementation RankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Rank";
    // Do any additional setup after loading the view from its nib.
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self
                            action:@selector(refreshRank)
                  forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)refreshRank {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me/friends"
                                  parameters:@{@"fields": @"id, name"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        
        if (!error) {
            // result will contain an array with your user's friends in the "data" key
            NSArray *friendObjects = [result objectForKey:@"data"];
            self.friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
            // Create a list of friends' Facebook IDs
            for (NSDictionary *friendObject in friendObjects) {
                [self.friendIds addObject:[friendObject objectForKey:@"id"]];
            }
        }
    }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.friendIds count];
}

- (void)configureCell:(DataTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [cell.label1 setText:[self.friendIds objectAtIndex:indexPath.row]];
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
