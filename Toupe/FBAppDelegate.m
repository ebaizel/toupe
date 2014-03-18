//
//  FBAppDelegate.m
//  Toupe
//
//  Created by emileleon on 12/2/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBAppDelegate.h"
#import "FBCurrentPriceViewController.h"
#import "FBRootNavigationController.h"
#import "FBHomeViewController.h"
//#import "FBEnterZipCodeViewController.h"
#import "FBUserProfileStore.h"
#import "FBWelcomeViewController.h"
#import "TestFlight.h"

@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // start of your application:didFinishLaunchingWithOptions // ...
    [TestFlight takeOff:@"6c5d44fa-b298-4cfe-b92e-40498a77a4da"];
    // The rest of your application:didFinishLaunchingWithOptions method// ...

    
    // Override point for customization after application launch.
    UINavigationController *navc = [[UINavigationController alloc]init];
    navc.navigationBar.tintColor = [UIColor black50PercentColor];
    [navc setNavigationBarHidden:YES];
        
    FBHomeViewController *home = [[FBHomeViewController alloc]init];
    [navc pushViewController:home animated:YES];

    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Helvetica" size:24], NSFontAttributeName,
                                [UIColor skyBlueColor], NSForegroundColorAttributeName, nil];
    navc.navigationBar.titleTextAttributes = attributes;
    
//    [[UIBarButtonItem appearance] setTintColor:[UIColor blueberryColor]];
    
    FBUserProfile *userProfile = [[FBUserProfileStore sharedStore] userProfile];
    
    if ((userProfile == nil) || (userProfile.zipCode == nil)) {
        [navc setNavigationBarHidden:YES animated:NO];
        FBWelcomeViewController *welcomeVC = [[FBWelcomeViewController alloc]init];
        [navc pushViewController:welcomeVC animated:YES];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self window] setRootViewController:navc];

    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
