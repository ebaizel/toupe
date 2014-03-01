//
//  FBTariffRateSummary.h
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface FBSmartPriceSummary : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *masterTariffId;
@property (nonatomic, strong) NSString *tariffName;
@property (nonatomic, strong) NSDate *fromDateTime;
@property (nonatomic, strong) NSDate *toDateTime;
@property (nonatomic) float rateMean;
@property (nonatomic) float rateStandardDeviation;
@property (nonatomic, strong) NSArray *priceChanges;


@end
