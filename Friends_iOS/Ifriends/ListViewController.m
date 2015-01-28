//
//  ListViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/11/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "ListViewController.h"
#import <Parse/Parse.h>
#import "UpdateViewController.h"
#import "FCell.h"
#import <unistd.h>
#import <netdb.h>

@interface ListViewController ()

@end

@implementation ListViewController


- (void)viewDidLoad {
    UINib *FCellNib = [UINib nibWithNibName:@"FCell" bundle:nil];
    if (FCellNib != nil)
    {
        [_friendslist registerNib:FCellNib forCellReuseIdentifier:@"FCell"];
    }
    [super viewDidLoad];
    self->_friendslist.rowHeight = 50.f;
    NSString *user = [NSString stringWithFormat:@"@""%@",[[PFUser currentUser] valueForKey:@"username"]];
    NSLog(@"%@", user);
   check = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkMethod:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:check forMode:NSDefaultRunLoopMode];
    // Do any additional setup after loading the view.
    char *hostname;
    struct hostent *hostinfo;
    hostname = "parse.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        
    }
    else{
        NSLog(@"-> connection established!\n");
        
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    char *hostname;
    struct hostent *hostinfo;
    hostname = "parse.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Network Detected"
                                                        message:@"Please connect to network"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
        [self performSelector:@selector(test:) withObject:alert afterDelay:2];
        friendsObj = [[NSMutableArray alloc] initWithObjects: nil];
        yearsObj = [[NSMutableArray alloc] initWithObjects: nil];
        stateObj = [[NSMutableArray alloc] initWithObjects: nil];
        idObj = [[NSMutableArray alloc] initWithObjects: nil];
        pinBack = [[NSMutableArray alloc] initWithObjects: nil];
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"%@", objects);
            if (!error) {
                for (int i = 0; i < [objects count]; i++)
                {
                    NSLog(@"%@", [objects objectAtIndex:i]);
                    PFObject *myObject = [objects objectAtIndex:i];
                    name = [myObject objectForKey:@"Name"];
                    years = [myObject objectForKey:@"Age"];
                    state = [myObject objectForKey:@"State"];
                    objId = [myObject objectId];
                    [friendsObj addObject:name];
                    [yearsObj addObject:years];
                    [stateObj addObject:state];
                    [idObj addObject:objId];
                }
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            [_friendslist reloadData];
        }];
    }else{
        NSLog(@"-> connection established!\n");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connected to WiFi"
                                                        message:@"communicating with Server"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
        [self performSelector:@selector(test:) withObject:alert afterDelay:2];
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        NSArray *objects = [query findObjects];
        [PFObject unpinAllInBackground:objects];
        NSArray *objective = [[PFQuery queryWithClassName:@"rf"] findObjects];
        [PFObject pinAllInBackground:objective];
        friendsObj = [[NSMutableArray alloc] initWithObjects: nil];
        yearsObj = [[NSMutableArray alloc] initWithObjects: nil];
        stateObj = [[NSMutableArray alloc] initWithObjects: nil];
        idObj = [[NSMutableArray alloc] initWithObjects: nil];
        pinBack = [[NSMutableArray alloc] initWithObjects: nil];
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
               
                for (int i = 0; i < [objects count]; i++)
                {
                    PFObject *myObject = [objects objectAtIndex:i];
                    name = [myObject objectForKey:@"Name"];
                    years = [myObject objectForKey:@"Age"];
                    state = [myObject objectForKey:@"State"];
                    objId = [myObject objectId];
                    [friendsObj addObject:name];
                    [yearsObj addObject:years];
                    [stateObj addObject:state];
                    [idObj addObject:objId];
                }
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            [_friendslist reloadData];
            
        }];
    }
    
}
-(void)checkMethod:(NSTimer *)check
{
    
    char *hostname;
    struct hostent *hostinfo;
    hostname = "parse.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        
        friendsObj = [[NSMutableArray alloc] initWithObjects: nil];
        yearsObj = [[NSMutableArray alloc] initWithObjects: nil];
        stateObj = [[NSMutableArray alloc] initWithObjects: nil];
        idObj = [[NSMutableArray alloc] initWithObjects: nil];
        pinBack = [[NSMutableArray alloc] initWithObjects: nil];
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"%@", objects);
            if (!error) {
                NSLog(@"%lu", (unsigned long)[objects count]);
                for (int i = 0; i < [objects count]; i++)
                {
                    PFObject *myObject = [objects objectAtIndex:i];
                    name = [myObject objectForKey:@"Name"];
                    years = [myObject objectForKey:@"Age"];
                    state = [myObject objectForKey:@"State"];
                    objId = [myObject objectId];
                    [friendsObj addObject:name];
                    [yearsObj addObject:years];
                    [stateObj addObject:state];
                    [idObj addObject:objId];
                }
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            [_friendslist reloadData];
        }];
    }else{
       
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        NSArray *objects = [query findObjects];
        [PFObject unpinAllInBackground:objects];
        NSArray *objective = [[PFQuery queryWithClassName:@"rf"] findObjects];
        [PFObject pinAllInBackground:objective];
        friendsObj = [[NSMutableArray alloc] initWithObjects: nil];
        yearsObj = [[NSMutableArray alloc] initWithObjects: nil];
        stateObj = [[NSMutableArray alloc] initWithObjects: nil];
        idObj = [[NSMutableArray alloc] initWithObjects: nil];
        pinBack = [[NSMutableArray alloc] initWithObjects: nil];
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                
                for (int i = 0; i < [objects count]; i++)
                {
                    PFObject *myObject = [objects objectAtIndex:i];
                    name = [myObject objectForKey:@"Name"];
                    years = [myObject objectForKey:@"Age"];
                    state = [myObject objectForKey:@"State"];
                    objId = [myObject objectId];
                    [friendsObj addObject:name];
                    [yearsObj addObject:years];
                    [stateObj addObject:state];
                    [idObj addObject:objId];
                }
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            [_friendslist reloadData];
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//determine cell count for listview
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is %lu", (unsigned long)[friendsObj count]);
    return [friendsObj count];
    //return 0;
}

