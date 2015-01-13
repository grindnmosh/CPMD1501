//
//  UpdateViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/13/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "UpdateViewController.h"
#import <Parse/Parse.h>

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    states = [NSArray arrayWithObjects:@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    // Do any additional setup after loading the view.
    saveId = _insertId;
    NSLog(@"%@", _insertId);
    self->frName.text = _insertName;
    self->fryears.text = [NSString stringWithFormat:@"%@", _insertYear];
    fooIndex = [states indexOfObject: _insertState];
    [self.statePick2 selectRow:fooIndex inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
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
    //update button
    else if (button.tag == 1)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"rf"];
        NSLog(@"%@", saveId);
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:saveId block:^(PFObject *friend, NSError *error) {
            friend[@"Name"] = frName.text;
            friend[@"Age"] = fryears.text;
            NSString *stateName = [self->states objectAtIndex:[self.statePick2 selectedRowInComponent:0]];
            NSLog(@"%@", stateName);
            friend[@"State"] = stateName;
            [friend saveInBackground];
            
            
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
