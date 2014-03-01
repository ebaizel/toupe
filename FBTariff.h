//
//  FBTariff.h
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface FBTariff : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *masterTariffId;
@property (nonatomic, strong) NSString *tariffName;
@property (nonatomic, strong) NSString *tariffCode;
@property (nonatomic, strong) NSString *tariffType;  //default, alternative
@property (nonatomic, strong) NSString *lseId;
@property (nonatomic, strong) NSString *lseName;
@property (nonatomic, assign) float customerLikelihood;
@property (nonatomic, assign) BOOL hasTimeOfUseRates;

@end
