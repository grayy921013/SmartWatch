//
//  ViewController.m
//  Test
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "DataTableViewController.h"

@interface DataTableViewController ()

@end

@implementation DataTableViewController
NSArray *array;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.type == HEARTRATE) {
        self.title = @"Heartrate";
    } else {
        self.title = @"Energy";
    }
}
- (id) initWithType:(DataType)type {
    if (self) {
        self.type = type;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"SensorData" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type == %d)",self.type];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil && [fetchedObjects count] > 0) {
        array = fetchedObjects;
        [self.tableView reloadData];
    }
    if (self.type == HEARTRATE) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI:)
                                                 name:@"heartrate"
                                               object:nil];
    } else {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI:)
                                                 name:@"energy"
                                               object:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateUI:(NSNotification*) notification {
    if ([[notification name] isEqualToString:@"heartrate"] || [[notification name] isEqualToString:@"energy"]) {
        dispatch_async (dispatch_get_main_queue(), ^{
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
            NSEntityDescription *entity = [NSEntityDescription
                                           entityForName:@"SensorData" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type == %d)",self.type];
            [fetchRequest setPredicate:predicate];
            NSError *error;
            NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (fetchedObjects != nil && [fetchedObjects count] > 0) {
                array = fetchedObjects;
                [self.tableView reloadData];
            }
        });
    }
}
#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    SensorData *data = [array objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[NSString stringWithFormat: @"value:%@ | %@",data.value, data.startDate]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array == nil? 0:[array count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", @(indexPath.row + 1)]];
}
@end