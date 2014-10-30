//
//  PlayerViewController.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/11/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistTableView.h"
#import "PlayerView.h"
#import "Playlist.h"
@interface PlayerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *editPlaylist;
- (IBAction)Skip:(id)sender;

-(IBAction)pickMoreSongs;
@property Playlist* playlist;
@property PlaylistTableView* playlistTableView;
@property PlayerView* playerView;
+ (PlayerViewController*) sharedPlayerViewController;
@end
