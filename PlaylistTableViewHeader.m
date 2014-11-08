//
//  PlaylistTableViewHeader.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-11-08.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "PlaylistTableViewHeader.h"

@implementation PlaylistTableViewHeader

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self = [[[NSBundle mainBundle] loadNibNamed:@"PlaylistTableViewHeader"
											  owner:self
											options:nil] lastObject];
		[self setFrame:CGRectMake(frame.origin.x,
								  frame.origin.y,
								  [self frame].size.width,
								  [self frame].size.height)];
		}
	return self;
}
@end
