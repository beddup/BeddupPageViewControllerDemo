//
//  AppDelegate.m
//  PageViewControllerDemo
//
//  Created by Amay on 10/29/15.
//  Copyright © 2015 Beddup. All rights reserved.
//

#import "AppDelegate.h"
#import "BeddupPageViewController.h"
#import "ContentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray* titles = @[@"财经",@"体育",@"娱乐",@"互联网"];

    ContentViewController* financeVC = [[ContentViewController alloc] initWithTitle:titles[0]];
    ContentViewController* sportsVC = [[ContentViewController alloc] initWithTitle:titles[1]];
    ContentViewController* entertainment = [[ContentViewController alloc] initWithTitle:titles[2]];
    ContentViewController* internetVC = [[ContentViewController alloc] initWithTitle:titles[3]];

    BeddupPageViewController* vc = [[BeddupPageViewController alloc] initWithSubTitles:titles controllers:@[financeVC,sportsVC,entertainment,internetVC]];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];

    self.window =  [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
