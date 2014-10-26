//
//  Playlist.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MPMediaItemSubclass.h"
@interface Playlist : NSObject{
	NSMutableArray* playlist;
}
@property(nonatomic,retain)NSMutableArray *playlist;
+ (Playlist*) sharedPlaylist;
-(int)count;
- (void) addTrack:(MPMediaItemSubclass *)song;
- (id)objectAtIndex:(NSUInteger)index;

@end
