//
//  SelectASongTableView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-25.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "SelectASongTableView.h"

@implementation SelectASongTableView

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
		NSIndexPath *loopPath = [NSIndexPath indexPathForRow:j inSection:1];
		MPMediaItemSubclass *s = [[MPMediaItemSubclass alloc]init];
		s.song = [tempPlaylist objectAtIndex:loopPath.row];
		[self.playlist addObject:s];
		
		//Spoof Barbs Songs//
		if((j==4 || j ==16) && ![Playlist sharedPlaylist].alreadySpoofed){
			MPMediaItemSubclass *s2 = [[MPMediaItemSubclass alloc]init];
			s2.song = [tempPlaylist objectAtIndex:loopPath.row];
			s2.user = @"Barb";
			s2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"profile_default" ofType:@"png"]];
			[[Playlist sharedPlaylist].playlist addObject:s2];
			if(j==16){
				[Playlist sharedPlaylist].alreadySpoofed = true;
			}
		}
		
		//end spoof//
	}
	
	
	[self reloadData];
	return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MusicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell){
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: cellIdentifier];
	}
	
	self->songWithMetaData = [self.playlist objectAtIndex:indexPath.row];
	NSString *songTitle = [self->songWithMetaData.song valueForProperty: MPMediaItemPropertyTitle];
	NSString *artistLabel = [self->songWithMetaData.song valueForProperty: MPMediaItemPropertyArtist];
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = artistLabel;
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.playlist.count;
}


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
			s.user = @"You";
			s.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Uncle_Sam_(pointing_finger)" ofType:@"jpg"]];

			[[Playlist sharedPlaylist].playlist addObject:s];
			[self cellForRowAtIndexPath:loopPath].accessoryType = UITableViewCellAccessoryNone;
		}
	}
}

@end
