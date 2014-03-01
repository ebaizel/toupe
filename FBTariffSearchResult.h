//
//  FBTariffSearchResult.h
//  Toupe
//
//  Created by emileleon on 1/29/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface FBTariffSearchResult : NSObject <JSONSerializable>

@property (nonatomic, strong) NSMutableArray *tariffs;

@end
