//
//  FBWeeklyPriceViewController.h
//  Toupe
//
//  Created by emileleon on 2/4/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBTariff;

@interface FBDayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelDayName;
@property (strong, nonatomic) NSArray *pricePeriods;
@property (strong, nonatomic) FBTariff *tariff;

- (id)initWithPricePeriods:(NSArray *)pricePeriods;

@end
