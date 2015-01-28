//
//  UpdateViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/13/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "UpdateViewController.h"
#import <Parse/Parse.h>
#import <unistd.h>
#import <netdb.h>
#import "ListViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    states = [NSArray arrayWithObjects:@"Select A State", @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    // Do any additional setup after loading the view.
    saveId = _insertId;
    NSLog(@"%@", _insertId);
    self->frName.text = _insertName;
    self->fryears.text = [NSString stringWithFormat:@"%@", _insertYear];
    fooIndex = [states indexOfObject: _insertState];
    [self.statePick2 selectRow:fooIndex inComponent:0 animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//show keyboard
- (void)keyboardWillShow:(NSNotification *)notif
{
    
}

//hide keyboard
- (void)keyboardWillHide:(NSNotification *)notif
{
    
}

//reset view when keyboard hides
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
        NSString *nameTest = [frName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (![nameTest  isEqual: @""] && ![fryears.text  isEqual: @""] && ![[self->states objectAtIndex:[self.statePick2 selectedRowInComponent:0]]  isEqual: @"Select A State"])
        {
            PFQuery *query = [PFQuery queryWithClassName:@"rf"];
            [query fromLocalDatastore];
            [query getObjectInBackgroundWithId:saveId block:^(PFObject *friend, NSError *error) {
                friend[@"Name"] = frName.text;
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *myNumber = [f numberFromString:fryears.text];
                friend[@"Age"] = myNumber;
                NSString *stateName = [self->states objectAtIndex:[self.statePick2 selectedRowInComponent:0]];
                NSLog(@"%@", stateName);
                friend[@"State"] = stateName;
                [friend pinInBackground];
                [friend saveEventually];
            }];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Information!" message:@"Please fill in all required fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
        
}

@end
