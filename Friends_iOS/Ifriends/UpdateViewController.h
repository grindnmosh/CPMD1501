//
//  UpdateViewController.h
//  Ifriends
//
//  Created by Robert Warren on 1/13/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    NSArray *states;
    NSString *saveId;
    NSUInteger fooIndex;
    IBOutlet UITextField *fryears;
    IBOutlet UITextField *frName;
}
@property (strong, nonatomic) IBOutlet UIPickerView *statePick2;
@property (strong, nonatomic) NSString *insertName;
@property (strong, nonatomic) NSNumber *insertYear;
@property (strong, nonatomic) NSString *insertState;
@property (strong, nonatomic) NSString *insertId;

@end
