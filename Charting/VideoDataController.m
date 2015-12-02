//
//  VideoDataController.m
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "VideoDataController.h"
#import "Video.h"
#import "ServerData.h"
#import "User.h"

@implementation VideoDataController

NSString *const kChannelDiscoveryURLString = @"discover/discovery/{channel}/{page}/{size}/{userID}/";

+(NSMutableArray*)getChannelDetailsFor: (NSString*)channel page:(int) pageNo {
    
    
    NSURL *discoveryURL = [ NSURL URLWithString:[ NSString stringWithFormat: @"discovery/discovery/%@/%d/%d/%@/",channel,pageNo,10, [ User getCurrentActiveUser].userId ] relativeToURL:[ ServerData kBaseURL ]];
    
    NSMutableURLRequest *request = [ NSMutableURLRequest requestWithURL:discoveryURL
                            cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval: 10 ];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:request
                                                                                                returningResponse:&urlResponse error:&requestError]
                                                                  options:kNilOptions error:&requestError ];
    
    NSMutableArray *videoArray = [[ NSMutableArray alloc ] init ];
    
    for (NSDictionary *video in responseArray) {
        
        Video *videoInfo = [[ Video alloc ] init ];
        
        videoInfo.videoName = [ video valueForKey:@"videoName" ];
        videoInfo.userName = [ video valueForKey:@"userName" ];
        videoInfo.duration = [ video valueForKey:@"videoDuration" ];
        videoInfo.likeCount = [ video valueForKey:@"noOfLiked" ];
        videoInfo.commentCount = [ video valueForKey:@"noOfComments" ];
        videoInfo.viewCount = [ video valueForKey:@"noOfWatch" ];
        
        [ videoArray addObject:videoInfo ];
        
    }

    
    return videoArray;
}

@end
