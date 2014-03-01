//
//  FBTariffPriceViewController.h
//  Toupe
//
//  Created by emileleon on 2/2/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTariff.h"
#import "FBDayViewController.h"

@interface FBTariffPriceViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) FBTariff *tariff;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentPrice;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageLSE;
@property (weak, nonatomic) IBOutlet UIView *viewImageBackground;
@property (weak, nonatomic) IBOutlet UITextView *textTariffName;
@property (weak, nonatomic) IBOutlet UITextView *textTariffDescription;
//@property (strong, nonatomic) FBWeeklyPriceViewController *weeklyPriceViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewWeeklyPrice;
@property (weak, nonatomic) IBOutlet UIView *viewLSENameBackground;
@property (weak, nonatomic) IBOutlet UILabel *labelLSEName;
@property (weak, nonatomic) IBOutlet UIView *viewUpcomingLabelBackground;

- (IBAction)buttonpressed:(id)sender;
- (id)initWithTariff:(FBTariff *)tariff;
@end
