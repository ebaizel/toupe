//
//  FBLSE.m
//  Toupe
//
//  Created by emileleon on 2/2/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBLSE.h"

@implementation FBLSE

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_lseId forKey:@"lseId"];
    [aCoder encodeObject:_lseName forKey:@"lseName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setLseId:[aDecoder decodeObjectForKey:@"lseId"]];
        [self setLseName:[aDecoder decodeObjectForKey:@"lseName"]];
    }
    return self;
}
@end
