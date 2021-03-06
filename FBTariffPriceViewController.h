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
#import "FBHelpViewController.h"

@protocol TariffPriceViewDelegate;

@interface FBTariffPriceViewController : UIViewController <UIScrollViewDelegate, HelpViewDelegate>
{
    UIColor *tileBackgroundColor;
    FBHelpViewController *helpvc;
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
@property (weak, nonatomic) IBOutlet UIButton *buttonSetFavorite;
@property (assign, nonatomic) id <TariffPriceViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewLSETile;
- (IBAction)toggleFavorite:(id)sender;
- (id)initWithTariff:(FBTariff *)tariff;

- (void)updatePrice;
@end

@protocol TariffPriceViewDelegate

-(void)displayTariff:(NSString *)tariffId;

@end