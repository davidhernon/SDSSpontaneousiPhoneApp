//
//  PlaylistViewController2.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"
#import "PlaylistTableView.h"

@interface PlaylistViewController2 : UIViewController
@property (strong, nonatomic) IBOutlet PlaylistTableView *playlistTableView;
@end
