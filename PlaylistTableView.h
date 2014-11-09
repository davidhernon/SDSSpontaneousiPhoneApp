//
//  PlaylistTableView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"

@interface PlaylistTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
@property MediaItem* songWithMetaData;
@end
