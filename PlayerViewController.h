//
//  PlayerViewController.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongTableView.h"
#import "SelectSongsViewController.h"
#import "PlayerView.h"
#import "Playlist.h"
@interface PlayerViewController : UIViewController<PassInformation>

-(IBAction)pickMoreSongs;
@property Playlist* playlist;
@property SongTableView* songTableView;
@property PlayerView* playerView;
+ (PlayerViewController*) sharedPlayerViewController;
@end
