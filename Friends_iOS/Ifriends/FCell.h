//
//  FCell.h
//  Ifriends
//
//  Created by Robert Warren on 1/13/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCell : UITableViewCell
{
    IBOutlet UILabel *nameField;
    IBOutlet UILabel *stateField;
    IBOutlet UILabel *yearField;
    
}
-(void)loadCell;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSString *state;


@end
