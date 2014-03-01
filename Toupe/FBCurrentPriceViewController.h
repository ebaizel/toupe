//
//  FBCurrentPriceViewController.h
//  Toupe
//
//  Created by emileleon on 12/3/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface FBCurrentPriceViewController : UIViewController <ADBannerViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray *prices;
}
@property (weak, nonatomic) IBOutlet UILabel *nextPrice1Time;
@property (weak, nonatomic) IBOutlet UILabel *nextPrice2Time;
@property (weak, nonatomic) IBOutlet UILabel *nextPrice3Time;

@property (weak, nonatomic) IBOutlet UIView *currentPriceView;
@property (weak, nonatomic) IBOutlet UIView *nextPrice1View;
@property (weak, nonatomic) IBOutlet UIView *nextPrice2View;
@property (weak, nonatomic) IBOutlet UIView *nextPrice3View;
@property (weak, nonatomic) IBOutlet UIView *bottomFillerView;


@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *nextPrice1;
@property (weak, nonatomic) IBOutlet UILabel *nextPrice2;
@property (weak, nonatomic) IBOutlet UILabel *nextPrice3;
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;
@property (weak, nonatomic) IBOutlet UIButton *buttonFAQ;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetup;
@property (weak, nonatomic) IBOutlet UIButton *buttonCalculator;
@property (weak, nonatomic) IBOutlet UIButton *buttonRefresh;

- (IBAction)refreshPrice:(id)sender;
- (IBAction)displayFAQ:(id)sender;
- (IBAction)displaySetup:(id)sender;
@end
