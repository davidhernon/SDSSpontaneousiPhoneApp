//
//  Playlist.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MediaItem.h"
@interface Playlist : NSObject{
	NSMutableArray* playlist;
}
@property(nonatomic,retain)NSMutableArray *playlist;
@property Boolean alreadySpoofed;
+ (Playlist*) sharedPlaylist;
- (int)count;
- (void) addTrack:(MediaItem *)mediaItem;
- (id)objectAtIndex:(NSUInteger)index;
- (void)shuffle;
- (void) addMediaCollection:(MPMediaItemCollection*)collection;
@end
