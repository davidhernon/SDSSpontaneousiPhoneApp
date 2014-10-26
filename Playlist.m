//
//  Playlist.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist
@synthesize playlist;
static Playlist *sharedPlaylist = nil;

-(id)init{
	self=[super init];
	if(self){
	}
	return  self;
}

+ sharedPlaylist
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlaylist = [[self alloc] init];
		sharedPlaylist.playlist = [[NSMutableArray alloc]init];
		sharedPlaylist.alreadySpoofed = false;
	});
	return sharedPlaylist;
}

- (void) addTrack:(MPMediaItem *)song
{
	NSLog(@"added to Playlist");
	[self.playlist addObject:song];
}

- (int) count
{
	return self.playlist.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
	return [self.playlist objectAtIndex:index];
}

-(void)shuffle{
	NSUInteger count = [self.playlist count];
	for (NSUInteger i = 0; i < count; ++i) {
		NSInteger remainingCount = count - i;
		NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
		[self.playlist exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
	}
}


@end
