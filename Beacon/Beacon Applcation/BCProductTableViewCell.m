//
//  BCProductTableViewCell.m
//  Beacon
//
//  Created by Nguyen Thanh Son on 8/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import "BCProductTableViewCell.h"

@implementation BCProductTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
