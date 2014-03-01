//
//  FBCurrentPriceViewController.m
//  Toupe
//
//  Created by emileleon on 12/3/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBCurrentPriceViewController.h"
#import "FBGenabilityStore.h"
#import "FBSmartPriceSummary.h"
#import "FBPricePeriod.h"
#import "Colours.h"
#import "FBFAQViewController.h"
#import "FBEnterZipCodeViewController.h"
#import "FBUserProfile.h"
#import "FBUserProfileStore.h"

@interface FBCurrentPriceViewController ()

@end

@implementation FBCurrentPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self navigationItem] setTitle:@"FAQ"];
//    [[self currentPriceView] setBackgroundColor:BaseColor];
//    [[self nextPrice1View] setBackgroundColor:BaseColor];
//    [[self nextPrice2View] setBackgroundColor:BaseColor];
//    [[self nextPrice3View] setBackgroundColor:BaseColor];
//    [[self bottomFillerView] setBackgroundColor:BaseColor];
    
    [[self currentPriceView] setBackgroundColor:[UIColor clearColor]];
    [[self nextPrice1View] setBackgroundColor:[UIColor clearColor]];
    [[self nextPrice2View] setBackgroundColor:[UIColor clearColor]];
    [[self nextPrice3View] setBackgroundColor:[UIColor clearColor]];
    [[self bottomFillerView] setBackgroundColor:[UIColor clearColor]];
    
    
    [[self buttonFAQ] setImage:[UIImage imageNamed:@"faq.png"] forState:UIControlStateNormal];
    [[self buttonSetup] setImage:[UIImage imageNamed:@"tool.png"] forState:UIControlStateNormal];
    [[self buttonSetup] setTintColor:[UIColor brickRedColor]];
    [[self buttonCalculator] setImage:[UIImage imageNamed:@"calculator.png"] forState:UIControlStateNormal];
    [[self buttonRefresh] setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [[self buttonRefresh] setTintColor:[UIColor blueberryColor]];

    // Setup the background
    UIImageView *backgroundView;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        // code for 4-inch screen
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ciudad640x1136.png"]];
    } else {
        // code for 3.5-inch screen
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ciudad640x960.png"]];
    }
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self updatePrice];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)updatePrice
{
    // Spinner
    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    __weak FBCurrentPriceViewController *weakSelf = self;
    
    FBUserProfile *user = [[FBUserProfileStore sharedStore] userProfile];
        
    [[FBGenabilityStore sharedStore] getPrice:[user tariffIdTOU] withMonthlyConsumption:[user monthlyConsumption] forBlock:^(FBSmartPriceSummary *smartPriceSummary, NSError *err) {

        [[weakSelf navigationItem] setTitleView:currentTitleView];
        if (!err) {
            
            if (smartPriceSummary.priceChanges != nil) {
                
                NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
                [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
                timeFormatter.dateFormat = @"HH:mm";
                
                if (smartPriceSummary.priceChanges[0]!=nil) {
                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:0];
                    self.currentPrice.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
                }
                
                if ((smartPriceSummary.priceChanges.count > 1) && (smartPriceSummary.priceChanges[1]!=nil)) {
                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:1];
                    self.nextPrice1.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
                    self.nextPrice1Time.text = [timeFormatter stringFromDate: [price fromDateTime]];
                }

                if ((smartPriceSummary.priceChanges.count > 2) && (smartPriceSummary.priceChanges[2]!=nil)) {
                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:2];
                    self.nextPrice2.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
                    self.nextPrice2Time.text = [timeFormatter stringFromDate: [price fromDateTime]];
                }

                if ((smartPriceSummary.priceChanges.count > 3) && (smartPriceSummary.priceChanges[3]!=nil)) {
                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:3];
                    self.nextPrice3.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
                    self.nextPrice3Time.text = [timeFormatter stringFromDate: [price fromDateTime]];
                }

            }
            
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshPrice:(id)sender {
    [self updatePrice];
}

- (IBAction)displayFAQ:(id)sender {
    [[self navigationController] pushViewController:[[FBFAQViewController alloc] init] animated:YES];
}

- (IBAction)displaySetup:(id)sender {
    [[self navigationController] pushViewController:[[FBEnterZipCodeViewController alloc] init] animated:YES];
}
@end
