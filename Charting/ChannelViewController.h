//
//  ChannelViewController.h
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPSPageMenu.h"

@interface ChannelViewController : UIViewController < CAPSPageMenuDelegate >

@property (nonatomic) CAPSPageMenu *pageMenu;

@end
