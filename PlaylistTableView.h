//
//  PlayerTableView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-25.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Playlist.h"
#import "MPMediaItemSubclass.h"

@interface PlaylistTableView : UITableView<UITableViewDataSource, UITableViewDelegate>{
	MPMediaItemSubclass *songWithMetaData;
}
@property (strong, nonatomic) NSMutableArray *playlist;
-(void)addTracktoTable:(MPMediaItemSubclass*)passedSong;
-(id)init: (CGRect)frame;
@end
