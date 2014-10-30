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
	
		//init playlist table
		self.playlist = [Playlist sharedPlaylist];
		self.playlistTableView = [[PlaylistTableView alloc] init:CGRectMake(0.0,130.0, 320.0, 300.0)];
		[self.view addSubview:self.playlistTableView];
		[self.view sendSubviewToBack:self.playlistTableView];
		
		//init player
		self.playerView = [[PlayerView alloc] init:CGRectMake(0.0,25.0,320.0,100.0)];
		[self.view addSubview:self.playerView];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.playlistTableView reloadData];
}

-(void)reloadData{
	[self.playlistTableView reloadData];
}

-(void)shuffle{
	[[Playlist sharedPlaylist] shuffle];
}
-(IBAction)editPlaylist:(id)sender{
	if(self.playlistTableView.editing == NO){
		self.playlistTableView.editing = YES;
	}
	else{
		self.playlistTableView.editing = NO;
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Skip:(id)sender {
	[self.playerView skip];
}

- (IBAction)pickMoreSongs
{
	[self dismissModalViewControllerAnimated:YES];
}


@end
