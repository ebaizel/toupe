//
//  FBUserProfileStore.h
//  Toupe
//
//  Created by emileleon on 12/17/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBUserProfile.h"

@interface FBUserProfileStore : NSObject

+ (FBUserProfileStore *)sharedStore;

@property (nonatomic, strong) FBUserProfile *userProfile;
- (BOOL)saveUser;
- (BOOL)resetUser;

@end
