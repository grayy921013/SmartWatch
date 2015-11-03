//
//  ViewController.m
//  Test
//
//  Created by vincent on 9/26/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI:)
                                                 name:@"heartrate"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI:)
                                                 name:@"stepcount"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateUI:(NSNotification*) notification {
    if ([[notification name] isEqualToString:@"heartrate"]) {
        dispatch_async (dispatch_get_main_queue(), ^{
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *managedObjectContext = ad.managedObjectContext;
            NSEntityDescription *entity = [NSEntityDescription
                                           entityForName:@"Heartrate" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date == %@)",[NSDate date]];
            //[fetchRequest setPredicate:predicate];
            NSError *error;
            NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (fetchedObjects != nil && [fetchedObjects count] > 0) {
                Heartrate *rate = [fetchedObjects lastObject];
                [self.textLabel setText:[NSString stringWithFormat: @"%@", rate.point]];
            }
        });
    } else if ([[notification name] isEqualToString:@"stepcount"]) {
        dispatch_async (dispatch_get_main_queue(), ^{
            [self.stepLabel setText:[notification object]];
        });
    }
}

@end
