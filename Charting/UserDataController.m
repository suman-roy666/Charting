//
//  UserDataController.m
//  Charting
//
//  Created by Suman Roy on 03/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "UserDataController.h"
#import "ServerConnectionManager.h"
#import "User.h"

@implementation UserDataController

/*
 Login Format
 user/login/{emailId}/{password}/{deviceId}/{deviceType}/
 */

NSString *const kUserLoginURLString= @"user/login/%@/%@/DIV0005/0/";
NSString *const kUserSignUpURLString= @"user/createUser";
NSString *const kUserSignUpDataFormat = @"{\"name\"         :\"%@\","
                                        "\"password\"       :\"%@\","
                                        "\"emailId\"        :\"%@\","
                                        "\"instagramId\"    :\"\","
                                        "\"deviceId\"       :\"DIV0005\","
                                        "\"description\"    :\"\","
                                        "\"websiteUrl\"     :\"\","
                                        "\"facebookUrl\"    :\"\","
                                        "\"twitterUrl\"     :\"\","
                                        "\"instagramUrl\"   :\"\""
                                        ",\"photoUrl\"      :\"\","
                                        "\"deviceType\"     :0,"
                                        "\"city\"           :\"\","
                                        "\"state\"          :\"\","
                                        "\"country\"        :\"\","
                                        "\"role\"           :3}";

/*
 Logout Format
 /user/logout/{id}
 */

NSString *const kUserLogoutURLString = @"user/logout/%@";

+ (BOOL)loginUser:(NSString *)userEmail password:(NSString *)password{
    
    NSString *loginURL = [ NSString stringWithFormat:kUserLoginURLString, userEmail, password ];
    
    NSURLResponse *serverResponse;
    
    NSDictionary *loginResponse = [[ ServerConnectionManager getServerConnectionManagerInstance ] performGETRequestFor:loginURL
                                                                                                              response:&serverResponse ];
    
    if (loginResponse != nil ) {
        
        User *currentUser = [ User getCurrentActiveUser];
        NSString *uId = [ loginResponse valueForKey:@"id" ];
        
        currentUser.userId = uId;
        
        return YES;
    }
    
    return NO;
}

+(BOOL)createNewUser: (NSString*)userName password: (NSString*)password emailId: (NSString*)emailId{
    
    NSString *newUserData = [ NSString stringWithFormat:kUserSignUpDataFormat, userName, password, emailId ];
    
    NSData *userPostData = [newUserData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[newUserData length]];
    
    return NO;
}

@end
