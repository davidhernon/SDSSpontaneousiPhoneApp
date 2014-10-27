//
//  SongTableView.m
//  SDSIPhoneApp
//
//  Created by Martin Weiss 1 on 2014-10-18.
//  Copyright (c) 2014 Silent Disco Squad. All rights reserved.
//

#import "SongTableView.h"

@implementation SongTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)init: (CGRect)frame
{
	self = [super initWithFrame:frame];
	self.delegate = self;
	self.dataSource = self;
	self.playlist = [[NSMutableArray alloc]init];
	return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

-(void)addTracktoTable:(MPMediaItemSubclass*)passedSong
{
	[self.playlist addObject:passedSong];
}


@end
