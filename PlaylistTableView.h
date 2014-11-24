//
//  PlaylistTableView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Playlist.h"
#import "AppDelegate.h"
#import "PlayerViewController.h"
@protocol pushPlayerVCDelegate;

@interface PlaylistTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<pushPlayerVCDelegate> delegate;
@property MediaItem* songWithMetaData;
@end

@protocol pushPlayerVCDelegate <NSObject>
- (void)pushPlayerVC:(NSIndexPath*)index;
@end
