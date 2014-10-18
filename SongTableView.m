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
-(void)initializeSongsList
{
	// Set up songs in table View and display it
	self.delegate = self;
	self.dataSource = self;
	MPMediaQuery *mediaPlayer = [[MPMediaQuery alloc] init];

	NSArray *itemsFromMediaPlayer = [mediaPlayer items];

	self.songsList = [NSMutableArray arrayWithArray:itemsFromMediaPlayer];
	NSLog(@"4");
	NSLog(@"%@", [[self.songsList objectAtIndex:0] valueForProperty: MPMediaItemPropertyTitle]);
	[self reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"typethisstuff");

	return self.songsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MusicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	NSLog(@"5");

	if (!cell){
		NSLog(@"6");
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
	}
	
	self->song = [self.songsList objectAtIndex:indexPath.row];
	NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
	NSString *durationLabel = [song valueForProperty: MPMediaItemPropertyGenre];
	cell.textLabel.text = songTitle;
	cell.detailTextLabel.text = durationLabel;
	return cell;
}

#pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self->song = [self.songsList objectAtIndex:indexPath.row];
	//[[self delegate] setTrack:self->song];
	//
	//[self.navigationController popViewControllerAnimated:YES];
}

@end
