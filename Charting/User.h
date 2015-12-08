//
//  User.h
//  Charting
//
//  Created by Suman Roy on 30/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(User*)getCurrentActiveUser;

@property NSString *userId;
@property NSString *userName;

@end
