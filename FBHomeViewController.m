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
#import "FBTariffDrawerViewController.h"
#import "FBUserProfileStore.h"

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

- (void)selectTariff:(NSString *)tariffId
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self displayTariff:tariffId];
    }];
}

- (void)dismissHelp:(BOOL)alwaysShow
{
    [helpvc.view removeFromSuperview];
    helpvc = nil;
    [[[FBUserProfileStore sharedStore] userProfile] setShowHelp:alwaysShow];
    [[FBUserProfileStore sharedStore] saveUser];
}

- (IBAction)displayTariffDrawer:(id)sender {
    tdvc = [[FBTariffDrawerViewController alloc]init];
    tdvc.delegate = self;
    [tdvc setSelectedTariff:(FBTariff *)[[self tariffs] objectAtIndex:[self getCurrentPage]]];
    [self presentViewController:tdvc animated:YES completion:nil];
}

- (void)dismissDrawer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)displayFAQ:(id)sender {
    faqvc = [[FBFAQViewController alloc]init];
    faqvc.delegate = self;
//    [self presentViewController:faqvc animated:YES completion:nil];
    [[self navigationController] pushViewController:faqvc animated:YES];
}


- (void)dismissFAQ
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reset
{
//    [[self navigationController] popToRootViewControllerAnimated:NO];
    UINavigationController *navc = [self navigationController];
    NSLog(@"*** number of controllers on stack are %lu", (unsigned long)navc.viewControllers.count);
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
    
    if (helpvc) {
        [self.view bringSubviewToFront:helpvc.view];
        helpvc.view.layer.zPosition = 10;
    }

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
//    UIView *pageView = [self.pageViews objectAtIndex:page];
//    if ((NSNull*)pageView != [NSNull null]) {
//        [pageView removeFromSuperview];
//        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
//    }
    
    FBTariffPriceViewController *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView.view removeFromSuperview];
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

- (NSInteger)getCurrentPage
{
    CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewCurrentPrice.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    return page;
}

- (void)loadVisiblePages {
    
    // First, determine which page is currently visible
//    CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
//    NSInteger page = (NSInteger)floor((self.scrollViewCurrentPrice.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    //[self loadPageAtIndex:page];
    // Update the page control
    NSInteger page = [self getCurrentPage];
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
    [self setPageLabel];
}

- (void)setPageLabel
{
    self.labelPageOfPage.text = [NSString stringWithFormat:@"%d of %ld", ([self getCurrentPage] +1), (unsigned long)[[self tariffs]count]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[self buttonFAQ] setImage:[UIImage imageNamed:@"faq.png"] forState:UIControlStateNormal];
    [[self buttonFAQ] setTintColor:[UIColor whiteColor]];
    [[self buttonSettings] setImage:[UIImage imageNamed:@"tool.png"] forState:UIControlStateNormal];
    [[self buttonSettings] setTintColor:[UIColor whiteColor]];
    [[self buttonRefresh] setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [[self buttonRefresh] setTintColor:[UIColor whiteColor]];
    
    self.scrollViewCurrentPrice.pagingEnabled=YES;
    self.pageControl.pageIndicatorTintColor = [UIColor blueberryColor];
    [self setPageLabel];
    self.view.backgroundColor = [UIColor skyBlueColor];

    
    if ([[[FBUserProfileStore sharedStore] userProfile]showHelp]) {
        helpvc = [[FBHelpViewController alloc] init];
        helpvc.delegate = self;        
//        CGRect screenRect = [[UIScreen mainScreen] bounds];
//        UIView* coverView = [[UIView alloc] initWithFrame:screenRect];
//        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//        helpvc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self.view addSubview:helpvc.view];
    }
    
    
    //    [[self buttonTariffDrawer] setBackgroundColor:[UIColor clearColor]];
    //    [[self buttonTariffDrawer] setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    
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
    
    [self refreshEverything];
}


- (void)refreshEverything
{
    // Remove all subviews of the scrollview
    self.tariffs = [[[FBUserProfileStore sharedStore] userProfile] tariffs];
    
    self.pageControl.numberOfPages = [_tariffs count];
    NSLog(@"**number of pages is %li", (long)self.pageControl.numberOfPages);
    
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
        numPages = (unsigned int)self.tariffs.count;
    }
    [self setPageLabel];
    [[self pageControl] setNumberOfPages:numPages];

}

- (void)loadPage:(NSInteger)page {
    
    if (page < 0 || page >= self.tariffs.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
//    UIView *pageView = [self.pageViews objectAtIndex:page];
//    UIView *pageView = ([self.pageViews objectAtIndex:page] != [NSNull null] ? [[self.pageViews objectAtIndex:page]view] : [NSNull null]);
    FBTariffPriceViewController *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {

        CGRect frame = self.scrollViewCurrentPrice.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
//        UIView *newView = [[UIView alloc]init];
        FBTariffPriceViewController *tpvc = [[FBTariffPriceViewController alloc]initWithTariff:[self.tariffs objectAtIndex:page]];
        [tpvc.view setFrame:frame];
        [self addChildViewController:tpvc];
        [tpvc didMoveToParentViewController:self];

//        newView.frame = frame;
//        newView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];

        [self.scrollViewCurrentPrice addSubview:tpvc.view];
        tpvc.view.layer.zPosition = 1;
        //[self.pageViews replaceObjectAtIndex:page withObject:tpvc.view];
        [self.pageViews replaceObjectAtIndex:page withObject:tpvc];
        NSLog(@"scroll view is %@", NSStringFromCGPoint(self.scrollViewCurrentPrice.contentOffset));
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refresh:(id)sender {
    
    NSLog(@"refreshing");
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewCurrentPrice.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    if (firstPage < 0) firstPage = 0;
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        FBTariffPriceViewController *ctpvc = (FBTariffPriceViewController *)[self.pageViews objectAtIndex:page];
        [ctpvc updatePrice];
    }
}



- (IBAction)displaySettings:(id)sender {
//    FBEnterZipCodeViewController *ezcvc = [[FBEnterZipCodeViewController alloc]init];
//    [[self navigationController] pushViewController:ezcvc animated:YES];
    FBSettingsViewController *svc = [[FBSettingsViewController alloc]init];
    [[self navigationController] pushViewController:svc animated:YES];
}

@end
