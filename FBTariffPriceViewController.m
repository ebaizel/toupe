//
//  FBTariffPriceViewController.m
//  Toupe
//
//  Created by emileleon on 2/2/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBTariffPriceViewController.h"
#import "FBTariff.h"
#import "FBGenabilityStore.h"
#import "FBUserProfile.h"
#import "FBUserProfileStore.h"
#import "FBSmartPriceSummary.h"
#import "FBPricePeriod.h"
#import "FBLSE.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "FBDayViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FBTariffPriceViewController ()

@end

@implementation FBTariffPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)buttonpressed:(id)sender {
    NSLog(@"button was pressed!");
}

- (id)initWithTariff:(FBTariff *)tariff
{
    self = [super init];
    if (self) {
        self.tariff = tariff;
    }
    
    return self;
}

- (void)addDayPrices:(NSArray *)priceChanges
{
    
    // Break out price periods into arrays, one for each day
    NSMutableArray *allDays = [[NSMutableArray alloc] init];
    NSMutableArray *oneDay = nil;
    NSInteger prevDay = 0;
    for (FBPricePeriod *pricePeriod in priceChanges) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[pricePeriod fromDateTime]];
        NSInteger day = [components day];
        if (!oneDay) {
            oneDay = [[NSMutableArray alloc]init];
            [oneDay addObject:pricePeriod];
            prevDay = day;
        } else {
            if (prevDay == day) {
                [oneDay addObject:pricePeriod];
                prevDay = day;
            } else {
                [allDays addObject:oneDay];
                oneDay = [[NSMutableArray alloc]init];
                [oneDay addObject:pricePeriod];
                prevDay = day;
            }
        }
    }
    
    if (oneDay) {
        [allDays addObject:oneDay];
        oneDay = nil;
    }
    
    // Add each day as a subview
    int count = 0;
    int width, height;
    for (NSMutableArray *oneDayPrices in allDays) {
        FBDayViewController *dvc = [[FBDayViewController alloc]initWithPricePeriods:oneDayPrices];
        [self addChildViewController:dvc];
        [dvc didMoveToParentViewController:self];
        width = dvc.view.frame.size.width;
        height = dvc.view.frame.size.height;
        CGRect frame = CGRectMake(0, height*count + 15, width, height);
        dvc.view.frame = frame;
        [self.scrollViewWeeklyPrice addSubview:dvc.view];
        count++;
    }

    CGSize scrollViewSize = self.scrollViewWeeklyPrice.frame.size;
    self.scrollViewWeeklyPrice.contentSize = CGSizeMake(scrollViewSize.width, height * count);
    NSLog(@"scroll content size is: %@", NSStringFromCGSize(self.scrollViewWeeklyPrice.contentSize));
    NSLog(@"scroll frame size is: %@", NSStringFromCGSize(scrollViewSize));
}

