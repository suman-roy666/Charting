//
//  Video.h
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (strong,nonatomic) NSString *videoName;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *videoImageURL;
@property (strong,nonatomic) NSNumber *duration;
@property (strong,nonatomic) NSNumber *likeCount;
@property (strong,nonatomic) NSNumber *viewCount;
@property (strong,nonatomic) NSNumber *commentCount;

@end
