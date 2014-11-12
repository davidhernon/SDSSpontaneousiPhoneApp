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

- (void) addTrack:(MPMediaItem *)mediaItem
{
	NSLog(@"added to Playlist");
	[self.playlist addObject:mediaItem];
    NSLog(@"[INFO] UIAndPlayer.PlaylistTableView.addTrack - adding track to shared Playlist");
    //TODO: send over playlist to peers
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
    // TODO:send over playlist to peers
}

-(void) addMediaCollection:(MPMediaItemCollection*)collection{
	for(MPMediaItem* track in collection.items){
		MediaItem* m = [[MediaItem alloc]init];
		m.localMediaItem = track;
		m.user = @"self";
		m.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Uncle_Sam_(pointing_finger)" ofType:@"jpg"]];
        NSLog(@"[INFO] UIAndPlayer.Playlist.addMediaCollection - adding track to shared Playlist");
		[self.playlist addObject:m];
        [[self getSessionController] sendPlayListToPeers];
	}
}

- (SessionController *)getSessionController
{
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.sessionController;
    
}



@end
