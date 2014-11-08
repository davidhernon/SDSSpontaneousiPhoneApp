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

@interface PlayerView : UIView<AVAudioPlayerDelegate, NSStreamDelegate>
@property Playlist* playlist;
@property NSOutputStream* audioOutputStream;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@property MPMediaItem* currentMPMediaItem;
@property (strong, nonatomic) IBOutlet UILabel *songTitle;
@property (strong, nonatomic) IBOutlet UILabel *artistName;
-(void)nextSong;
- (IBAction)send:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *skipButton;
@property (strong, nonatomic) IBOutlet UIImageView *albumArt;
@property (strong, nonatomic) IBOutlet UIButton *reverseButton;

-(id)init: (CGRect)frame;
- (IBAction)skip:(id)sender;
-(IBAction)reverse:(id)sender;
@end
