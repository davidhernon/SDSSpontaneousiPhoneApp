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
	self.playlist = [Playlist sharedPlaylist];
	[self initializePlayer];
	[self createUI];
	return self;
}
-(void)createUI{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self
			   action:@selector(play)
	 forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"Play Button" forState:UIControlStateNormal];
	button.frame = CGRectMake(0.0, 10.0, 160.0, 40.0);
	[self addSubview:button];
}

-(void)play{
	MPMediaItem *song = [self.playlist objectAtIndex:0];
	AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[song valueForProperty:MPMediaItemPropertyAssetURL]];
	[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
	[self.audioPlayer play];
	NSLog(@"play");
}
-(void)initializePlayer{
	self.audioPlayer = [[AVPlayer alloc] init];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
