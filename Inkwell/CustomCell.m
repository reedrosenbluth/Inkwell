//
//  CustomCell.m
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize authorLabel;
@synthesize titleLabel;
@synthesize categoryLabel;
@synthesize previewLabel;
@synthesize thumbnailView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
