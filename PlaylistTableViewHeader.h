//
//  PlaylistTableViewHeader.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerViewController.h"
@interface PlaylistTableViewHeader : UIView
- (IBAction)NowPlaying:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *SharedPlaylistLabel;
@end
