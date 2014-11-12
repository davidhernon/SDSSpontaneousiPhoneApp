//
//  PlaylistViewController.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"
#import "PlaylistTableView.h"
#import "PlayerViewController.h"

@interface PlaylistViewController : UIViewController
@property (strong, nonatomic) IBOutlet PlaylistTableView *playlistTableView;
@property PlayerViewController *playerViewController;
@end
