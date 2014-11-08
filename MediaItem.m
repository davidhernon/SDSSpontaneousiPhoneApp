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
@end

