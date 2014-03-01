//
//  FBGenabilityStore.h
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSmartPriceSummary;

@interface FBGenabilityStore : NSObject

+ (FBGenabilityStore *)sharedStore;
- (void)getTariffs:(NSString *)zipCode forBlock:(void (^)(NSMutableArray *tariffsResult, NSError *err))block;
- (void)getPrice:(NSString *)masterTariffId withMonthlyConsumption:(int)monthlyConsumption forBlock:(void (^)(FBSmartPriceSummary *tariffRateSummary,NSError *err))block;

@end
