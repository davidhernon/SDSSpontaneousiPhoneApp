//
//  PlaylistViewController.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlaylistViewController.h"

@interface PlaylistViewController ()

@end

@implementation PlaylistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)nowPlaying
{
	PlayerViewController *playerViewController = [[PlayerViewController alloc]initWithNibName:@"PlayerViewController" bundle:nil];
	self.navigationController.navigationBarHidden = FALSE;
	playerViewController.navigationItem.hidesBackButton = YES;
	playerViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:playerViewController action:@selector(hideNavBar)];
	[self.navigationController pushViewController:playerViewController animated:YES];
}

/*- (IBAction)pickMoreSongs
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)editPlaylist:(id)sender{
	if(self.tableView.editing == NO){
		self.tableView.editing = YES;
	}
	else{
		self.tableView.editing = NO;
	}
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
