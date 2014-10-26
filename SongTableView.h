//
//  SongTableView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-18.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SelectSongsViewController.h"
#import "Playlist.h"
#import "MPMediaItemSubclass.h"

@interface SongTableView : UITableView<UITableViewDataSource, UITableViewDelegate>{
	MPMediaItemSubclass *songWithMetaData;
}
@property (strong, nonatomic) NSMutableArray *playlist;
@property Boolean parentIsPlayerViewController;
@property Boolean needToSpoof;
-(id)init: (CGRect)frame;
-(void)addTracktoTable:(MPMediaItemSubclass*)passedSong;
-(id)initSongsListFromMediaQuery: (CGRect)frame;
-(id)initWithPlaylist: (CGRect)frame;
-(void)addToPlaylist;
@end
