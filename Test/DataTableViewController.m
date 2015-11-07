//
//  ViewController.m
//  Test
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "DataTableViewController.h"

@interface DataTableViewController ()
@property (retain,nonatomic) NSMutableArray *array;
@end

@implementation DataTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.type == HEARTRATE) {
        self.title = @"Heartrate";
    } else {
        self.title = @"Energy";
    }
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Remove All"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(resetData)];
    self.navigationItem.rightBarButtonItem = resetButton;
    self.array = [[NSMutableArray alloc] init];
}
- (void)resetData {
    NSArray *fetchedObjects = [self fetchObjects];
    if (fetchedObjects != nil && [fetchedObjects count] > 0) {
        AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
        for (SensorData *sensorData in fetchedObjects) {
            [managedObjectContext deleteObject:sensorData];
            NSError *error;
            [managedObjectContext save:&error];
        }
        self.array = [[NSMutableArray alloc] init];
        [self.tableView reloadData];
    }
}
- (id) initWithType:(DataType)type {
    if (self) {
        self.type = type;
    }
    return self;
}
- (NSArray *)fetchObjects {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"SensorData" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(type == %d)",self.type];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    return [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}
- (void)loadDataFromDatabase {
    NSArray *fetchedObjects = [self fetchObjects];
    if (fetchedObjects != nil) {
        self.array = [[NSMutableArray alloc] init];
        for (SensorData *sensorData in fetchedObjects) {
            Data *data = [sensorData getDataFromSensorData];
            [self.array addObject:data];
        }
    }
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [self loadDataFromDatabase];
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
        SensorData *sensorData = notification.object;
        if ([sensorData.type intValue] == self.type) {
            dispatch_async (dispatch_get_main_queue(), ^{
                [self.array addObject:sensorData];
                [self.tableView reloadData];
            });
        }
    }
}
#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    Data *data = [self.array objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[NSString stringWithFormat: @"value:%ld | %@",data.value, data.startDate]];
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
    return self.array == nil? 0:[self.array count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
