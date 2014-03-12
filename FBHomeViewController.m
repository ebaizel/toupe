//
//  FBHomeViewController.m
//  Toupe
//
//  Created by emileleon on 1/31/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBHomeViewController.h"
#import "FBTariffPriceViewController.h"
#import "FBFAQViewController.h"
#import "FBEnterZipCodeViewController.h"
#import "FBUserProfileStore.h"
#import "QuartzCore/QuartzCore.h"
#import "Colours.h"
#import "FBSettingsViewController.h"
#import "FBWelcomeViewController.h"

@interface FBHomeViewController ()

@end

@implementation FBHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshEverything)
                                                     name:@"LSEUpdated" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshEverything)
                                                     name:@"UpdatedUserSettings" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reset)
                                                     name:@"ResetUserSettings" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshEverything)
                                                     name:@"UpdatedFavorite" object:nil];
    }
    return self;
}

- (void)reset
{
//    [[self navigationController] popToRootViewControllerAnimated:NO];
    UINavigationController *navc = [self navigationController];
    NSLog(@"*** number of controllers on stack are %i", navc.viewControllers.count);
    FBWelcomeViewController *welcomeVC = [[FBWelcomeViewController alloc]init];
    welcomeVC.isRootView = YES;
    [[self navigationController] pushViewController:welcomeVC animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    CGSize pagesScrollViewSize = self.scrollViewCurrentPrice.frame.size;
    self.scrollViewCurrentPrice.contentSize = CGSizeMake(pagesScrollViewSize.width * self.tariffs.count, pagesScrollViewSize.height - 200);
    [self loadVisiblePages];
    
//    int numPages = 8;
//    if ([self.tariffs count] < numPages) {
//        numPages = self.tariffs.count;
//    }
//    [[self pageControl] setNumberOfPages:numPages];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.tariffs.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)displayTariff:(NSString *)tariffId
{
    FBTariff *selectedTariff = nil;
    NSInteger count = 0;
    for (FBTariff *tariff in self.tariffs) {
        if ([tariff.masterTariffId isEqualToString:tariffId]) {
            selectedTariff = tariff;
            break;
        } else {
            count++;
        }
    }
    
    if (selectedTariff) {
        //Move the scroll view content offset
        self.pageControl.currentPage = (count > _tariffs.count ? _tariffs.count : count);
        CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
        CGPoint newOffset = CGPointMake(pageWidth * count, 0);
        [self.scrollViewCurrentPrice setContentOffset:newOffset animated:NO];
    }
}

//- (void)loadPageAtIndex:(NSInteger)page
//{
//    // Update the page control
//    self.pageControl.currentPage = page;
//    
//    // Work out which pages you want to load
//    NSInteger firstPage = page - 1;
//    NSInteger lastPage = page + 1;
//    
//    // Purge anything before the first page
//    for (NSInteger i=0; i<firstPage; i++) {
//        [self purgePage:i];
//    }
//    
//    if (firstPage < 0) firstPage = 0;
//    
//	// Load pages in our range
//    for (NSInteger i=firstPage; i<=lastPage; i++) {
//        [self loadPage:i];
//    }
//    
//	// Purge anything after the last page
//    for (NSInteger i=lastPage+1; i<self.tariffs.count; i++) {
//        [self purgePage:i];
//    }
//}

- (void)loadVisiblePages {
    
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewCurrentPrice.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    //[self loadPageAtIndex:page];
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
    if (firstPage < 0) firstPage = 0;
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.tariffs.count; i++) {
        [self purgePage:i];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self buttonFAQ] setImage:[UIImage imageNamed:@"faq.png"] forState:UIControlStateNormal];
    [[self buttonFAQ] setTintColor:[UIColor whiteColor]];
    [[self buttonSettings] setImage:[UIImage imageNamed:@"tool.png"] forState:UIControlStateNormal];
    [[self buttonSettings] setTintColor:[UIColor whiteColor]];
    
    self.scrollViewCurrentPrice.pagingEnabled=YES;
    self.pageControl.pageIndicatorTintColor = [UIColor blueberryColor];
    
    // Setup the background
//    UIImageView *backgroundView;
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    if (screenBounds.size.height == 568) {
//        // code for 4-inch screen
//        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueorange640x1136.png"]];
//    } else {
//        // code for 3.5-inch screen
//        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueorange640x960.png"]];
//    }
//    [self.view addSubview:backgroundView];
//    [self.view sendSubviewToBack:backgroundView];
    
//    self.view.backgroundColor = [UIColor icebergColor];
    self.view.backgroundColor = [UIColor skyBlueColor];
//    self.view.backgroundColor = [UIColor moneyGreenColor];
//    self.view.backgroundColor = [UIColor hollyGreenColor];

//    self.scrollViewWeeklyPrices = (UIScrollView *)self.weeklyPriceViewController.view;
    
    [self refreshEverything];
}


- (void)refreshEverything
{
    // Remove all subviews of the scrollview
    self.tariffs = [[[FBUserProfileStore sharedStore] userProfile] tariffs];
    
    self.pageControl.numberOfPages = [_tariffs count];
    NSLog(@"**number of pages is %i", self.pageControl.numberOfPages);
    
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _tariffs.count; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    
    FBTariff *selectedTariff = nil;
    FBTariff *firstTariff = (FBTariff *)[[self tariffs]objectAtIndex:0];
    if (firstTariff) {
        NSString *favoriteTariffId = [[[FBUserProfileStore sharedStore]userProfile]getFavoriteTariff:firstTariff.lseId];
        NSInteger count = 0;
        for (FBTariff *tariff in self.tariffs) {
            if ([tariff.masterTariffId isEqualToString:favoriteTariffId]) {
                selectedTariff = tariff;
                break;
            } else {
                count++;
            }
        }
        
        if (selectedTariff) {
            //Move the scroll view content offset
            self.pageControl.currentPage = count;
            CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
            CGPoint newOffset = CGPointMake(pageWidth * count, 0);
            [self.scrollViewCurrentPrice setContentOffset:newOffset animated:NO];

        } else {
            self.pageControl.currentPage = 0;
            CGPoint point = CGPointMake(0.0f, 0.0f);
            self.scrollViewCurrentPrice.contentOffset = point;
        }
    } else {
        self.pageControl.currentPage = 0;
        CGPoint point = CGPointMake(0.0f, 0.0f);
        self.scrollViewCurrentPrice.contentOffset = point;
    }
    
    int numPages = 8;
    if ([self.tariffs count] < numPages) {
        numPages = (unsigned long)self.tariffs.count;
    }
    [[self pageControl] setNumberOfPages:numPages];

}

- (void)loadPage:(NSInteger)page {
    
    if (page < 0 || page >= self.tariffs.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {

        CGRect frame = self.scrollViewCurrentPrice.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
//        UIView *newView = [[UIView alloc]init];
        FBTariffPriceViewController *tpvc = [[FBTariffPriceViewController alloc]initWithTariff:[self.tariffs objectAtIndex:page]];
        [tpvc setDelegate:self];
        [tpvc.view setFrame:frame];
        [self addChildViewController:tpvc];
        [tpvc didMoveToParentViewController:self];

//        newView.frame = frame;
//        newView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];

        [self.scrollViewCurrentPrice addSubview:tpvc.view];
        tpvc.view.layer.zPosition = 1;
        [self.pageViews replaceObjectAtIndex:page withObject:tpvc.view];
        NSLog(@"scroll view is %@", NSStringFromCGPoint(self.scrollViewCurrentPrice.contentOffset));
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayFAQ:(id)sender {
    [[self navigationController] pushViewController:[[FBFAQViewController alloc] init] animated:YES];
}

- (IBAction)displaySettings:(id)sender {
//    FBEnterZipCodeViewController *ezcvc = [[FBEnterZipCodeViewController alloc]init];
//    [[self navigationController] pushViewController:ezcvc animated:YES];
    FBSettingsViewController *svc = [[FBSettingsViewController alloc]init];
    [[self navigationController] pushViewController:svc animated:YES];
}
@end
