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
	NSMutableArray *tempPlaylist = [[NSMutableArray alloc]init];
	tempPlaylist = [NSMutableArray arrayWithArray:itemsFromMediaPlayer];
	self.playlist = [[NSMutableArray alloc]init];
	
	for(NSUInteger j = 0 ; j < [tempPlaylist count] ; j++){
		NSIndexPath *loopPath = [NSIndexPath indexPathForRow:j inSection:0];
		MPMediaItemSubclass *s = [[MPMediaItemSubclass alloc]init];
		s.song = [tempPlaylist objectAtIndex:loopPath.row];
		s.color = [UIColor whiteColor];
		[self.playlist addObject:s];
	}

	
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

-(void)addTracktoTable:(MPMediaItemSubclass*)passedSong
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	//cell.backgroundColor = self->song.color;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MusicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	if (!cell){
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
	}
	
	self->songWithMetaData = [self.playlist objectAtIndex:indexPath.row];
	NSString *songTitle = [self->songWithMetaData.song valueForProperty: MPMediaItemPropertyTitle];
	NSString *durationLabel = [self->songWithMetaData.song valueForProperty: MPMediaItemPropertyGenre];
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = durationLabel;

	return cell;
}

#pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(self.parentIsPlayerViewController){
	
	}
	else{
		if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
			[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

		}else{
			[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
		}
	}
}


-(void)addToPlaylist{
	for(NSUInteger j = 0 ; j < [self.playlist count] ; j++){
		NSIndexPath *loopPath = [NSIndexPath indexPathForRow:j inSection:0];
		if([self cellForRowAtIndexPath:loopPath].accessoryType == UITableViewCellAccessoryCheckmark){
			MPMediaItemSubclass *s =[self.playlist objectAtIndex:loopPath.row];
			//[s setColor:[UIColor cyanColor]];
			//[s setUser: @"You"];
			[[Playlist sharedPlaylist].playlist addObject:s];
			[self cellForRowAtIndexPath:loopPath].accessoryType = UITableViewCellAccessoryNone;
		}
	}
}

@end
