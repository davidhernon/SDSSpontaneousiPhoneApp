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
		self.songTableView = [[SongTableView alloc] initWithPlaylist:CGRectMake(0.0,200.0, 320.0, 300.0)];
		self.playerView = [[PlayerView alloc] init:CGRectMake(0.0,125.0,320.0,100.0)];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"viewdidload");
	[self.view addSubview:self.songTableView];
	[self.view sendSubviewToBack:self.songTableView];
	[self.view addSubview:self.playerView];
	[self.songTableView reloadData];

    // Do any additional setup after loading the view from its nib.
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
