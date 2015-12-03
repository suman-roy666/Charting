//
//  ServerData.m
//  Charting
//
//  Created by Suman Roy on 02/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "ServerConnectionManager.h"

@implementation ServerConnectionManager

static NSURL *_kBaseURL;

NSString *const kBaseURLString = @"http://ec2-52-27-8-48.us-west-2.compute.amazonaws.com:8080/myscout/";

+(void)initialize{
    
    _kBaseURL = [ NSURL URLWithString:kBaseURLString ];
}

+(ServerConnectionManager*)getServerConnectionManagerInstance{
    
    static ServerConnectionManager *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ServerConnectionManager alloc] init];
        
    });
    
    
    return _sharedInstance;
}

- (NSDictionary*)performGETRequestFor: (NSString*)APIURL response: (NSURLResponse **)urlResponse  {
    
    NSURL *GETRequestURL = [ NSURL URLWithString:APIURL relativeToURL:_kBaseURL ];
    
    NSMutableURLRequest *GETRequest = [NSMutableURLRequest requestWithURL:GETRequestURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10 ];
    
    [GETRequest setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    urlResponse = nil;
    
    NSData *urlResponseData = [NSURLConnection sendSynchronousRequest: GETRequest
                                                    returningResponse: urlResponse
                                                                error: &requestError];
    
    if (urlResponseData == nil ) {
        
        return nil;
    }
    
    NSDictionary *urlResponseDictionary = [NSJSONSerialization JSONObjectWithData: urlResponseData
                                                                  options: NSJSONReadingAllowFragments
                                                                    error: &requestError ];
    if (requestError == nil ) {
        
        return urlResponseDictionary;
    }
    
    return nil;
}

- (NSDictionary*)performPOSTRequestFor:(NSString *)APIURL response:(NSURLResponse *__autoreleasing *)urlResponse{
    
    
    
    return nil;
}

+(NSURL *)kBaseURL{
    
    return _kBaseURL;
}



@end
