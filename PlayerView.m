//
//  PlayerView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-19.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

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
		self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"320x480.jpg"]];
		self.currentSongIndex = 0;
		[self prepareAudioSession];
		[self loadAndPlayPlayer];
	}
	return self;
}

// Plays Next Item
-(void)itemDidFinishPlaying:(NSNotification *) notification {
	self.currentSongIndex++;
	[self loadAndPlayPlayer];
}

//Set Index, then call this method
-(void)loadAndPlayPlayer{
	//return if empty
	if([[Playlist sharedPlaylist].playlist count] == 0 || [Playlist sharedPlaylist].playlist  == nil || [[Playlist sharedPlaylist].playlist count] == self.currentSongIndex){
		return;
	}
	if(self.currentSongIndex < 0){
		self.currentSongIndex = (int)[Playlist sharedPlaylist].playlist.count - 1;
	}
	else if (self.currentSongIndex >= [Playlist sharedPlaylist].playlist.count){
		self.currentSongIndex = 0;
	}
	MediaItem *mediaItem = [[Playlist sharedPlaylist].playlist objectAtIndex:self.currentSongIndex];
	self.songTitle.text = [mediaItem.localMediaItem valueForProperty:MPMediaItemPropertyTitle];
	self.artistName.text = [mediaItem.localMediaItem valueForProperty:MPMediaItemPropertyArtist];
	
	MPMediaItemArtwork *artWork = [mediaItem.localMediaItem valueForProperty:MPMediaItemPropertyArtwork];
	UIImage *albumArtworkImage = NULL;
	if (artWork != nil) {
		albumArtworkImage = [artWork imageWithSize:CGSizeMake(250.0, 250.0)];
	}
	if (albumArtworkImage) {
		self.albumArt.image = albumArtworkImage;
	}
	else{
		NSLog(@"No ALBUM ARTWORK");
		self.albumArt.image = [UIImage imageNamed:@"logos-02.png"];
	}

	AVPlayerItem * currentItem = [AVPlayerItem playerItemWithURL:[mediaItem.localMediaItem valueForProperty:MPMediaItemPropertyAssetURL]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:currentItem];
	[self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
	[self.audioPlayer play];
}

- (IBAction)nextSong:(id)sender {
	self.currentSongIndex++;
	[self loadAndPlayPlayer];
}

- (IBAction)playPauseAction:(id)sender {
	if(self.audioPlayer.rate == 0.0f){
		self.audioPlayer.rate = 1.0f;
		self.playPause.selected = NO;
	}
	else{
		self.audioPlayer.rate = 0.0f;
		self.playPause.selected = YES;
	}
}

- (IBAction)previousSong:(id)sender {
	if(CMTimeGetSeconds(self.audioPlayer.currentTime) < 2.0f){
		self.currentSongIndex--;
		[self loadAndPlayPlayer];
	}
	[self.audioPlayer seekToTime:CMTimeMake(0,1000)];
}

-(void)shuffle{
	[[Playlist sharedPlaylist] shuffle];
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

-(void) prepareAudioSession{
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
 
	NSError *setCategoryError = nil;
	BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
	if (!success) { /* handle the error condition */ }
 
	NSError *activationError = nil;
	success = [audioSession setActive:YES error:&activationError];
	if (!success) { /* handle the error condition */ }
}
@end
