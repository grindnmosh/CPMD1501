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
   
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    friendsObj = [[NSMutableArray alloc] initWithObjects: nil];
    yearsObj = [[NSMutableArray alloc] initWithObjects: nil];
    stateObj = [[NSMutableArray alloc] initWithObjects: nil];
    idObj = [[NSMutableArray alloc] initWithObjects: nil];
    query = [PFQuery queryWithClassName:@"rf"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i < [objects count]; i++)
            {
                name = [[objects objectAtIndex:i] objectForKey:@"Name"];
                years = [[objects objectAtIndex:i] objectForKey:@"Age"];
                state = [[objects objectAtIndex:i] objectForKey:@"State"];
                PFObject *myObject = [objects objectAtIndex:i];
                NSString *object = [myObject objectId];
                objId = object;
                [friendsObj addObject:name];
                [yearsObj addObject:years];
                [stateObj addObject:state];
                [idObj addObject:objId];
                NSLog(@"%@", name);
                NSLog(@"%@", years);
                NSLog(@"%@", objId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [_friendslist reloadData];
    }];
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
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *myObject = [objects objectAtIndex:indexPath.row];
                [friendsObj removeObjectAtIndex:indexPath.row];
                [myObject deleteInBackground];
                [_friendslist reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            [_friendslist reloadData];
        }];
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *ident =  @"friends";
    UITableViewCell *cell = [_friendslist dequeueReusableCellWithIdentifier:ident];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    NSString *currentFr = [friendsObj objectAtIndex:[indexPath row]];
    NSString *currentyears = [yearsObj objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentFr;
    cell.detailTextLabel.text = currentyears;*/
    
    FCell *cell = [_friendslist dequeueReusableCellWithIdentifier:@"FCell"];
    if (cell != nil)
    {
        NSString *currentFr = [friendsObj objectAtIndex:[indexPath row]];
        NSString *currentYears = [yearsObj objectAtIndex:[indexPath row]];
        NSString *currentSt = [stateObj objectAtIndex:[indexPath row]];
        cell.name = currentFr;
        cell.state = currentSt;
        cell.year = currentYears;
        
        [cell loadCell];
        return cell;
    }
    return nil;
    
    
}


//transfer information to new view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UpdateViewController *destination = segue.destinationViewController;
    destination.insertName = passName;
    destination.insertYear = passYear;
    destination.insertState = passState;
    destination.insertId = passId;
    
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
       
    }
}


@end
