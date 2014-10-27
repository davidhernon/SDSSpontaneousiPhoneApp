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

+ sharedPlayerViewController
{
	static PlayerViewController *sharedPlayerViewController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlayerViewController = [[self alloc] initWithNibName:@"PlayerViewController" bundle:nil];
	});
	return sharedPlayerViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.playlist = [Playlist sharedPlaylist];
		self.playerTableView = [[PlayerTableView alloc] initWithPlaylist:CGRectMake(0.0,130.0, 320.0, 300.0)];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"viewdidload");
	[self.view addSubview:self.playerTableView];
	[self.view sendSubviewToBack:self.playerTableView];
	[[Playlist sharedPlaylist] shuffle];
	self.playerView = [[PlayerView alloc] init:CGRectMake(0.0,25.0,320.0,100.0)];
	[self.view addSubview:self.playerView];
	[self.playerTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)reloadData{
	[self.playerTableView reloadData];
}

-(IBAction)editPlaylist:(id)sender{
	if(self.playerTableView.editing == NO){
		self.playerTableView.editing = YES;
	}
	else{
		self.playerTableView.editing = NO;
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickMoreSongs
{
	[self dismissModalViewControllerAnimated:YES];
}


@end
