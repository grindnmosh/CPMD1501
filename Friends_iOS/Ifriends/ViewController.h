//
//  ViewController.h
//  Ifriends
//
//  Created by Robert Warren on 1/8/15.
//  Copyright (c) 2015 Robert Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    NSString *user1;
    NSString *pass1;
}

@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@end

