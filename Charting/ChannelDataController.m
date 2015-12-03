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

@implementation ChannelDataController{
    
    NSString *discoveryURLString;
}

/*
 URL Format
 discovery/{channel}/{page}/{size}/{userID}/
 */

NSString *const kChannelDiscoveryURLString = @"discovery/discovery/%@/%@/%d/%@/";

- (instancetype)initWithChannel: (NSString*)channel pageSize: (int) pageSize{
    
    self = [ super init ];
    
    if (self) {
        
        discoveryURLString = [ NSString stringWithFormat:kChannelDiscoveryURLString, channel, @"%d", pageSize, [ User getCurrentActiveUser].userId  ];
    }
    
    return self;
}

+(NSMutableArray*)getChannelDetailsFor: (NSString*)channel page:(int) pageNo {
    
    
    NSURL *discoveryURL = [ NSURL URLWithString:[ NSString stringWithFormat: @"discovery/discovery/%@/%d/%d/%@/",channel,pageNo,10, [ User getCurrentActiveUser].userId ]
                                  relativeToURL:[ ServerConnectionManager kBaseURL ]];
    
    NSMutableURLRequest *request = [ NSMutableURLRequest requestWithURL:discoveryURL
                                                            cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                        timeoutInterval: 10 ];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:request
                                                                                           returningResponse:&urlResponse
                                                                                                       error:&requestError]
                                                             options:kNilOptions
                                                               error:&requestError ];
    
    NSMutableArray *videoArray = [[ NSMutableArray alloc ] init ];
    
    for (NSDictionary *video in responseArray) {
        
        Video *videoInfo = [[ Video alloc ] init ];
        
        videoInfo.videoName     = [ video valueForKey:@"videoName" ];
        videoInfo.userName      = [ video valueForKey:@"userName" ];
        videoInfo.duration      = [ video valueForKey:@"videoDuration" ];
        videoInfo.likeCount     = [ video valueForKey:@"noOfLiked" ];
        videoInfo.commentCount  = [ video valueForKey:@"noOfComments" ];
        videoInfo.viewCount     = [ video valueForKey:@"noOfWatch" ];
        
        [ videoArray addObject:videoInfo ];
        
    }
    
    
    return videoArray;
}

@end
