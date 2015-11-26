//
//  PageContentViewController.h
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *endTutorialButton;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSUInteger lastPage;

- (IBAction)endTutorial:(id)sender;

@end
