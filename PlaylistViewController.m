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

//addMoreSongs from MediaPicker (Local)
- (IBAction)addMoreSongs:(id)sender {
	//if there's nothing in the media library, just skip to the player
	MPMediaQuery *everything = [MPMediaQuery songsQuery];
	if (everything.items == nil || [everything.items count] == 0){
		[self.navigationController pushViewController:self.playerViewController animated:YES];
	}
	
	//else, show a picker so they can give us songs
	MPMediaPickerController* picker = [[MPMediaPickerController alloc]initWithMediaTypes: MPMediaTypeAnyAudio];
	[picker setDelegate: self];                                         // 2
	[picker setAllowsPickingMultipleItems: YES];                        // 3
	picker.prompt =
	NSLocalizedString (@"Add songs to play",
					   "Prompt in media item picker");
	[self.navigationController pushViewController:picker animated: YES];    // 4
}

//Move to playerview, set navController status
- (IBAction)nowPlaying
{
	self.navigationController.navigationBarHidden = FALSE;
	self.playerViewController.navigationItem.hidesBackButton = YES;
	if(!self.playerViewController){
	   self.playerViewController = [[PlayerViewController alloc]initWithNibName:@"PlayerViewController" bundle:nil];
	}
	self.playerViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self.playerViewController action:@selector(hideNavBar)];
	[self.navigationController pushViewController:self.playerViewController animated:YES];
}

/*- (IBAction)pickMoreSongs
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)editPlaylist:(id)sender{
	if(self.tableView.editing == NO){
		self.tableView.editing = YES;
>>>>>>> origin/martin
	}
	else{
		self.tableView.editing = NO;
	}
}*/

//MediaPicker returns to Playlist after done picking
- (void) mediaPicker: (MPMediaPickerController *) mediaPicker
   didPickMediaItems: (MPMediaItemCollection *) collection {
	[[Playlist sharedPlaylist] addMediaCollection:collection];
	PlaylistViewController *playlistViewController = [[PlaylistViewController alloc]initWithNibName:@"PlaylistViewController" bundle:nil];
	[self.navigationController pushViewController:playlistViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
