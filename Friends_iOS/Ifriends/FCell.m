//
//  FCell.m
//  Ifriends
//
//  Created by Robert Warren on 1/13/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import "FCell.h"

@implementation FCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadCell
{
    nameField.text = _name;
    stateField.text = _state;
    yearField.text = [_year stringValue];
}

@end
