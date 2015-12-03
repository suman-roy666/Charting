//
//  ServerData.h
//  Charting
//
//  Created by Suman Roy on 02/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerConnectionManager : NSObject

+(NSURL *)kBaseURL;

+(ServerConnectionManager*)getServerConnectionManagerInstance;
- (NSDictionary*)performGETRequestFor: (NSString*)APIURL response: (NSURLResponse **)urlResponse;

@end
