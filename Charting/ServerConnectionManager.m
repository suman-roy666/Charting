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

- (NSData*)performGETRequestFor: (NSString*)APIURL response: (NSURLResponse **)urlResponse  {
    
    NSURL *GETRequestURL = [ NSURL URLWithString:APIURL relativeToURL:_kBaseURL ];
    
    NSMutableURLRequest *GETRequest = [NSMutableURLRequest requestWithURL:GETRequestURL
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                          timeoutInterval:10 ];
    
    [GETRequest setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    urlResponse = nil;
    
    NSData *urlResponseData = [NSURLConnection sendSynchronousRequest: GETRequest
                                                    returningResponse: urlResponse
                                                                error: &requestError];
    
    if (requestError == nil ) {
        
        return urlResponseData;
    }
    
    return nil;
}

- (NSData*)performPOSTRequestFor:(NSString *)APIURL POSTData:(NSString *)postDataString response:(NSURLResponse *__autoreleasing *)urlResponse{
    
    NSData *postData = [ postDataString dataUsingEncoding:NSASCIIStringEncoding
                                     allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postDataString length]];
    
    NSURL *POSTRequestURL = [ NSURL URLWithString:APIURL relativeToURL:_kBaseURL ];
    
    NSMutableURLRequest *POSTRequest = [ NSMutableURLRequest requestWithURL:POSTRequestURL
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:30 ];
    
    [ POSTRequest setHTTPMethod:@"POST" ];
    [ POSTRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [ POSTRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [ POSTRequest setHTTPBody:postData ];
    
    NSError *requestError = nil;
    
    NSData *urlResponseData = [ NSURLConnection sendSynchronousRequest:POSTRequest
                                                     returningResponse:urlResponse
                                                                 error:&requestError ];
    
    if (requestError == nil ) {
        
        return urlResponseData;
    }
    
    return nil;
}

- (NSData*)performPUTRequestFor: (NSString*)APIURL response: (NSURLResponse **)urlResponse{
    
    NSURL *GETRequestURL = [ NSURL URLWithString:APIURL relativeToURL:_kBaseURL ];
    
    NSMutableURLRequest *GETRequest = [NSMutableURLRequest requestWithURL:GETRequestURL
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                          timeoutInterval:10 ];
    
    [GETRequest setHTTPMethod: @"PUT"];
    
    NSError *requestError = nil;
    urlResponse = nil;
    
    NSData *urlResponseData = [NSURLConnection sendSynchronousRequest: GETRequest
                                                    returningResponse: urlResponse
                                                                error: &requestError];
    
    if (requestError == nil ) {
        
        return urlResponseData;
    }
    
    
    return nil;
}


@end