//set up actions to be taken when you delete a cell
-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        query = [PFQuery queryWithClassName:@"rf"];
        [query fromLocalDatastore];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *myObject = [objects objectAtIndex:indexPath.row];
                [myObject unpinInBackground];
                [myObject deleteEventually];
                [friendsObj removeObjectAtIndex:indexPath.row];
                [stateObj removeObjectAtIndex:indexPath.row];
                [yearsObj removeObjectAtIndex:indexPath.row];
                [idObj removeObjectAtIndex:[indexPath row]];
                [_friendslist reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
        }];
        
        [_friendslist reloadData];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    FCell *cell = [_friendslist dequeueReusableCellWithIdentifier:@"FCell"];
    if (cell != nil)
    {
        cell.name = [friendsObj objectAtIndex:[indexPath row]];
        cell.state = [stateObj objectAtIndex:[indexPath row]];
        cell.year = [yearsObj objectAtIndex:[indexPath row]];
        
        [cell loadCell];
        return cell;
    }
    return nil;
    
    
}


//transfer information to new view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"update"]) {
        UpdateViewController *destination = segue.destinationViewController;
        destination.insertName = passName;
        destination.insertYear = passYear;
        destination.insertState = passState;
        destination.insertId = passId;
    }else{
        
    }
    
    
}

//detrmine information to be transferred to next view controller based on selected cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    passName = [friendsObj objectAtIndex:[indexPath row]];
    passYear = [yearsObj objectAtIndex:[indexPath row]];
    passState = [stateObj objectAtIndex:[indexPath row]];
    passId = [idObj objectAtIndex:[indexPath row]];
    NSLog(@"ATTENTION %@", passId);
    [self performSegueWithIdentifier: @"update" sender: self];
}


-(IBAction)onClick:(UIButton*)button
{
    //logout button
    if (button.tag == 0)
    {
        [PFUser logOut];
       
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
    }
    //add button
    else if (button.tag == 1)
    {
       [self performSegueWithIdentifier: @"add" sender: self];
    }
}
-(void)test:(UIAlertView*)x{
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}



@end
