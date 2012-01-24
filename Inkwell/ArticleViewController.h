//
//  ArticleViewController.h
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface ArticleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *latestPosts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSURL *url;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *hudBG;

@end
