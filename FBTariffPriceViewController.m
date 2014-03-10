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
#import <QuartzCore/QuartzCore.h>
#import "FBPricePeriodViewController.h"
#import "Colours.h"


@interface FBTariffPriceViewController ()

@end

@implementation FBTariffPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tileBackgroundColor = [UIColor blueberryColor];
        [self setDefaults];
    }
    return self;
}

- (IBAction)setFavorite:(id)sender {
    [[[FBUserProfileStore sharedStore] userProfile] setFavorite:_tariff.lseId forTariffId:_tariff.masterTariffId];
    [[FBUserProfileStore sharedStore] saveUser];
    [self setFavoriteIcon];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatedFavorite" object:self];
}

- (IBAction)jumpToTariff:(id)sender {
}

-(void)setDefaults
{
    tileBackgroundColor = [UIColor blueberryColor];
    self.imageArrow = nil;
    self.labelAction1.text = @"";
    self.labelAction2.text = @"";
}

- (id)initWithTariff:(FBTariff *)tariff
{
    self = [super init];
    if (self) {
        self.tariff = tariff;
        [self setDefaults];
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
    
    // Add the last day
    if (oneDay) {
        [allDays addObject:oneDay];
        oneDay = nil;
    }

    // 3-1-14.  New and improved way
    int count = 0;
    int width, height;
    for (NSMutableArray *oneDayPrices in allDays) {
        for (FBPricePeriod *pricePeriod in oneDayPrices) {
            FBPricePeriodViewController *ppvc = [[FBPricePeriodViewController alloc]initWithPricePeriod:pricePeriod];
            [self addChildViewController:ppvc];
            [ppvc didMoveToParentViewController:self];
            width = ppvc.view.frame.size.width;
            height = ppvc.view.frame.size.height;
//            ppvc.viewBackground.layer.cornerRadius = 5.0;
//            ppvc.viewBackground.layer.masksToBounds = YES;
//            CGRect frame = CGRectMake(0, height*count + 21, width, height);
            CGRect frame = CGRectMake(0, height*count + count*2, width, height);
            ppvc.view.frame = frame;
            [self.scrollViewWeeklyPrice addSubview:ppvc.view];
            count++;
        }
    }
    
    CGSize scrollViewSize = self.scrollViewWeeklyPrice.frame.size;
    self.scrollViewWeeklyPrice.contentSize = CGSizeMake(scrollViewSize.width, height * count);
    NSLog(@"scroll content size is: %@", NSStringFromCGSize(self.scrollViewWeeklyPrice.contentSize));
    NSLog(@"scroll frame size is: %@", NSStringFromCGSize(scrollViewSize));

}

-(void)setCurrentDisplay:(FBSmartPriceSummary *)smartPriceSummary
{
    if (smartPriceSummary.priceChanges != nil) {
        
        // Set current price
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
        timeFormatter.dateFormat = @"HH:mm";
        
        FBPricePeriod *currentPrice = nil;
        if ([[smartPriceSummary priceChanges] count] > 0) {
            currentPrice = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:0];
        }
        
        if (currentPrice) {
            self.labelCurrentPrice.text = [NSString stringWithFormat:@" %.2f¢",(currentPrice.rateAmount * 100)];
            
            // Set arrow and action text
            FBPricePeriod *nextPrice = nil;
            if ([[smartPriceSummary priceChanges] count] > 1) {
                nextPrice = (FBPricePeriod *) [[smartPriceSummary priceChanges]objectAtIndex:1];
            }
            
            if (nextPrice!=nil) {
                [[self labelUpcomingPriceChanges] setHidden:NO];
                [[self scrollViewWeeklyPrice] setHidden:NO];
                
                NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
                [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
                timeFormatter.dateFormat = @"HH:mm";
                NSString *fromDateString =[timeFormatter stringFromDate:nextPrice.fromDateTime];
                
                if (nextPrice.rateAmount > currentPrice.rateAmount) {
                    [[self imageArrow] setImage:[UIImage imageNamed:@"redarrow.png"]];
                    [[self labelAction1] setText:[NSString stringWithFormat:@"Price goes up to %.2f¢ at %@.", (nextPrice.rateAmount * 100), fromDateString]];
                    [[self labelAction2] setText:@"Now is a good time to use electricity."];
                } else if (nextPrice.rateAmount < currentPrice.rateAmount) {
                    [[self imageArrow] setImage: [UIImage imageNamed:@"greenarrow.png"]];
                    [[self labelAction1] setText:[NSString stringWithFormat:@"Price goes down to %.2f¢ at %@.", (nextPrice.rateAmount * 100), fromDateString]];
                    [[self labelAction2] setText:@"Try to wait to use electricity."];
                }
            } else {
                // This is a steady price
                [[self imageArrow] setImage:nil];
                [[self labelAction1] setText:@"This rate plan has constant pricing."];
                [[self labelAction2] setText:@"Try a time of use plan for variable pricing."];
                [[self labelUpcomingPriceChanges] setHidden:YES];
                [[self scrollViewWeeklyPrice] setHidden:YES];
            }
        }

        // Add weekly prices to scroll view
        [self addDayPrices:[smartPriceSummary priceChanges]];
    }
}

- (void)updatePrice
{
    
    [[self activityIndicator] startAnimating];
    __weak FBTariffPriceViewController *weakSelf = self;
    
    FBUserProfile *user = [[FBUserProfileStore sharedStore] userProfile];
    
    [[FBGenabilityStore sharedStore] getPrice:[self.tariff masterTariffId] withMonthlyConsumption:[user monthlyConsumption] forBlock:^(FBSmartPriceSummary *smartPriceSummary, NSError *err) {

        [[weakSelf activityIndicator] stopAnimating];
        if (!err) {
            [self setCurrentDisplay:smartPriceSummary];
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

-(void)setFavoriteIcon
{
    FBUserProfile *user = [[FBUserProfileStore sharedStore]userProfile];
    if ([user isFavoriteTariff:_tariff.masterTariffId forLse:_tariff.lseId]) {
        NSLog(@"** tariff IS favorite");
        [[self buttonSetFavorite] setBackgroundColor:[UIColor clearColor]];
//        self.buttonSetFavorite = UIButton from
        [[self buttonSetFavorite] setBackgroundImage:[UIImage imageNamed:@"goldstar.png"] forState:UIControlStateNormal];
    } else {
        NSLog(@"** tariff IS NOT favorite");
        [[self buttonSetFavorite] setBackgroundColor:[UIColor clearColor]];
        [[self buttonSetFavorite] setBackgroundImage:[UIImage imageNamed:@"whitestar.png"] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    CGSize scrollViewSize = self.scrollViewWeeklyPrice.frame.size;
    self.scrollViewWeeklyPrice.contentSize = CGSizeMake(scrollViewSize.width, scrollViewSize.height * 2);
    
    NSString *tariffDisplayName = [NSString stringWithFormat:@"%@ - %@", self.tariff.tariffCode, self.tariff.tariffName];
    self.textTariffName.text = @"";
    self.labelTariffName.text = tariffDisplayName;
    self.labelLSEName.text = [NSString stringWithFormat:@"  %@",self.tariff.lseName];
    
    self.viewLSETile.layer.cornerRadius = 5.0;
    self.viewLSETile.layer.masksToBounds = YES;
    self.viewLSETile.backgroundColor = tileBackgroundColor;
    
    self.viewPricesTile.layer.cornerRadius = 5.0;
    self.viewPricesTile.layer.masksToBounds = YES;
    self.viewPricesTile.backgroundColor = tileBackgroundColor;

    FBUserProfile *user = [[FBUserProfileStore sharedStore] userProfile];
    NSString *imageURL = [NSString stringWithFormat:@"%@%@.png", BaseImageURL, user.lse.lseId];
    [self.imageLSE setImageWithURL:[NSURL URLWithString:imageURL]];
    
    [self updatePrice];
    [self setFavoriteIcon];
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
