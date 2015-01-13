//
//  ListViewController.m
//  Ifriends
//
//  Created by Robert Warren on 1/11/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "ListViewController.h"
#import <Parse/Parse.h>

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    friendsObj = [[NSMutableArray alloc] initWithObjects: nil];
    yearsObj = [[NSMutableArray alloc] initWithObjects: nil];
    query = [PFQuery queryWithClassName:@"rf"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i < [objects count]; i++)
            {
                name = [[objects objectAtIndex:i] objectForKey:@"Name"];
                years = [[objects objectAtIndex:i] objectForKey:@"Age"];
                PFObject *myObject = [objects objectAtIndex:i];
                NSString *object = [myObject objectId];
                [friendsObj addObject:name];
                [yearsObj addObject:years];
                NSLog(@"%@", name);
                NSLog(@"%@", years);
                
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
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"count at cell is %lu %@", (unsigned long)[friendsObj count], friendsObj);
    static NSString *ident =  @"friends";
    UITableViewCell *cell = [_friendslist dequeueReusableCellWithIdentifier:ident];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    NSString *currentFr = [friendsObj objectAtIndex:[indexPath row]];
    NSString *currentyears = [yearsObj objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentFr;
    cell.detailTextLabel.text = currentyears;
    return cell;
    
    
}


//transfer information to new view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

//detrmine information to be transferred to next view controller based on selected cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
