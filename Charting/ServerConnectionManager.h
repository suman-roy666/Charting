//
//  ServerData.h
//  Charting
//
//  Created by Suman Roy on 02/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerConnectionManager : NSObject

+(ServerConnectionManager*)getServerConnectionManagerInstance;
- (NSData*)performGETRequestFor: (NSString*)APIURL response: (NSURLResponse **)urlResponse;
- (NSData*)performPOSTRequestFor:(NSString *)APIURL POSTData: (NSString*)postDataString response:(NSURLResponse *__autoreleasing *)urlResponse;
- (NSData*)performPUTRequestFor: (NSString*)APIURL response: (NSURLResponse **)urlResponse;

@end
