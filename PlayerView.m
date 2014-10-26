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
	return self;
}

-(void)startPlayer{
	self.audioPlayer = [[AVPlayer alloc] init];
	MPMediaItemSubclass *songWithMetadata = [[Playlist sharedPlaylist].playlist objectAtIndex:0];
	AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[songWithMetadata.song valueForProperty:MPMediaItemPropertyAssetURL]];
	[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
	[self.audioPlayer play];
	NSLog(@"play");

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
