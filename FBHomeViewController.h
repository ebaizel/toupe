//
//  FBHomeViewController.h
//  Toupe
//
//  Created by emileleon on 1/31/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"
#import "FBTariffPriceViewController.h"
#import "FBTariffDrawerViewController.h"

@interface FBHomeViewController : UIViewController <UIScrollViewDelegate, ADBannerViewDelegate, TariffDrawerDelegate>

{
    FBTariffDrawerViewController *tdvc;
    FBTariffPriceViewController *currentTpvc;
}


@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewCurrentPrice;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet ADBannerView *bannerAd;
@property (weak, nonatomic) IBOutlet UIButton *buttonSettings;
@property (weak, nonatomic) IBOutlet UIButton *buttonFAQ;
@property (weak, nonatomic) IBOutlet UIButton *buttonRefresh;

@property (strong, nonatomic) NSMutableArray *tariffs;
@property (strong, nonatomic) NSMutableArray *pageViews;

- (IBAction)refresh:(id)sender;
- (IBAction)displayFAQ:(id)sender;
- (IBAction)displaySettings:(id)sender;
- (IBAction)displayTariffDrawer:(id)sender;
@end
