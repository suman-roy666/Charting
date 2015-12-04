//
//  PopularChannelViewController.h
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopularChannelViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >

@property (nonatomic) CGFloat bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
