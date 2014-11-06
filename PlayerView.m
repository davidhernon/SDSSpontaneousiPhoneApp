//
//  PlayerView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

// In MyView.m
- (id)init:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self = [[[NSBundle mainBundle] loadNibNamed:@"PlayerView"
											  owner:self
											options:nil] lastObject];
		[self setFrame:CGRectMake(frame.origin.x,
								  frame.origin.y,
								  [self frame].size.width,
								  [self frame].size.height)];
		self.audioPlayer = [[AVPlayer alloc] init];
		UIImage *btnImage = [UIImage imageNamed:@"150px-Fast_forward_font_awesome.png"];
		[self.skipButton setImage:btnImage forState:UIControlStateNormal];
		UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"320x480.jpg"]];
		self.backgroundColor = background;
		[self nextSong];
	}
	return self;
}

- (IBAction)skip:(id)sender {
	NSLog(@"skip was clicked");
	[self nextSong];
}

- (IBAction)send:(id)sender {

	//This line'll do file transfers
	//Boolean worked = [appDelegate.sessionController.session sendData:d toPeers:appDelegate.sessionController.connectedPeers withMode:MCSessionSendDataUnreliable error:nil];


	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Send a data message to a list of destination peers
	self.audioOutputStream = [appDelegate.sessionController.session startStreamWithName:appDelegate.sessionController.displayName toPeer:appDelegate.sessionController.connectedPeers[0] error:nil];

	self.audioOutputStream.delegate = self;
	NSData *d = [self convertToData:self.currentMPMediaItem];
}

-(NSData*)convertToData: (MPMediaItem*) item{
	
  // Get raw PCM data from the track
  NSURL *assetURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
  NSMutableData *data = [[NSMutableData alloc] init];
  
  const uint32_t sampleRate = 16000; // 16k sample/sec
  const uint16_t bitDepth = 16; // 16 bit/sample/channel
  const uint16_t channels = 2; // 2 channel/sample (stereo)
  
  NSDictionary *opts = [NSDictionary dictionary];
  AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:assetURL options:opts];
  AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:asset error:NULL];
  NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
							[NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
							[NSNumber numberWithFloat:(float)sampleRate], AVSampleRateKey,
							[NSNumber numberWithInt:bitDepth], AVLinearPCMBitDepthKey,
							[NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
							[NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey,
							[NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey, nil];
  
  AVAssetReaderTrackOutput *output = [[AVAssetReaderTrackOutput alloc] initWithTrack:[[asset tracks] objectAtIndex:0] outputSettings:settings];
  [reader addOutput:output];
  [reader startReading];
  
  // read the samples from the asset and append them subsequently
  while ([reader status] != AVAssetReaderStatusCompleted) {
	  CMSampleBufferRef sampleBuffer = [output copyNextSampleBuffer];
	  if (sampleBuffer == NULL) continue;
	  CMBlockBufferRef blockBuffer;
	  AudioBufferList audioBufferList;
	  
	  CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(sampleBuffer, NULL, &audioBufferList, sizeof(AudioBufferList), NULL, NULL, kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment, &blockBuffer);
	  
	  for (NSUInteger i = 0; i < audioBufferList.mNumberBuffers; i++) {
		  AudioBuffer audioBuffer = audioBufferList.mBuffers[i];
		  [self.audioOutputStream write:audioBuffer.mData maxLength:audioBuffer.mDataByteSize];
	  }
	  
	  CFRelease(blockBuffer);
	  CFRelease(sampleBuffer);
  }
  return data;
}

-(void)nextSong{
	if([[Playlist sharedPlaylist].playlist count] == 0 || [Playlist sharedPlaylist].playlist  == nil){
	}
	else{
		NSLog(@"NextSong");
		MPMediaItemSubclass *songWithMetadata = [[Playlist sharedPlaylist].playlist objectAtIndex:0];
		self.currentMPMediaItem = songWithMetadata.song;
		[[Playlist sharedPlaylist].playlist removeObjectAtIndex:0];
		self.songTitle.text = [songWithMetadata.song valueForProperty:MPMediaItemPropertyTitle];
		self.artistName.text = [songWithMetadata.song valueForProperty:MPMediaItemPropertyArtist];
		MPMediaItemArtwork *artWork = [songWithMetadata.song valueForProperty:MPMediaItemPropertyArtwork];
		//self.albumArt.image = [artWork imageWithSize:CGSizeMake(self.albumArt.frame.size.width, self.albumArt.frame.size.height)];
		
		if (CGSizeEqualToSize(artWork.bounds.size, CGSizeZero))
		{
			self.albumArt.image = [UIImage imageNamed:@"logos-02.png"];
		}
		else //Otherwise set the artwork found in the library.
		{
			self.albumArt.image = [artWork imageWithSize: CGSizeMake (self.albumArt.frame.size.width, self.albumArt.frame.size.height)];
		}

		AVPlayerItem *currentItem = [AVPlayerItem playerItemWithURL:[songWithMetadata.song valueForProperty:MPMediaItemPropertyAssetURL]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:currentItem];
		[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
		[self.audioPlayer play];
	}
}

// Plays Next Item
-(void)itemDidFinishPlaying:(NSNotification *) notification {
	[[Playlist sharedPlaylist].playlist removeObjectAtIndex:0];
	MPMediaItemSubclass *songWithMetadata = [[Playlist sharedPlaylist].playlist objectAtIndex:0];
	AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[songWithMetadata.song valueForProperty:MPMediaItemPropertyAssetURL]];
	[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
	[self.audioPlayer play];
}

@end
