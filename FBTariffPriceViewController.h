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
{
    UIColor *tileBackgroundColor;
}

@property (strong, nonatomic) FBTariff *tariff;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentPrice;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageLSE;

@property (weak, nonatomic) IBOutlet UITextView *textTariffName;
@property (weak, nonatomic) IBOutlet UILabel *labelTariffName;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewWeeklyPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelLSEName;
@property (weak, nonatomic) IBOutlet UIView *viewPricesTile;
@property (weak, nonatomic) IBOutlet UILabel *labelAction1;
@property (weak, nonatomic) IBOutlet UILabel *labelAction2;
@property (weak, nonatomic) IBOutlet UIImageView *imageArrow;
@property (weak, nonatomic) IBOutlet UILabel *labelUpcomingPriceChanges;

@property (weak, nonatomic) IBOutlet UIView *viewLSETile;
- (IBAction)buttonpressed:(id)sender;
- (id)initWithTariff:(FBTariff *)tariff;
@end
