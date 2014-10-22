//
//  SongTableView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-18.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>

@protocol PassInformation <NSObject>
-(void) addTrack:(MPMediaItem*)song;
@end

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SelectSongsViewController.h"
#import "Playlist.h"

@interface SongTableView : UITableView<UITableViewDataSource, UITableViewDelegate>{
	MPMediaItem *song;
}
@property (strong, nonatomic) NSMutableArray *playlist;
@property (nonatomic, unsafe_unretained) id<PassInformation> passInfoDelegate;
@property Boolean parentIsPlayerViewController;
-(id)init: (CGRect)frame;
-(void)addTracktoTable:(MPMediaItem*)passedSong;
-(id)initSongsListFromMediaQuery: (CGRect)frame;
-(id)initWithPlaylist: (CGRect)frame;

@end
