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
#import "KeychainItemWrapper.h"

@implementation UserDataController{
    
    
}

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

static KeychainItemWrapper *userDataKeychain ;

+(void)initialize{
    
    userDataKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
    
}

+ (BOOL)loginUser:(NSString *)userEmail password:(NSString *)password{
    
    NSString *loginURL = [ NSString stringWithFormat:kUserLoginURLString, userEmail, password ];
    
    NSURLResponse *serverResponse;
    
    NSData *loginResponseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performGETRequestFor:loginURL
                                                                                                            response:&serverResponse ];
    if (loginResponseData!=nil) {
        
        
        NSError *loginError = nil;
        
        NSDictionary *loginResponse = [ NSJSONSerialization JSONObjectWithData:loginResponseData
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&loginError ];
        
        if ( loginResponse != nil ) {
            
            User *currentUser = [ User getCurrentActiveUser];
            NSString *uId = [ loginResponse valueForKey:@"id" ];
            
            currentUser.userId = uId;
            
            [userDataKeychain setObject:uId forKey:(__bridge id)(kSecAttrAccount)];
            
            return YES;
        }
    }
    return NO;
}

+(BOOL)createNewUser: (NSString*)userName password: (NSString*)password emailId: (NSString*)emailId{
    
    NSString *newUserData = [ NSString stringWithFormat:kUserSignUpDataFormat, userName, password, emailId ];
    
    NSURLResponse *signUpURLResponse;
    
    NSData *signUpResponseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performPOSTRequestFor:kUserSignUpURLString
                                                                                                              POSTData:newUserData
                                                                                                              response:&signUpURLResponse ];
    if (signUpResponseData!=nil) {
        
        
        NSDictionary *signUpResponse = [ NSJSONSerialization JSONObjectWithData:signUpResponseData
                                                                        options:NSJSONReadingAllowFragments
                                                                          error:nil ];
        
        if ( [ signUpResponse objectForKey:@"EmailStatus" ] != nil ) {
            
            NSString *userId = [ signUpResponse valueForKey:@"id" ];
            
            [[ User getCurrentActiveUser ] setUserId: userId ];
            
            [userDataKeychain setObject:userId forKey:(__bridge id)(kSecAttrAccount)];
            
            
            return YES;
        }
    }
    return NO;
}

+(BOOL)logOutUser{
    
    NSString *logoutURL = [ NSString stringWithFormat:kUserLogoutURLString, [ User getCurrentActiveUser].userId ];
    
    NSURLResponse *logoutURLResponse = nil;
    
    NSData *logoutResponseData = [[ ServerConnectionManager getServerConnectionManagerInstance ] performPUTRequestFor:logoutURL response:&logoutURLResponse ];
    
    if (logoutResponseData!=nil) {
        NSError *logoutError;
        
        NSDictionary *logoutResponse = [ NSJSONSerialization JSONObjectWithData:logoutResponseData options:NSJSONReadingAllowFragments error:&logoutError ];
        
        if( [ logoutResponse objectForKey:@"Success"] != nil){
            
            [ User getCurrentActiveUser ].userId = nil;
            
            [ userDataKeychain resetKeychainItem ];
            
            return YES;
        }
    }
    return NO;
}

+(BOOL)checkUserLoginStatus{
    
    NSString *userID = [userDataKeychain objectForKey:(__bridge id)(kSecAttrAccount)];
    
    if ( ![userID isEqualToString:@"" ]) {
        
        [[ User getCurrentActiveUser] setUserId: userID ];
        
        return YES;
    }
    
    return NO;
}

@end
