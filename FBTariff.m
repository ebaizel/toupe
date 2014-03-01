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
@end
