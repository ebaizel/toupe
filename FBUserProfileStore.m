//
//  FBUserProfileStore.m
//  Toupe
//
//  Created by emileleon on 12/17/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBUserProfileStore.h"
#import "FBUserProfile.h"

@implementation FBUserProfileStore

+ (FBUserProfileStore *)sharedStore{
    
    static FBUserProfileStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}


- (BOOL)saveChanges
{
    NSString *path = [self userArchivePath];
    return [NSKeyedArchiver archiveRootObject:[self userProfile] toFile:path];
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [self userArchivePath];
        [self setUserProfile:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
        if (![self userProfile]) {
            [self setUserProfile:[[FBUserProfile alloc] init]];
//            _userProfile.tariffIdTOU = @"518";
//            _userProfile.monthlyConsumption = 200;
//            _userProfile.zipCode = @"94115";
        }
    }
    return self;
}

- (NSString *)userArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"users.archive"];
}

@end
