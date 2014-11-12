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
    //TODO: update line below to reflect reality of peers
    self.peersThatHaveMedia = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], nil];
}
-(NSDictionary*)cloneForSerialize
{
    NSMutableDictionary* lightClone = [[NSMutableDictionary alloc] init];
    [lightClone setObject:self.user forKey:@"user"];
    // TODO: fix peer issues
   // [lightClone setObject:self.peersThatHaveMedia forKey:@"peers"];
    [lightClone setObject:@"FROM_PEER" forKey:@"type"];
    [lightClone setObject:[self.localMediaItem  valueForProperty:MPMediaItemPropertyTitle] forKey:@"songName"];
    [lightClone setObject:[self.localMediaItem  valueForProperty:MPMediaItemPropertyArtist] forKey:@"artistName"];
    return lightClone;
}

@end

@protocol MediaItemProtocol
- (BOOL)isType:(NSString *)type;

@end


