//
//  ViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/8/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //testObject[@"foo"] = @"bar";
    //[testObject saveInBackground];
    // Do any additional setup after loading the view, typically from a nib.
    _pass.secureTextEntry = YES;
    
}

- (void) viewDidAppear:(BOOL)animated {
    PFUser *currentUser = [PFUser currentUser];
    if ([currentUser objectId] != nil) {
        NSLog(@"%@", [NSString stringWithFormat:@"@""%@",[currentUser valueForKey:@"username"]]);
        [self performSegueWithIdentifier: @"logged" sender: self];
    } else {
        NSLog(@"not logged in");
    }
}
- (void)applicationFinishedRestoringState{
    [super applicationFinishedRestoringState];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(UIButton*)button
{
    //signup button
    if (button.tag == 0)
    {
        PFUser *user = [PFUser user];
        user.username = _user.text;
        user.password = _pass.text;

        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Registered" message:@"Please Sign In" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed To Register" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    //signin button
    else if (button.tag == 1)
    {
        user1 = _user.text;
        pass1 = _pass.text;
        [PFUser logInWithUsernameInBackground:user1 password:pass1 block:^(PFUser *user, NSError *error) {
            if (user) {
                _user.text = @"";
                _pass.text = @"";
                [self performSegueWithIdentifier: @"logged" sender: self];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Failed" message:@"Please Try Again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"logged"])
    {
        
    }
}

@end
