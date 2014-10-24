//
//  SongTableView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-18.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "SongTableView.h"

@implementation SongTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initSongsListFromMediaQuery: (CGRect)frame
{
	self = [super initWithFrame:frame];
	// Set up songs in table View and display it
	self.parentIsPlayerViewController = false;
	self.delegate = self;
	self.dataSource = self;
	MPMediaQuery *mediaPlayer = [[MPMediaQuery alloc] init];
	NSArray *itemsFromMediaPlayer = [mediaPlayer items];
	self.playlist = [[NSMutableArray alloc]init];
	self.playlist = [NSMutableArray arrayWithArray:itemsFromMediaPlayer];
	[self reloadData];
	return self;
}

-(id)initWithPlaylist: (CGRect)frame
{
	self = [super initWithFrame:frame];
	self.parentIsPlayerViewController = true;
	self.delegate = self;
	self.dataSource = self;
	self.playlist = [Playlist sharedPlaylist].playlist;
	return self;
}


-(id)init: (CGRect)frame
{
	self = [super initWithFrame:frame];
	self.delegate = self;
	self.dataSource = self;
	self.playlist = [[NSMutableArray alloc]init];
	return self;
}

-(void)addTracktoTable:(MPMediaItem*)passedSong
{
	[self.playlist addObject:passedSong];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.playlist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MusicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	if (!cell){
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
	}
	
	self->song = [self.playlist objectAtIndex:indexPath.row];
	NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
	NSString *durationLabel = [song valueForProperty: MPMediaItemPropertyGenre];
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = durationLabel;
	return cell;
}

#pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(self.parentIsPlayerViewController){
	
	}
	else{
		[[Playlist sharedPlaylist].playlist addObject:[self.playlist objectAtIndex:indexPath.row]];
	}
}

@end
