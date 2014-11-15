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
    //TODO: update line below to reflect reality of peers
    self.peersThatHaveMedia = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], nil];
    return self;
}

//TODO: update self.user to be user that set the song this requires a change to how Dictionary is built
-(id)initWithDictionary:(NSDictionary *)dict
{
    self.localMediaItem = nil;
    self.user = @"NotSet";
    self.peersThatHaveMedia = [[NSArray alloc] initWithObjects:[dict objectForKey:@"user"], nil];
    self.type = @"FROM_PEER";
    self.image = [[UIImage alloc] init];
    
    return self;
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


