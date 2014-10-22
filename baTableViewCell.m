//
//  baTableViewCell.m
//  SDSApp2
//
//  Created by Martin Weiss 1 on 2014-07-23.
//  Copyright (c) 2014 Martin Weiss. All rights reserved.
//  http://www.appcoda.com/customize-table-view-cells-for-uitableview/


#import "baTableViewCell.h"

@implementation baTableViewCell
@synthesize titleLabel = _titleLabel;
@synthesize locationLabel = _locationLabel;
@synthesize dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = [UIColor blackColor];
		_titleLabel.font = [UIFont fontWithName:@"Dosis-Medium" size:20];
		_locationLabel.font = [UIFont fontWithName:@"Dosis-Medium" size:20];
		_dateLabel.font = [UIFont fontWithName:@"Dosis-Medium" size:20];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
