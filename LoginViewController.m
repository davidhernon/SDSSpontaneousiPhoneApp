//
//  LoginViewController.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-13.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)back:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
	//self.emailOrUsername.text
}
@end
