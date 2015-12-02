//
//  ChannelViewController.m
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "ChannelViewController.h"
#import "PopularChannelViewController.h"
#import "VideoDataController.h"

@implementation ChannelViewController

-(void)viewDidLoad {
    
    
    // Array to keep track of controllers in page menu
    NSMutableArray *controllerArray = [NSMutableArray array];
    
    // Create variables for all view controllers you want to put in the
    // page menu, initialize them, and add each to the controller array.
    // (Can be any UIViewController subclass)
    // Make sure the title property of all view controllers is set
    // Example:WithNibname:@"controllerNibnName" bundle:nil
    
    PopularChannelViewController *controller = [ self.storyboard instantiateViewControllerWithIdentifier:@"PopularTableViewController" ];
    controller.title = @"POPULAR";
    controller.videoList = [ VideoDataController getChannelDetailsFor:@"popular" page:0 ];
    controller.bottomMargin = self.tabBarController.tabBar.frame.size.height;
    [controllerArray addObject:controller];
    
    UIViewController *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"RecentTableViewController"];
    controller2.title = @"RECENT";
    [controllerArray addObject:controller2];
    
    // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
    // Example:
    
    UIColor *bgColor = [ UIColor grayColor ];
    
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionMenuHeight: @(70.0),
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: bgColor
                                 };
    
    // Initialize page menu with controller array, frame, and optional parameters
    
    CGFloat top = self.topLayoutGuide.length;
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray
                                                        frame:CGRectMake(self.view.frame.origin.x,
                                                                         self.view.frame.origin.y + top,
                                                                         self.view.frame.size.width,
                                                                         self.view.frame.size.height)
                                                      options:parameters];
    
    self.pageMenu.delegate = self;
    
    // Lastly add page menu as subview of base view controller view
    // or use pageMenu controller in you view hierachy as desired
    [self.view addSubview:_pageMenu.view];
    
    
}

@end
