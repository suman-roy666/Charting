//
//  User.m
//  Charting
//
//  Created by Suman Roy on 30/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "User.h"

@implementation User

+(User*)getCurrentActiveUser{
    
    static User *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[User alloc] init];
    });

    
    return _sharedInstance;
}

@end
