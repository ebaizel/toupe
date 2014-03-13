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

- (BOOL)saveUser
{
    NSString *path = [self userArchivePath];
    return [NSKeyedArchiver archiveRootObject:[self userProfile] toFile:path];
}

- (BOOL)resetUser
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:[self userArchivePath] error:&error];
    if (success) {
        [self createNewUserProfile];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedOut" object:self];
    }
    else
    {
        NSLog(@"Could not logout; can't delete file -:%@ ",[error localizedDescription]);
    }
    return success;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [self userArchivePath];
        [self setUserProfile:[NSKeyedUnarchiver unarchiveObjectWithFile:path]];
        if (![self userProfile]) {
            [self createNewUserProfile];
        }
    }
    return self;
}

- (void)createNewUserProfile
{
    [self setUserProfile:[[FBUserProfile alloc] init]];
    self.userProfile.monthlyConsumption = 100;
    self.userProfile.showHelp = YES;
}

- (NSString *)userArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"user.archive"];
}

@end
