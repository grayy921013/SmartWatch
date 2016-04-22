//
//  InfoViewController.m
//  Test
//
//  Created by vincent on 12/1/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "InfoViewController.h"
#import "SoundManager.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *rateField;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Setting";
    // Do any additional setup after loading the view from its nib.
    [self.ageField setText:[@([[NSUserDefaults standardUserDefaults] integerForKey:AGE_KEY])stringValue]];
    [self.rateField setText:[@([[NSUserDefaults standardUserDefaults] integerForKey:RATE_KEY])stringValue]];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.ageField.inputAccessoryView = numberToolbar;
    self.rateField.inputAccessoryView = numberToolbar;
    [self.pickerView selectRow:[[SoundManager sharedInstance] getReachSound] inComponent:0 animated:NO];
    [self.pickerView selectRow:[[SoundManager sharedInstance] getDropSound] inComponent:1 animated:NO];
}

-(void)doneWithNumberPad{
    [self.ageField resignFirstResponder];
    [self.rateField resignFirstResponder];
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
- (IBAction)ageChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[self.ageField.text intValue] forKey:AGE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)rateChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[self.rateField.text intValue] forKey:RATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [[[SoundManager sharedInstance] getSoundArray]count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0) {
        [[SoundManager sharedInstance]setReachSound:row];
        [[SoundManager sharedInstance] playReachSound];
    } else {
        [[SoundManager sharedInstance]setDropSound:row];
        [[SoundManager sharedInstance] playDropSound];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [[[[SoundManager sharedInstance] getSoundArray] objectAtIndex:row] lastPathComponent];
}

@end
