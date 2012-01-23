//
//  PostViewController.h
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PostViewController : UIViewController

@property (nonatomic, copy) NSString *post;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIWebView *postWebView;

@end
