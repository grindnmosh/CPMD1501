//
//  NewViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/12/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "NewViewController.h"
#import <Parse/Parse.h>

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    states = [NSArray arrayWithObjects:@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [states count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@", [states objectAtIndex:row]];
}

-(IBAction)onClick:(UIButton*)button
{
    //back button
    if (button.tag == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //save button
    else if (button.tag == 1)
    {
        PFObject *rf = [PFObject objectWithClassName:@"rf"];
        rf[@"Name"] = frName.text;
        rf[@"Age"] = fryears.text;
        NSString *stateName = [self->states objectAtIndex:[self.statePick1 selectedRowInComponent:0]];
        NSLog(@"%@", stateName);
        rf[@"State"] = stateName;
        [rf saveInBackground];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
