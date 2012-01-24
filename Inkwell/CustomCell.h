//
//  CustomCell.h
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *previewLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailView;

@end
