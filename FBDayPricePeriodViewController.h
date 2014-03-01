//
//  FBDayPriceViewController.h
//  Toupe
//
//  Created by emileleon on 2/4/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBPricePeriod;

@interface FBDayPricePeriodViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) FBPricePeriod *pricePeriod;

- (id)initWithPricePeriod:(FBPricePeriod *)pricePeriod;

@end
