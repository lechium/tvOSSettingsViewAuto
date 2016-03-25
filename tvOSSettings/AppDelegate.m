//
//  AppDelegate.m
//  tvOSSettings
//
//  Created by Kevin Bradley on 3/18/16.
//  Copyright © 2016 nito. All rights reserved.
//



#import "AppDelegate.h"
#import "SettingsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSArray *)items
{
    NSDictionary *console = @{@"name": @"Logs", @"coverArt": @"http://nitosoft.com/ATV2/install/images/btstack.png", @"detail": @"System", @"detailOptions": @[@"System", @"Crash"], @"Version:": @"6.6.6", @"Author:": @"Jesus", @"descriptions": @"Logs"};
    NSDictionary *shares = @{@"name": @"Shares", @"coverArt": @"GenericSharepoint", @"detail": @"Local", @"detailOptions": @[@"Local", @"AFP", @"SMB"], @"Version:": @"1.2.3", @"Author:": @"Hayzus", @"description": @"Different share point information, could be Local, AFP or SMB"};
    NSDictionary *packages = @{@"name": @"Packages", @"coverArt": @"package", @"detail": @"Local", @"detailOptions": @[@"Local", @"Online"], @"Version:": @"3.2.1", @"Author:": @"Yars", @"description": @"Packages that are installed"};
    NSDictionary *pm = @{@"name": @"PackageMaker", @"coverArt": @"packagemaker", @"detail": @"", @"detailOptions": @[], @"Version:": @"1.1", @"Author:": @"Wut", @"description": @"Create packages"};
    NSDictionary *reboot = @{@"name": @"Reboot", @"coverArt": @"reboot", @"detail": @"", @"detailOptions": @[], @"Version:": @"2.1", @"Author:": @"Whoosit", @"description": @"Reboot the system"};
    NSDictionary *rss = @{@"name": @"RSS", @"coverArt": @"rss", @"detail": @"", @"detailOptions": @[], @"Version:": @"1.3.4", @"Author:": @"Mr Meeseeks", @"description": @"Your favorite RSS feeds"};
    NSDictionary *search = @{@"name": @"Search", @"coverArt": @"search", @"detail": @"Local", @"detailOptions": @[], @"Version:": @"3.1", @"Author:": @"Yaz", @"description": @"Local search for files"};
    NSDictionary *shutdown = @{@"name": @"Shutdown", @"coverArt": @"Shutdown", @"detail": @"", @"detailOptions": @[], @"Version:": @"1.2.4b", @"Author:": @"Who", @"description": @"Shutdown your system"};
    NSDictionary *weather = @{@"name": @"Weather", @"coverArt": @"Weather", @"detail": @"AZ", @"detailOptions": @[@"AZ", @"PA", @"CA"], @"Version:": @"3.1.3", @"Author:": @"KayBee", @"description": @"Your favorite weather forecast"};
    NSDictionary *yt = @{@"name": @"YouTube", @"coverArt": @"YTPlaceholder", @"detail": @"", @"detailOptions": @[], @"Version:": @"3.2.3", @"Author:": @"Casey Jones", @"description": @"YouTube browser"};
    
    return @[[[MetaDataAsset alloc] initWithDictionary:console], [[MetaDataAsset alloc] initWithDictionary:shares], [[MetaDataAsset alloc] initWithDictionary:packages], [[MetaDataAsset alloc] initWithDictionary:pm], [[MetaDataAsset alloc] initWithDictionary:reboot],[[MetaDataAsset alloc] initWithDictionary:rss], [[MetaDataAsset alloc] initWithDictionary:search], [[MetaDataAsset alloc] initWithDictionary:shutdown], [[MetaDataAsset alloc] initWithDictionary:weather], [[MetaDataAsset alloc] initWithDictionary:yt]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *navController = [UINavigationController new];
    SettingsViewController *viewCon = [SettingsViewController new];
    
    viewCon.items = [self items];
    viewCon.title = @"Settings";
  //  viewCon.view.backgroundColor = [UIColor clearColor];
  //  viewCon.titleColor = [UIColor colorFromHex:@"DC1916"];
    
    navController.viewControllers = @[viewCon];
    self.window.rootViewController = navController;
    
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
