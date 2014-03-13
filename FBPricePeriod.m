//
//  FBPriceChanges.m
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBPricePeriod.h"

@implementation FBPricePeriod

+(NSString *)priceAsString:(FBPricePeriod *)pricePeriod
{
    return [NSString stringWithFormat:@"$%.3f",(pricePeriod.rateAmount)];
}

-(void)readFromJSONDictionary:(NSDictionary *)d
{
    self.name = [d objectForKey:@"name"];

    NSString *dateString = [d objectForKey:@"fromDateTime"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *fromDate = [dateFormatter dateFromString:dateString];
    self.fromDateTime = fromDate;

    dateString = [d objectForKey:@"toDateTime"];
    NSDate *toDate = [dateFormatter dateFromString:dateString];
    self.toDateTime = toDate;
    
    self.rateAmount = [[d objectForKey:@"rateAmount"] floatValue];
    self.rateMeanDelta = [[d objectForKey:@"rateMeanDelta"] floatValue];
}
@end
