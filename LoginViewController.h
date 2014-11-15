//
//  LoginViewController.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-13.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)submit:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *emailOrUsername;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end
