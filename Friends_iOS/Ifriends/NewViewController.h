//
//  NewViewController.h
//  Ifriends
//
//  Created by Robert Warren on 1/12/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    NSArray *states;
    IBOutlet UITextField *fryears;
    IBOutlet UITextField *frName;
}
@property (strong, nonatomic) IBOutlet UIPickerView *statePick1;
@end