- (void)updatePrice
{
    
    [[self activityIndicator] startAnimating];
    __weak FBTariffPriceViewController *weakSelf = self;
    
    FBUserProfile *user = [[FBUserProfileStore sharedStore] userProfile];
    
    [[FBGenabilityStore sharedStore] getPrice:[self.tariff masterTariffId] withMonthlyConsumption:[user monthlyConsumption] forBlock:^(FBSmartPriceSummary *smartPriceSummary, NSError *err) {

        [[weakSelf activityIndicator] stopAnimating];
        if (!err) {
            
            if (smartPriceSummary.priceChanges != nil) {
                
                NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
                [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
                timeFormatter.dateFormat = @"HH:mm";
                
                if (smartPriceSummary.priceChanges[0]!=nil) {
                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:0];
                    self.labelCurrentPrice.text = [NSString stringWithFormat:@" %.2f¢",(price.rateAmount * 100)];
                }
                
                // Add weekly prices to scroll view
                [self addDayPrices:[smartPriceSummary priceChanges]];

//                if ((smartPriceSummary.priceChanges.count > 1) && (smartPriceSummary.priceChanges[1]!=nil)) {
//                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:1];
//                    self.nextPrice1.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
//                    self.nextPrice1Time.text = [timeFormatter stringFromDate: [price fromDateTime]];
//                }
//                
//                if ((smartPriceSummary.priceChanges.count > 2) && (smartPriceSummary.priceChanges[2]!=nil)) {
//                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:2];
//                    self.nextPrice2.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
//                    self.nextPrice2Time.text = [timeFormatter stringFromDate: [price fromDateTime]];
//                }
//                
//                if ((smartPriceSummary.priceChanges.count > 3) && (smartPriceSummary.priceChanges[3]!=nil)) {
//                    FBPricePeriod *price = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:3];
//                    self.nextPrice3.text = [NSString stringWithFormat:@"%.2f ¢",(price.rateAmount * 100)];
//                    self.nextPrice3Time.text = [timeFormatter stringFromDate: [price fromDateTime]];
//                }
                
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

- (void)viewWillAppear:(BOOL)animated
{
    CGSize scrollViewSize = self.scrollViewWeeklyPrice.frame.size;
    self.scrollViewWeeklyPrice.contentSize = CGSizeMake(scrollViewSize.width, scrollViewSize.height * 2);
    self.scrollViewWeeklyPrice.backgroundColor = [UIColor steelBlueColor];
    self.scrollViewWeeklyPrice.layer.cornerRadius = 5.0;
    self.scrollViewWeeklyPrice.layer.masksToBounds = YES;
    
    NSString *tariffDisplayName = [NSString stringWithFormat:@"%@ - %@", self.tariff.tariffCode, self.tariff.tariffName];
    self.textTariffName.text = tariffDisplayName;
    self.textTariffName.layer.cornerRadius = 5.0;
    self.textTariffName.layer.masksToBounds = YES;
    self.textTariffName.backgroundColor = [UIColor steelBlueColor];

    self.viewImageBackground.layer.cornerRadius = 5.0;
    self.viewImageBackground.layer.masksToBounds = YES;
    self.viewImageBackground.backgroundColor = [UIColor steelBlueColor];
    
    self.viewLSENameBackground.layer.cornerRadius = 5.0;
    self.viewLSENameBackground.layer.masksToBounds = YES;
    self.viewLSENameBackground.backgroundColor = [UIColor steelBlueColor];

    self.labelLSEName.text = self.tariff.lseName;
    
    self.labelCurrentPrice.layer.cornerRadius = 5.0;
    self.labelCurrentPrice.layer.masksToBounds = YES;
    self.labelCurrentPrice.backgroundColor = [UIColor steelBlueColor];
    
    NSString *tariffDescription;
    if ([self.tariff.tariffType isEqualToString:@"DEFAULT"]) {
        tariffDescription = [NSString stringWithFormat:@"This is the standard rate plan offered to residential customers.  Standard plans tend to have constant pricing at all times of day, limiting opportunities to save money."];
    } else {
        tariffDescription = [NSString stringWithFormat:@"This rate plan is an alternative to the standard default rate plan.  Contact %@ to see if you are eligible to switch to this plan.", self.tariff.lseName];
    }
    self.textTariffDescription.text = tariffDescription;
    self.textTariffDescription.layer.cornerRadius = 5.0;
    self.textTariffDescription.layer.masksToBounds = YES;
    self.textTariffDescription.backgroundColor = [UIColor steelBlueColor];
    
    FBUserProfile *user = [[FBUserProfileStore sharedStore] userProfile];
    NSString *imageURL = [NSString stringWithFormat:@"%@%@.png", BaseImageURL, user.lse.lseId];
    [self.imageLSE setImageWithURL:[NSURL URLWithString:imageURL]];
    self.imageLSE.layer.cornerRadius = 2.0;
    self.imageLSE.layer.masksToBounds = YES;
    
    [self updatePrice];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
