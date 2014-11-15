/*
 * Copyright 2014 shrtlist.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "SessionController.h"

@interface SessionController () // Class extension
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCNearbyServiceAdvertiser *serviceAdvertiser;
@property (nonatomic, strong) MCNearbyServiceBrowser *serviceBrowser;

// Connected peers are stored in the MCSession
// Manually track connecting and disconnected peers
@property (nonatomic, strong) NSMutableOrderedSet *connectingPeersOrderedSet;
@property (nonatomic, strong) NSMutableOrderedSet *disconnectedPeersOrderedSet;

@end

@implementation SessionController

static NSString * const kMCSessionServiceType = @"mcsessionp2p";

#pragma mark - Initializer

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _peerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
        
        _connectingPeersOrderedSet = [[NSMutableOrderedSet alloc] init];
        _disconnectedPeersOrderedSet = [[NSMutableOrderedSet alloc] init];
        
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        
        // Register for notifications
        [defaultCenter addObserver:self
                          selector:@selector(startServices)
                              name:UIApplicationWillEnterForegroundNotification
                            object:nil];
        
        [defaultCenter addObserver:self
                          selector:@selector(stopServices)
                              name:UIApplicationDidEnterBackgroundNotification
                            object:nil];
        
        [self startServices];

        _displayName = self.session.myPeerID.displayName;
    }
    
    return self;
}

#pragma mark - Memory management

- (void)dealloc
{
    // Unregister for notifications on deallocation.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Nil out delegates
    _session.delegate = nil;
    _serviceAdvertiser.delegate = nil;
    _serviceBrowser.delegate = nil;
}

#pragma mark - Override property accessors

- (NSArray *)connectedPeers
{
    return self.session.connectedPeers;
}

- (NSArray *)connectingPeers
{
    return [self.connectingPeersOrderedSet array];
}

- (NSArray *)disconnectedPeers
{
    return [self.disconnectedPeersOrderedSet array];
}



#pragma mark - Private methods

- (void)setupSession
{
    // Create the session that peers will be invited/join into.
    _session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    
    // Create the service advertiser
    _serviceAdvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID
                                                           discoveryInfo:nil
                                                             serviceType:kMCSessionServiceType];
    self.serviceAdvertiser.delegate = self;
    
    // Create the service browser
    _serviceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID
                                                       serviceType:kMCSessionServiceType];
    self.serviceBrowser.delegate = self;
}

- (void)teardownSession
{
    [self.session disconnect];
    [self.connectingPeersOrderedSet removeAllObjects];
    [self.disconnectedPeersOrderedSet removeAllObjects];
}

- (void)startServices
{
    [self setupSession];
    [self.serviceAdvertiser startAdvertisingPeer];
    [self.serviceBrowser startBrowsingForPeers];
}

- (void)stopServices
{
    [self.serviceBrowser stopBrowsingForPeers];
    [self.serviceAdvertiser stopAdvertisingPeer];
    [self teardownSession];
}

- (void)updateDelegate
{    
    [self.delegate sessionDidChangeState];
}

- (NSString *)stringForPeerConnectionState:(MCSessionState)state
{
    switch (state) {
        case MCSessionStateConnected:
            return @"Connected";
            
        case MCSessionStateConnecting:
            return @"Connecting";
            
        case MCSessionStateNotConnected:
            return @"Not Connected";
    }
}

#pragma mark - MCSessionDelegate protocol conformance

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    NSLog(@"Peer [%@] changed state to %@", peerID.displayName, [self stringForPeerConnectionState:state]);
    
    switch (state)
    {
        case MCSessionStateConnecting:
        {
            [self.connectingPeersOrderedSet addObject:peerID];
            [self.disconnectedPeersOrderedSet removeObject:peerID];
            break;
        }
            
        case MCSessionStateConnected:
        {
            [self.connectingPeersOrderedSet removeObject:peerID];
            [self.disconnectedPeersOrderedSet removeObject:peerID];
            break;
        }
            
        case MCSessionStateNotConnected:
        {
            [self.connectingPeersOrderedSet removeObject:peerID];
            [self.disconnectedPeersOrderedSet addObject:peerID];
            break;
        }
    }
    
    [self updateDelegate];
}

// DEPRECATED: Old didReceiveData method
/*
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    // Decode the incoming data to a UTF8 encoded string
    NSString *receivedMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"didReceiveData %@ from %@", receivedMessage, peerID.displayName);
}*/

