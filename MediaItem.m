//
//  MPMediaItemSubclass.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-24.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "MediaItem.h"

@implementation MediaItem
-(id)init{
	self.localMediaItem = [[MPMediaItem alloc]init];
	self.user = @"NotSet";
	return self;
}
-(MediaItem*)cloneForSerialize
{
    MediaItem* lightClone = [[MediaItem alloc] init];
    lightClone.user = self.user;
    lightClone.peersThatHaveMedia = self.peersThatHaveMedia;
    lightClone.localMediaItem = nil;
    lightClone.type = self.type;
    lightClone.image = self.image;
    return lightClone;
}

@end

@protocol MediaItemProtocol
- (BOOL)isType:(NSString *)type;

@end


