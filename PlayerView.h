//
//  PlayerView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Playlist.h"
@interface PlayerView : UIView<AVAudioPlayerDelegate>
@property Playlist* playlist;
@property (strong, nonatomic) AVPlayer *audioPlayer;
-(id)init: (CGRect)frame;
@end
