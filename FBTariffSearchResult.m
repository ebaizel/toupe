//
//  FBTariffSearchResult.m
//  Toupe
//
//  Created by emileleon on 1/29/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBTariffSearchResult.h"
#import "FBTariff.h"

@implementation FBTariffSearchResult

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    NSMutableArray *tariffsResult = [[NSMutableArray alloc] init];
    NSDictionary *resultsDict = [d objectForKey:@"results"];
    for (NSDictionary *tariffDict in resultsDict) {
        FBTariff *tariff = [[FBTariff alloc] init];
        [tariff readFromJSONDictionary:tariffDict];
        [tariffsResult addObject:tariff];
    }
    self.tariffs = tariffsResult;
}
@end
