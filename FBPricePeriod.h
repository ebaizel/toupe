//
//  FBPriceChanges.h
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface FBPricePeriod : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *name;
@property (nonatomic) float rateAmount;
@property (nonatomic) float nextRateAmount;
@property (nonatomic) float prevRateAmount;
@property (nonatomic) float rateMeanDelta;
@property (nonatomic, copy) NSDate *fromDateTime;
@property (nonatomic, copy) NSDate *toDateTime;

+(NSString *)priceAsString:(FBPricePeriod *)pricePeriod;
@end
