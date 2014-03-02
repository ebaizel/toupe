//
//  FBPricePeriodViewController.h
//  Toupe
//
//  Created by emileleon on 3/1/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTariff.h"
#import "FBPricePeriod.h"

@interface FBPricePeriodViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelDayName;
@property (weak, nonatomic) IBOutlet UILabel *labelFromToTime;
@property (weak, nonatomic) IBOutlet UIView *viewColorBar;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;

@property (strong, nonatomic) FBPricePeriod *pricePeriod;
@property (strong, nonatomic) FBTariff *tariff;

- (id)initWithPricePeriod:(FBPricePeriod *)pricePeriod;

@end