// CURRENT didReceiveData method
// replaces DEPRECATED version above^
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    /*NSError* error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data   options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
    if(error || jsonDict == nil){
        NSLog(@"[ERROR] Networking.SessionController.session.didReceiveCallback - did not reconstruct JSON data from peer, %@", error);
    }
    NSLog(@"[INFO] Networking.SessionController.session.didReceiveCallback - reconstructed JSON data from peer: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //do Something with jsonDict
    // set jsonDict to sharedPlaylist
    [[Playlist sharedPlaylist] addTrack:[[MediaItem alloc] initWithDictionary:jsonDict]];*/
    NSString* newStr = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"From the peer: %@", newStr);
    
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    NSLog(@"didStartReceivingResourceWithName [%@] from %@ with progress [%@]", resourceName, peerID.displayName, progress);
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    NSLog(@"didFinishReceivingResourceWithName [%@] from %@", resourceName, peerID.displayName);
    
    // If error is not nil something went wrong
    if (error)
    {
        NSLog(@"Error [%@] receiving resource from %@ ", [error localizedDescription], peerID.displayName);
    }
    else
    {
        // No error so this is a completed transfer.  The resources is located in a temporary location and should be copied to a permenant location immediately.
        // Write to documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *copyPath = [NSString stringWithFormat:@"%@/%@", [paths firstObject], resourceName];
        if (![[NSFileManager defaultManager] copyItemAtPath:[localURL path] toPath:copyPath error:nil])
        {
            NSLog(@"Error copying resource to documents directory");
        }
        else
        {
            // Get a URL for the path we just copied the resource to
            NSURL *url = [NSURL fileURLWithPath:copyPath];
            NSLog(@"url = %@", url);
        }
    }
}

// Streaming API not utilized in this sample code
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    NSLog(@"didReceiveStream %@ from %@", streamName, peerID.displayName);
	//[/*name of NSData*/ writeToFile:/*save file path*/ atomically: YES];
	//NSURL *filepath = [NSURL fileURLWithPath:/*save file path*/];
	//AVPlayerItem *player = [AVPlayerItem playerItemWithURL:filepath];

}

#pragma mark - MCNearbyServiceBrowserDelegate protocol conformance

// Found a nearby advertising peer
- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    NSString *remotePeerName = peerID.displayName;
    
    NSLog(@"Browser found %@", remotePeerName);
    
    MCPeerID *myPeerID = self.session.myPeerID;
    
    BOOL shouldInvite = ([myPeerID.displayName compare:remotePeerName] == NSOrderedDescending);
    
    if (shouldInvite)
    {
        NSLog(@"Inviting %@", remotePeerName);
        [browser invitePeer:peerID toSession:self.session withContext:nil timeout:30.0];
    }
    else
    {
        NSLog(@"Not inviting %@", remotePeerName);
    }
    
    [self updateDelegate];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    NSLog(@"lostPeer %@", peerID.displayName);
    
    [self.connectingPeersOrderedSet removeObject:peerID];
    [self.disconnectedPeersOrderedSet addObject:peerID];
    
    [self updateDelegate];
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    NSLog(@"didNotStartBrowsingForPeers: %@", error);
}

#pragma mark - MCNearbyServiceAdvertiserDelegate protocol conformance

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
    NSLog(@"didReceiveInvitationFromPeer %@", peerID.displayName);
    
    invitationHandler(YES, self.session);
    
    [self.connectingPeersOrderedSet addObject:peerID];
    [self.disconnectedPeersOrderedSet removeObject:peerID];
    
    [self updateDelegate];
}



- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error
{
    NSLog(@"didNotStartAdvertisingForPeers: %@", error);
}

/*- (void)sendPlaylistAsJSON:(NSArray *)myArray
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //MCSession * s = session;
    //MCSession * s = [self returnSession];
    //NSLOG(s.toString);
    [[self returnSession] sendData:jsonData toPeers:[[self returnSession] connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    NSLog(@"Sending Playlist as JSON: %@", jsonString);
}

- (void)sendPlaylistWithPeersAsJSON:(NSArray *)twoDArrayOfPeers withSongStrings:(NSArray *)songStrings
{
    //create Dictionary Object
    NSDictionary *dictionary = [self createDictionaryFromSongListAndPeers:twoDArrayOfPeers withSongStrings:songStrings];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    [self.session sendData:jsonData toPeers:[self.session connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    
}

- (NSDictionary *)createDictionaryFromSongListAndPeers:(NSArray *)twoDArrayOfPeers withSongStrings:(NSArray *)songStrings
{
    // create a dictionary
    // keys: Song String
    // Values: NSArray of Peers (NSUIntegers)
    NSDictionary *dictSongsToPeers = [[NSDictionary alloc] init];
    //create dictionary properly
    return dictSongsToPeers;
    
}

- (MCSession *) returnSession
{
    return self.session;
}*/

-(NSMutableDictionary *)playListToDictionary
{
    NSMutableDictionary * playListDictionary = [[NSMutableDictionary alloc] initWithCapacity:[Playlist sharedPlaylist].count];
    for(int i=0; i < [[Playlist sharedPlaylist] count]; i++){
        [playListDictionary setObject:[[Playlist sharedPlaylist].playlist[i] cloneForSerialize] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    NSLog(@"Song Count in Dictionary, %lu", [playListDictionary count]);
    return playListDictionary;
}

-(NSData*)dictionaryToJSONData:(NSDictionary *)dict
{
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if(!jsonData){
        NSLog(@"[ERROR] UIAndPlayer.PlayerView.dictionaryToJSONData - tried to convert dictionary to jsonData but got error: %@", error);
    }
    return jsonData;
}

-(void)sendPlayListToPeers
{
    NSData* data = [self dictionaryToJSONData: [self playListToDictionary]];
    NSError* error;
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    MCSession* currentSession = self.session;
    [currentSession sendData:data toPeers:[currentSession connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    
    if(error){
        NSLog(@"[ERROR] UIAndPlayer.PlayerView.sendPlayListToPeers - sent data to session via AppDelegate but received error: %@", error);
    }
    NSLog(@"[INFO] UIAndPlayer.PlayerView.sendPlayListToPeers - converted playlist to data and sent it successfully. JSON String was: %@", jsonString);
}

- (void) addDictionaryToPlaylist:(NSDictionary*)dict
{
    NSMutableDictionary * currentDict = [[NSMutableDictionary alloc] init];
    for(int i=0; i< [dict count]; i++){
        currentDict = [dict objectForKey:[NSString stringWithFormat:@"%d",i]];
        //create new MediaItem and add it in
        MediaItem *newSong = [[MediaItem alloc] initWithDictionary:currentDict];
        [[Playlist sharedPlaylist] addTrack:newSong];
    }
}

- (void) sendTestString
{
    NSString *s = [[NSString alloc] init];
    s = @"test";
    NSError *error;
    NSData *d = [s dataUsingEncoding:NSUTF8StringEncoding];
    MCSession* currentSession = self.session;
    NSString* jsonString = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    [currentSession sendData:d toPeers:[currentSession connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    if(error){
        NSLog(@"[ERROR] UIAndPlayer.PlayerView.sendTestString - sent data to session via AppDelegate but received error: %@", error);
    }
    NSLog(@"[INFO] UIAndPlayer.PlayerView.sendTEstString - converted playlist to data and sent it successfully. JSON String was: %@", jsonString);

}





@end
