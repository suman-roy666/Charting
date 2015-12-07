//
//  ViewController.h
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController < UIPageViewControllerDataSource >
- (IBAction)endTutorial:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;

@end

