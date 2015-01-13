//
//  ListViewController.h
//  Ifriends
//
//  Created by Robert Warren on 1/11/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ListViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSString *name;
    NSString *state;
    NSNumber *years;
    PFQuery *query;
    NSMutableArray *friendsObj;
    NSMutableArray *yearsObj;
}
@property (weak, nonatomic) IBOutlet UITableView *friendslist;

@end
