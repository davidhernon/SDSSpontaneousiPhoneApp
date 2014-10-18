//
//  baTableViewCell.h
//  SDSApp2
//
//  Created by Martin Weiss 1 on 2014-07-23.
//  Copyright (c) 2014 Martin Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@end
