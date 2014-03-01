//
//  FBDayPriceViewController.m
//  Toupe
//
//  Created by emileleon on 2/4/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBDayPricePeriodViewController.h"
#import "FBPricePeriod.h"

@interface FBDayPricePeriodViewController ()

@end

@implementation FBDayPricePeriodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPricePeriod:(FBPricePeriod *)pricePeriod
{
    self = [super init];
    if (!self) return self;
    self.pricePeriod = pricePeriod;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelPrice.text = [NSString stringWithFormat:@"%.2f", (self.pricePeriod.rateAmount * 100)];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
    timeFormatter.dateFormat = @"HH:mm";
    
    NSString *fromDateString =[timeFormatter stringFromDate:self.pricePeriod.fromDateTime];
    NSString *toDateString =[timeFormatter stringFromDate:self.pricePeriod.toDateTime];
    self.labelTime.text = [NSString stringWithFormat:@"%@ - %@", fromDateString, toDateString];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
