//
//  PlaylistViewController.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"

@interface PlaylistViewController : UITableViewController
@property Playlist* playlist;
@property MediaItem *songWithMetaData;
@property (strong, nonatomic) IBOutlet UIButton *editPlaylist;
-(IBAction)pickMoreSongs;

@end
