//
//  MPMediaItemSubclass.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-24.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MediaItem : NSObject
@property NSString* user;
@property NSArray* peersThatHaveMedia;
@property MPMediaItem* localMediaItem;
@property NSString* type;
@property UIImage* image;
-(NSDictionary*)cloneForSerialize;
@end
