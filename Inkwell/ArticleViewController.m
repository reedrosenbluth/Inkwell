//
//  ArticleViewController.m
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//#define kLatestInkwellPostsURL [NSURL URLWithString: @"http://www.fa-inkwell.org/?json=1"]

#import "ArticleViewController.h"
#import "PostViewController.h"
#import "CustomCell.h"

@implementation ArticleViewController

@synthesize latestPosts;
@synthesize tableView;
@synthesize url;
@synthesize loadingIndicator;
@synthesize hudBG;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Recent Articles";
        url = [NSURL URLWithString: @"http://www.fa-inkwell.org/?json=1"];
        
        UITabBarItem *tbi = [self tabBarItem];
        UIImage *image = [UIImage imageNamed:@"bookGlyph.png"];
        [tbi setImage:image];
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
    
    dispatch_async(kBgQueue, ^{
       NSData* data = [NSData dataWithContentsOfURL: 
                        url];
        [self performSelectorOnMainThread:@selector(fetchedData:) 
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData
                          options:kNilOptions 
                          error:&error];
    
    latestPosts = [json objectForKey:@"posts"];
    
    //NSLog(@"posts: %@", latestPosts);
    //NSLog(@"%@", [post objectForKey:@"title"]);
    NSLog(@"data retrieved");
    [loadingIndicator stopAnimating];
    
    [UIView animateWithDuration:.2 animations:^(void){
        [hudBG setAlpha:0];
    }];
    
    [tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[self tableView] setRowHeight:76];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setLoadingIndicator:nil];
    [self setHudBG:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [latestPosts count];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = (CustomCell *)[tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[CustomCell class]]) 
                cell = (CustomCell *)oneObject;
    }
    
    cell.titleLabel.text = [[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"title"];
    cell.previewLabel.text = [[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"excerpt"];
    cell.authorLabel.text = [[[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"author"] valueForKey:@"name"];
    cell.categoryLabel.text = [[[[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"categories"] objectAtIndex:0] valueForKey:@"title"];
    
    /*NSString *urlString = [[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"thumbnail"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *thumbnailImage = [UIImage imageWithData:data];
    
    cell.thumbnailView.image = thumbnailImage;*/
    //[cell.textLabel setFont:[UIFont fontWithName:@"System" size:11]];
    
    return cell;
}


- (void)tableView:(UITableView *)tv willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[cell setBackgroundColor:[UIColor colorWithRed:0.90 green:0.89 blue:0.87 alpha:1]];
    //[tv setSeparatorColor:[UIColor colorWithRed:0.85 green:.839 blue:0.82 alpha:1]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostViewController *pvc = [[PostViewController alloc] init];
    NSString *aPost = [[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"content"];
    NSString *aTitle = [[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"title"];
    NSString *aAuthor = [[[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"author"] valueForKey:@"name"];
    [pvc setPost:aPost];
    [pvc setTitle:aTitle];
    [pvc setAuthor:aAuthor];
    [[self navigationController] pushViewController:pvc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
