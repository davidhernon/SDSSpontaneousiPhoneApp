//
//  SongTableView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-18.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface SongTableView : UITableView<UITableViewDataSource, UITableViewDelegate>{
	MPMediaItem *song;
}
@property (strong, nonatomic) NSMutableArray *songsList;
-(void)initializeSongsList;
@end
