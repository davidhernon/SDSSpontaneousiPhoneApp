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
		//init player
		self.playerView =[[PlayerView alloc] init:CGRectMake(0.0,0.0,0.0,0.0)];
		[self.view addSubview:self.playerView];
		[self.view bringSubviewToFront:self.playerView];
		
	}
	return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)shuffle{
	[[Playlist sharedPlaylist] shuffle];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SessionControllerDelegate protocol conformance

- (void)sessionDidChangeState
{
	NSLog(@"session did change state");
	// Ensure UI updates occur on the main queue.
	//dispatch_async(dispatch_get_main_queue(), ^{
	//	[self.tableView reloadData];
	//});
}




@end
