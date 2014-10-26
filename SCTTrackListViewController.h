//
//  SCTTrackListTableViewController.h
//  SDSIPhoneApp
//
//  Created by David Hernon on 10/24/14.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SCTTrackListViewController : UITableViewController
<AVAudioPlayerDelegate>

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) AVAudioPlayer *player;

@end
