//
//  PlayerView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView
-(id)init: (CGRect)frame 
{
	self = [super initWithFrame:frame];
	[self startPlayer];
	[self initializeUI];
	return self;
}

-(void) initializeUI{
	UIButton *skip = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
	skip.titleLabel.text = @"Skip";
	[skip setFrame:CGRectMake(20, 20, 100, 50)];
	[skip addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)skip{
	NSLog(@"button was clicked");

}

-(void)startPlayer{
	self.audioPlayer = [[AVPlayer alloc] init];
	MPMediaItemSubclass *songWithMetadata = [[Playlist sharedPlaylist].playlist objectAtIndex:0];
	AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[songWithMetadata.song valueForProperty:MPMediaItemPropertyAssetURL]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:currentItem];
	[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
	[self.audioPlayer play];
}

// Plays Next Item
-(void)itemDidFinishPlaying:(NSNotification *) notification {
	[[Playlist sharedPlaylist].playlist removeObjectAtIndex:0];
	MPMediaItemSubclass *songWithMetadata = [[Playlist sharedPlaylist].playlist objectAtIndex:0];
	AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[songWithMetadata.song valueForProperty:MPMediaItemPropertyAssetURL]];
	[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
	[self.audioPlayer play];
}

@end
