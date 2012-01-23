//
//  ArticleViewController.h
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *latestPosts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
