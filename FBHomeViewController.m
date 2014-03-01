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
    }
    return self;
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
    
    int numPages = 8;
    if ([self.tariffs count] < numPages) {
        numPages = self.tariffs.count;
    }
    [[self pageControl] setNumberOfPages:numPages];

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

- (void)loadVisiblePages {
    
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollViewCurrentPrice.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewCurrentPrice.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    //    NSInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth);
    //    NSInteger page = floor((self.scrollView.contentOffset.x) / (pageWidth / 4));
    
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
    
    self.view.backgroundColor = [UIColor icebergColor];
    
//    self.scrollViewWeeklyPrices = (UIScrollView *)self.weeklyPriceViewController.view;
    
    [self refreshEverything];
}

- (void)refreshEverything
{
    // Remove all subviews of the scrollview
//    [self.scrollViewCurrentPrice.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGPoint point = CGPointMake(0.0f, 0.0f);
    self.scrollViewCurrentPrice.contentOffset = point;
    
    self.tariffs = [[[FBUserProfileStore sharedStore] userProfile] tariffs];
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [_tariffs count];
    
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _tariffs.count; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    
//    CGSize pagesScrollViewSize = self.scrollView.frame.size;
//    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.tariffs.count, pagesScrollViewSize.height - 200);
//    [self loadVisiblePages];
//    
//    int numPages = 8;
//    if ([self.tariffs count] < numPages) {
//        numPages = self.tariffs.count;
//    }
//    [[self pageControl] setNumberOfPages:numPages];

    // Purge all pages
//    for (int i=0; i < [_tariffs count]; i++) {
//        [self purgePage:i];
//    }
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
        [tpvc.view setFrame:frame];
        [self addChildViewController:tpvc];
        [tpvc didMoveToParentViewController:self];

//        newView.frame = frame;
//        newView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];

        [self.scrollViewCurrentPrice addSubview:tpvc.view];
        tpvc.view.layer.zPosition = 1;
        [self.pageViews replaceObjectAtIndex:page withObject:tpvc.view];
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
    [[self navigationController] pushViewController:[[FBEnterZipCodeViewController alloc] init] animated:YES];
}
@end
