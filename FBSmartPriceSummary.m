//
//  FBTariffRateSummary.m
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBSmartPriceSummary.h"
#import "FBPricePeriod.h"

@implementation FBSmartPriceSummary

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    NSArray *results = [d objectForKey:@"results"];
    
    for (id result in results) {
        self.masterTariffId = [result objectForKey:@"masterTariffId"];
        self.tariffName = [result objectForKey:@"description"];
        self.fromDateTime = [result objectForKey:@"fromDateTime"];
        self.toDateTime = [result objectForKey:@"toDateTime"];
        self.rateMean = [[result objectForKey:@"rateMean"] floatValue];
        self.rateStandardDeviation = [[result objectForKey:@"rateStandardDeviation"] floatValue];
        
        NSArray *priceChangesDictionary = [result objectForKey:@"priceChanges"];
        NSMutableArray *priceChanges = [[NSMutableArray alloc]init];

        float prevRateAmount = 0;
        for (id pcd in priceChangesDictionary) {
            FBPricePeriod *pc = [[FBPricePeriod alloc]init];
            [pc readFromJSONDictionary:pcd];
            pc.prevRateAmount = prevRateAmount;
            [priceChanges addObject:pc];
            prevRateAmount = pc.rateAmount;
        }
        self.priceChanges = priceChanges;
    }
}

@end
