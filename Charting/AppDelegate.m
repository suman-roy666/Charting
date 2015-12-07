//
//  AppDelegate.m
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "AppDelegate.h"
#import "SignInViewController.h"
#import "UserDataController.h"
#import "ServerConnectionManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSMutableString *startingScreenIdentifier = [[ NSMutableString alloc] init ];
    UIColor *bgColor = [ UIColor colorWithRed:( 28.0/255.0 ) green:(216.0/255.0 ) blue:1.0 alpha:1.0 ];
    
    // Override point for customization after application launch.
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = bgColor;
    
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]){
        
        startingScreenIdentifier = [ NSMutableString stringWithString: @"RootViewController" ];
        
    } else {
        
        if ( [ UserDataController checkUserLoginStatus] ){
            
            startingScreenIdentifier = [ NSMutableString stringWithString: @"TabBarController" ];
            
        } else {
            
            startingScreenIdentifier = [ NSMutableString stringWithString: @"UserSignInNavigationController" ];
            
        }
    }
    UIViewController *rootController = [ mainStoryboard instantiateViewControllerWithIdentifier:startingScreenIdentifier ];
    self.window.rootViewController = rootController;
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
