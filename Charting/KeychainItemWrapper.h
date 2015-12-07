//
//  KeychainItemWrapper.h
//  Charting
//
//  Created by Suman Roy on 07/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 The KeychainItemWrapper class is an abstraction layer for the iPhone Keychain communication. It is merely a
 simple wrapper to provide a distinct barrier between all the idiosyncracies involved with the Keychain
 CF/NS container objects.
 */
@interface KeychainItemWrapper : NSObject

// Designated initializer.
- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *)accessGroup;
- (void)setObject:(id)inObject forKey:(id)key;
- (id)objectForKey:(id)key;

// Initializes and resets the default generic keychain item data.
- (void)resetKeychainItem;

@end