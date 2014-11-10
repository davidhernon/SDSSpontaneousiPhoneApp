//
//  PlayerView.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Appdelegate.h"
#import "Playlist.h"
//#import "SessionController.h"

@interface PlayerView : UIView<AVAudioPlayerDelegate, NSStreamDelegate>
@property Playlist* playlist;
@property NSOutputStream* audioOutputStream;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@property MPMediaItem* currentMPMediaItem;
@property int currentSongIndex;
@property (strong, nonatomic) IBOutlet UIButton *playPause;
@property (strong, nonatomic) IBOutlet UILabel *songTitle;
@property (strong, nonatomic) IBOutlet UILabel *artistName;
@property (strong, nonatomic) IBOutlet UIButton *skipButton;
@property (strong, nonatomic) IBOutlet UIImageView *albumArt;
- (IBAction)close:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)send:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)playPauseAction:(id)sender;
-(void)nextSong;
-(id)init: (CGRect)frame;
@end
