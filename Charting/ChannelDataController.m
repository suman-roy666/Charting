//
//  VideoDataController.m
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "ChannelDataController.h"
#import "Video.h"
#import "ServerConnectionManager.h"
#import "User.h"

#define kPageLength

@implementation ChannelDataController{
    
    NSString *discoveryURLString;
}

/*
 URL Format
 discovery/{channel}/{page}/{size}/{userID}/
 */

NSString *const kChannelDiscoveryURLString = @"discovery/discovery/%@/%@/%@/%@/";
NSString *const pageLength = @"10";
static int page = 0;

- (instancetype)initWithChannel: (NSString*)channel{
    
    self = [ super init ];
    
    if (self) {
        
        discoveryURLString = [ NSString stringWithFormat:kChannelDiscoveryURLString, channel, @"%d", pageLength, [ User getCurrentActiveUser].userId  ];
    }
    
    return self;
}

-(NSArray*)retrieveChannelDataFromRoot: (BOOL)startFromRoot {
    
    if ( startFromRoot ){
        
        page = 0;
        
    } else {
        
        ++page;
    }
    
    NSString *discoveryURL = [ NSString stringWithFormat: discoveryURLString, page ];
    
    
    NSURLResponse *discoveryResponse = nil;
    
    NSData *responseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performGETRequestFor:discoveryURL response:&discoveryResponse ];
    

    if ( responseData != nil ){
        
        NSError *responseError = nil;
        
        NSArray *responseArray = [ NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&responseError ];
        
        NSMutableArray *videoArray = [[ NSMutableArray alloc ] init ];
        
        for (NSDictionary *video in responseArray) {
            
            Video *videoInfo = [[ Video alloc ] init ];
            
            videoInfo.videoName     = [ video valueForKey:@"videoName" ];
            videoInfo.userName      = [ video valueForKey:@"userName" ];
            videoInfo.videoImageURL = [ video valueForKey:@"thumbNailUrl" ];
            videoInfo.duration      = [ video valueForKey:@"videoDuration" ];
            videoInfo.likeCount     = [ video valueForKey:@"noOfLiked" ];
            videoInfo.commentCount  = [ video valueForKey:@"noOfComments" ];
            videoInfo.viewCount     = [ video valueForKey:@"noOfWatch" ];
            
            [ videoArray addObject:videoInfo ];
            
        }
        
        return videoArray;
    }
    
    return nil;
}

@end
