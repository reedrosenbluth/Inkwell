//
//  ArticleViewController.m
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kLatestInkwellPostsURL [NSURL URLWithString: @"http://www.fa-inkwell.org/?json=1"]

#import "ArticleViewController.h"
#import "PostViewController.h"

@implementation ArticleViewController

@synthesize latestPosts;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    self.title = @"Inkwell";
    
    dispatch_async(kBgQueue, ^{
       NSData* data = [NSData dataWithContentsOfURL: 
                        kLatestInkwellPostsURL];
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
    [tableView reloadData];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
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
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[latestPosts objectAtIndex:[indexPath row]] valueForKey:@"title"]; 
    [cell.textLabel setFont:[UIFont fontWithName:@"System" size:11]];
    
    return cell;
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
