//
//  ServerData.m
//  Charting
//
//  Created by Suman Roy on 02/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "ServerData.h"

@implementation ServerData
    
static NSURL *_kBaseURL;

NSString *const kBaseURLString = @"http://ec2-52-27-8-48.us-west-2.compute.amazonaws.com:8080/myscout/";

#pragma mark - User API URLs
NSString *const kUserLoginURLString = @"user/login/{emailId}/{password}/{deviceId}/{deviceType}/";
NSString *const kCreateUserURLString = @"user/createUser";
NSString *const kLogoutUserURLString = @"user/logout/{id}";


+(void)initialize{
    
    _kBaseURL = [ NSURL URLWithString:kBaseURLString ];
}

+(NSURL *)kBaseURL{
    
    return _kBaseURL;
}

@end
