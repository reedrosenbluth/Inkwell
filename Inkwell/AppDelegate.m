//
//  AppDelegate.m
//  Inkwell
//
//  Created by Reed Rosenbluth on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ArticleViewController.h"
#import "CategoryViewController.h"

@implementation AppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackOpaque];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    ArticleViewController *articleViewController = [[ArticleViewController alloc] init];
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    UINavigationController *articleNavController = [[UINavigationController alloc] initWithRootViewController:articleViewController];
    UINavigationController *categoryNavController = [[UINavigationController alloc] initWithRootViewController:categoryViewController];
    NSArray *tabBarItems = [NSArray arrayWithObjects:articleNavController,categoryNavController, nil];
    
    [tabBarController setViewControllers:tabBarItems];
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor darkGrayColor]];
    //articleNavController.navigationBar.tintColor = [UIColor darkGrayColor];
    //categoryNavController.navigationBar.tintColor = [UIColor darkGrayColor];
    tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
