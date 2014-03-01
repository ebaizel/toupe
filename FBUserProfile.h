//
//  FBUserProfile.h
//  Toupe
//
//  Created by emileleon on 12/17/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBLSE.h"

@interface FBUserProfile : NSObject <NSCoding>

@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *tariffIdTOU;
@property (nonatomic, strong) FBLSE *lse;
@property (nonatomic, strong) NSMutableArray *tariffs;
@property (nonatomic, assign) int monthlyConsumption;
@end
