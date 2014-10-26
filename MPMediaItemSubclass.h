//
//  MPMediaItemSubclass.h
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-24.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MPMediaItemSubclass : NSObject
@property NSString* user;
@property UIColor* color;
@property MPMediaItem* song;
@end
