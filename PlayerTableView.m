//
//  PlayerTableView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-25.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlayerTableView.h"

@implementation PlayerTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithPlaylist: (CGRect)frame
{
	self = [super initWithFrame:frame];
	self.parentIsPlayerViewController = true;
	self.delegate = self;
	self.dataSource = self;
	
	self.playlist = [Playlist sharedPlaylist].playlist;
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
	NSString *artistLabel = [self->songWithMetaData.song valueForProperty: MPMediaItemPropertyArtist] ;
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = artistLabel;
	cell.imageView.image = self->songWithMetaData.image;
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	MPMediaItemSubclass *objToMove = [Playlist sharedPlaylist].playlist[sourceIndexPath.row];
	[[Playlist sharedPlaylist].playlist removeObjectAtIndex:sourceIndexPath.row];
	[[Playlist sharedPlaylist].playlist insertObject:objToMove atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[Playlist sharedPlaylist].playlist removeObjectAtIndex:indexPath.row];
		[self reloadData];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0){
		return 1;
	}
	else{
		return self.playlist.count - 1;
	}
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 0){
		return @"Now Playing";
	}
	if(section == 1){
		return @"Up Next";
	}
	return @"something terrible has happened";
}

@end
