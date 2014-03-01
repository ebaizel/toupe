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
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setZipCode:[aDecoder decodeObjectForKey:@"zipCode"]];
        [self setTariffIdTOU:[aDecoder decodeObjectForKey:@"tariffIdTOU"]];
        [self setMonthlyConsumption:[aDecoder decodeIntForKey:@"monthlyConsumption"]];
    }
    
    return self;
}
@end
