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

NSString *const kUserLoginURLString= @"user/login/%@/%@/DIV005/0/";
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

NSString *const kUserLogoutURLString = @"user/logout/%@/";

+ (BOOL)loginUser:(NSString *)userEmail password:(NSString *)password{
    
    NSString *loginURL = [ NSString stringWithFormat:kUserLoginURLString, userEmail, password ];
    
    NSURLResponse *serverResponse;
    
    NSData *loginResponseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performGETRequestFor:loginURL
                                                                                                              response:&serverResponse ];
    
    NSError *loginError = nil;
    
    NSDictionary *loginResponse = [ NSJSONSerialization JSONObjectWithData:loginResponseData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&loginError ];
    
    if ( loginResponse != nil ) {
        
        User *currentUser = [ User getCurrentActiveUser];
        NSString *uId = [ loginResponse valueForKey:@"id" ];
        
        currentUser.userId = uId;
        
        return YES;
    }
    
    return NO;
}

+(BOOL)createNewUser: (NSString*)userName password: (NSString*)password emailId: (NSString*)emailId{
    
    NSString *newUserData = [ NSString stringWithFormat:kUserSignUpDataFormat, userName, password, emailId ];
    
    NSURLResponse *signUpURLResponse;
    
    NSData *signUpResponseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performPOSTRequestFor:kUserSignUpURLString
                                                                                                               POSTData:newUserData
                                                                                                               response:&signUpURLResponse ];
    
    NSDictionary *signUpResponse = [ NSJSONSerialization JSONObjectWithData:signUpResponseData
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil ];
    
    if ( [ signUpResponse objectForKey:@"EmailStatus" ] != nil ) {
        
        [[ User getCurrentActiveUser ] setUserId: [ signUpResponse valueForKey:@"id" ] ];
        
        return YES;
    }
    
    return NO;
}

+(BOOL)logOutUser{
    
    NSString *logoutURL = [ NSString stringWithFormat:kUserLogoutURLString, [ User getCurrentActiveUser].userId ];
    
    NSURLResponse *logoutURLResponse = nil;
    
    NSData *logoutResponseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performPUTRequestFor:logoutURL response:&logoutURLResponse ];
    
    NSError *logoutError;
    
    NSDictionary *logoutResponse = [ NSJSONSerialization JSONObjectWithData:logoutResponseData options:NSJSONReadingAllowFragments error:&logoutError ];
    
    if( [ logoutResponse objectForKey:@"Success"] != nil){
        
        [ User getCurrentActiveUser ].userId = nil;
        
        return YES;
    }
    
    return NO;
}

@end
