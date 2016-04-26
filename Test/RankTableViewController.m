//
//  RankTableViewController.m
//  Test
//
//  Created by vincent on 2/16/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "RankTableViewController.h"
#import "RankTableViewCell.h"
#import "FBSDKGraphRequest.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Util.h"
#import "RankItem.h"

@interface RankTableViewController ()
@property (nonatomic, retain) NSMutableArray *rankItems;
@property (nonatomic, retain) NSMutableDictionary *nameDicts;
@end

@implementation RankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Rank";
    self.tableView.rowHeight = 80;
    // Do any additional setup after loading the view from its nib.
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self
                            action:@selector(refreshRank)
                  forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self refreshRank];
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
            self.nameDicts = [NSMutableDictionary new];
            self.rankItems = [NSMutableArray new];
            NSArray *friendObjects = [result objectForKey:@"data"];
            NSMutableArray* friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
            // Create a list of friends' Facebook IDs
            for (NSDictionary *friendObject in friendObjects) {
                [friendIds addObject:[friendObject objectForKey:@"id"]];
                [self.nameDicts setObject:[friendObject objectForKey:@"name"] forKey:[friendObject objectForKey:@"id"]];
            }
            AVQuery *query = [AVQuery queryWithClassName:@"DailyPoints"];
            [query whereKey:@"UserID" containedIn:friendIds];
            [query whereKey:@"updatedAt" greaterThanOrEqualTo:[Util beginningOfDay:[NSDate date]]];
            [query orderByDescending:@"Points"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                for(AVObject* object in objects) {
                    RankItem* item = [RankItem new];
                    item.name = [self.nameDicts objectForKey:[object valueForKey:@"UserID"]];
                    item.points = [[object valueForKey:@"Points"] integerValue];
                    [self.rankItems addObject:item];
                }
                [self reloadData];
            }];
        }
    }];
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
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
    return self.rankItems == nil ? 0 : [self.rankItems count];
}

- (void)configureCell:(RankTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    RankItem *item = [self.rankItems objectAtIndex:indexPath.row];
    [cell.label1 setText:item.name];
    [cell.label2 setText:[NSString stringWithFormat:@"%ld", item.points]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    RankTableViewCell *cell = (RankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RankTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}
@end
