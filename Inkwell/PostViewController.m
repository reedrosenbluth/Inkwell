//
//  PostViewController.m
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostViewController.h"

@implementation PostViewController

@synthesize post;
@synthesize title;
@synthesize author;
@synthesize scrollView;
@synthesize postWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [scrollView setContentSize:CGSizeMake(320, 960)];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPostWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    NSString *frontMatter = @"<html>"
                                    "<head>"
                                    "<style type =\"text/css\">"
                                    "body {"
                                        "background:E6E3DE;"
                                        "color: 444444;"
                                        "font: 12pt \"Helvetica\";"
                                    "}"
                                    "h1 {"
                                        "color: 444444;"
                                        "font: 22pt \"Helvetica\";"
                                    "}"
                                    "h2 {"
                                        "color: 3B3B3B;"
                                        "font: 14pt \"Helvetica\";"
                                    "}"
                            "</style>";
    NSString *backMatter = @"</html>";
    NSString *html = [NSString stringWithFormat:@"%@<h1>%@</h1><h2><b>by %@</b></h2><body>%@</body>%@", frontMatter, title, author, post, backMatter];
    
    [postWebView loadHTMLString:html baseURL:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
