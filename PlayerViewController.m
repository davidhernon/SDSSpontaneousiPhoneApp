//
//  PlayerViewController.m
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//
#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.view =[[PlayerView alloc] init:CGRectMake(0.0,0.0,0.0,0.0)];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)hideNavBar{
	self.navigationController.navigationBarHidden = TRUE;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
