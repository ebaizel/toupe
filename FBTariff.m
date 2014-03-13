//
//  FBTariff.m
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBTariff.h"

@implementation FBTariff

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    self.masterTariffId = [[d objectForKey:@"masterTariffId"] stringValue];
    self.tariffName = [d objectForKey:@"tariffName"];
    self.tariffCode = [d objectForKey:@"tariffCode"];
    self.tariffType = [d objectForKey:@"tariffType"];
    self.lseId = [[d objectForKey:@"lseId"] stringValue];
    self.lseName = [d objectForKey:@"lseName"];
    self.customerLikelihood = [[d objectForKey:@"customerLikelihood"] floatValue];
    self.hasTimeOfUseRates = [[d objectForKey:@"hasTimeOfUseRates"] boolValue];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_masterTariffId forKey:@"masterTariffId"];
    [aCoder encodeObject:_tariffName forKey:@"tariffName"];
    [aCoder encodeObject:_tariffCode forKey:@"tariffCode"];
    [aCoder encodeObject:_tariffType forKey:@"tariffType"];
    [aCoder encodeObject:_lseId forKey:@"lseId"];
    [aCoder encodeObject:_lseName forKey:@"lseName"];
    [aCoder encodeFloat:_customerLikelihood forKey:@"customerLikelihood"];
    [aCoder encodeBool:_hasTimeOfUseRates forKey:@"hasTimeOfUseRates"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setMasterTariffId:[aDecoder decodeObjectForKey:@"masterTariffId"]];
        [self setTariffName:[aDecoder decodeObjectForKey:@"tariffName"]];
        [self setTariffCode:[aDecoder decodeObjectForKey:@"tariffCode"]];
        [self setTariffType:[aDecoder decodeObjectForKey:@"tariffType"]];
        [self setLseId:[aDecoder decodeObjectForKey:@"lseId"]];
        [self setLseName:[aDecoder decodeObjectForKey:@"lseName"]];
        [self setCustomerLikelihood:[aDecoder decodeFloatForKey:@"customerLikelihood"]];
        [self setHasTimeOfUseRates:[aDecoder decodeBoolForKey:@"hasTimeOfUseRates"]];
    }
    return self;
}

@end
