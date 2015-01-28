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
    NSString *objId;
    NSString *pinner;
    PFQuery *query;
    NSMutableArray *friendsObj;
    NSMutableArray *yearsObj;
    NSMutableArray *idObj;
    NSMutableArray *stateObj;
    NSMutableArray *pinBack;
    NSString *passName;
    NSNumber *passYear;
    NSString *passState;
    NSString *passId;
    NSTimer *check;
}
@property (weak, nonatomic) IBOutlet UITableView *friendslist;

@end
