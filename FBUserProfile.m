//
//  FBUserProfile.m
//  Toupe
//
//  Created by emileleon on 12/17/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBUserProfile.h"

@implementation FBUserProfile
@synthesize zipCode, tariffIdTOU;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:zipCode forKey:@"zipCode"];
    [aCoder encodeObject:tariffIdTOU forKey:@"tariffIdTOU"];
    [aCoder encodeInt:_monthlyConsumption forKey:@"monthlyConsumption"];
    [aCoder encodeObject:_favorites forKey:@"favorites"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setZipCode:[aDecoder decodeObjectForKey:@"zipCode"]];
        [self setTariffIdTOU:[aDecoder decodeObjectForKey:@"tariffIdTOU"]];
        [self setMonthlyConsumption:[aDecoder decodeIntForKey:@"monthlyConsumption"]];
        [self setFavorites:[aDecoder decodeObjectForKey:@"favorites"]];
    }
    return self;
}

-(void)setFavorite:(NSString *)lseId forTariffId:(NSString *)tariffId
{
    if (!_favorites) {
        _favorites = [[NSMutableDictionary alloc]init];
    }
    
    [_favorites setObject:tariffId forKey:lseId];
}

-(BOOL)isFavoriteTariff:(NSString *)tariffId forLse:(NSString *)lseId
{
    NSString *favorite;
    if (_favorites && tariffId) {
        favorite = [_favorites objectForKey:lseId];
        if ([tariffId isEqualToString:favorite]) {
            return true;
        }
    }
    return false;
}

-(NSString *)getFavoriteTariff:(NSString *)lseId
{
    NSString *favorite;
    if (_favorites) {
        favorite = [_favorites objectForKey:lseId];
    }
    return favorite;
}
@end
