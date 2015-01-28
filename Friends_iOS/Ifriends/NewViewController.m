//
//  NewViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/12/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "NewViewController.h"
#import <Parse/Parse.h>
#import <unistd.h>
#import <netdb.h>

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    states = [NSArray arrayWithObjects:@"Select A State", @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    // Do any additional setup after loading the view.
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
    //save button
    else if (button.tag == 1)
    {
        
        NSString *nameTest = [frName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (![nameTest  isEqual: @""] && ![fryears.text  isEqual: @""] && ![[self->states objectAtIndex:[self.statePick1 selectedRowInComponent:0]]  isEqual: @"Select A State"])
        {
            char *hostname;
            struct hostent *hostinfo;
            hostname = "parse.com";
            hostinfo = gethostbyname (hostname);
            if (hostinfo == NULL){
                NSLog(@"-> no connection!\n");
                
                PFObject *rf = [PFObject objectWithClassName:@"rf"];
                rf[@"Name"] = frName.text;
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *myNumber = [f numberFromString:fryears.text];
                rf[@"Age"] = myNumber;
                NSString *stateName = [self->states objectAtIndex:[self.statePick1 selectedRowInComponent:0]];
                NSLog(@"%@", stateName);
                rf[@"State"] = stateName;
                [rf pinInBackground];
                [rf saveEventually];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                NSLog(@"-> connection established!\n");
                NSLog(@"-> connection established!\n");
                NSLog(@"-> no connection!\n");
                
                PFObject *rf = [PFObject objectWithClassName:@"rf"];
                rf[@"Name"] = frName.text;
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *myNumber = [f numberFromString:fryears.text];
                rf[@"Age"] = myNumber;
                NSString *stateName = [self->states objectAtIndex:[self.statePick1 selectedRowInComponent:0]];
                NSLog(@"%@", stateName);
                rf[@"State"] = stateName;
                [rf pinInBackground];
                [rf saveInBackground];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Information!" message:@"Please fill in all required fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
}

-(void)test:(UIAlertView*)x{
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
