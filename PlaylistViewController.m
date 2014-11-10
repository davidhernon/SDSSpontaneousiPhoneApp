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

- (void)viewDidLoad {
    [super viewDidLoad];
	//init playlist table
	self.playlist = [Playlist sharedPlaylist];
	[self.tableView reloadData];
    // TODO: make sure I send over the playlist data to person 2
	//[self addSubview:[[PlaylistTableViewHeader alloc]initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)]];
	//[window makeKeyAndVisible];

	//[self.playerView nextSong];
	
}

- (IBAction)pickMoreSongs
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

/*-(void)addTracktoTable:(MediaItem*)passedSong
{
    [self.playlist.playlist addObject:passedSong];
    // TODO:make sure bullshit
}*/


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MusicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell){
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: cellIdentifier];
	}
	
	self.songWithMetaData = [self.playlist.playlist objectAtIndex:indexPath.row];
	NSString *songTitle = [self.songWithMetaData.localMediaItem valueForProperty: MPMediaItemPropertyTitle];
	NSString *artistLabel = [self.songWithMetaData.localMediaItem valueForProperty: MPMediaItemPropertyArtist] ;
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = artistLabel;
	cell.imageView.image = self.songWithMetaData.image;
	return cell;
}

#pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	MediaItem *objToMove = [Playlist sharedPlaylist].playlist[sourceIndexPath.row];
	[[Playlist sharedPlaylist].playlist removeObjectAtIndex:sourceIndexPath.row];
	[[Playlist sharedPlaylist].playlist insertObject:objToMove atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[Playlist sharedPlaylist].playlist removeObjectAtIndex:indexPath.row];
		[self.tableView reloadData];
        // TODO: send over playlist data to other person?
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.playlist.playlist.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end