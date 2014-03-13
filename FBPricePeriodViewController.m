//
//  FBPricePeriodViewController.m
//  Toupe
//
//  Created by emileleon on 3/1/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBPricePeriodViewController.h"
#import "FBPricePeriod.h"

@interface FBPricePeriodViewController ()

@end

@implementation FBPricePeriodViewController

- (id)initWithPricePeriod:(FBPricePeriod *)pricePeriod;
{
    self = [super init];
    if (!self) return self;
    
    self.pricePeriod = pricePeriod;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewBackground.backgroundColor = [UIColor skyBlueColor];

    // Set the Day Name
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:[_pricePeriod fromDateTime]];
    self.labelDayName.text = dayName;

    // Set the Price
//    self.labelPrice.text = [NSString stringWithFormat:@"%.2f¢", (self.pricePeriod.rateAmount * 100)];
    self.labelPrice.text = [NSString stringWithFormat:@"%@", [FBPricePeriod priceAsString:self.pricePeriod]];

    // Set the From To Time
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
    timeFormatter.dateFormat = @"HH:mm";
    NSString *fromDateString =[timeFormatter stringFromDate:self.pricePeriod.fromDateTime];
    NSString *toDateString =[timeFormatter stringFromDate:self.pricePeriod.toDateTime];
    self.labelFromToTime.text = [NSString stringWithFormat:@"%@ - %@", fromDateString, toDateString];
    
    if (self.pricePeriod.prevRateAmount > self.pricePeriod.rateAmount) {
        [[self imageArrow] setImage:[UIImage imageNamed:@"greenarrow.png"]];
    } else {
        // If it's the first element, we don't want to display anything
        if (self.pricePeriod.prevRateAmount == 0) {
            [[self imageArrow] setImage:nil];
        } else if (self.pricePeriod.prevRateAmount < self.pricePeriod.rateAmount) {
            [[self imageArrow] setImage:[UIImage imageNamed:@"redarrow.png"]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
