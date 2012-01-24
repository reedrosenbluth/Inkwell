//
//  CategoryViewController.m
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kLatestInkwellPostsURL [NSURL URLWithString: @"http://www.fa-inkwell.org/?json=get_category_index"]

#import "CategoryViewController.h"
#import "ArticleViewController.h"

@implementation CategoryViewController
@synthesize tableView;
@synthesize categories;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Categories";
        UITabBarItem *tbi = [self tabBarItem];
        UIImage *image = [UIImage imageNamed:@"categoryGlyph.png"];
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
    
    categories = [json objectForKey:@"categories"];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[categories objectAtIndex:[indexPath row]] objectForKey:@"title"]; 
    [cell.textLabel setFont:[UIFont fontWithName:@"System" size:11]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *slug = [[categories objectAtIndex:[indexPath row]] objectForKey:@"slug"];
    NSString *urlString = [NSString stringWithFormat:@"http://www.fa-inkwell.org/?json=get_category_posts&slug=%@",slug];
    NSURL *url = [NSURL URLWithString:urlString];
    ArticleViewController *avc = [[ArticleViewController alloc] init];
    [avc setUrl:url];
    [self.navigationController pushViewController:avc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [avc setTitle:[[categories objectAtIndex:[indexPath row]] objectForKey:@"title"]];
}

@end
