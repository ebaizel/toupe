//
//  FBWeeklyPriceViewController.m
//  Toupe
//
//  Created by emileleon on 2/4/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBDayViewController.h"
#import "FBDayPricePeriodViewController.h"
#import "FBPricePeriod.h"

@interface FBDayViewController ()

@end

@implementation FBDayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPricePeriods:(NSArray *)pricePeriods;
{
    self = [super init];
    if (!self) return self;
    
    self.pricePeriods = pricePeriods;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    if (_pricePeriods && _pricePeriods.count > 0) {
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *dayName = [dateFormatter stringFromDate:[(FBPricePeriod *)[_pricePeriods objectAtIndex:0] fromDateTime]];
        self.labelDayName.text = dayName;

        int count = 0;
        for (FBPricePeriod *pricePeriod in self.pricePeriods) {
            FBDayPricePeriodViewController *dppvc = [[FBDayPricePeriodViewController alloc]initWithPricePeriod:pricePeriod];
            [self addChildViewController:dppvc];
            [dppvc didMoveToParentViewController:self];
            int width = dppvc.view.frame.size.width;
            int height = dppvc.view.frame.size.height;
            CGRect frame = CGRectMake((width * count) + (10 * (count + 1)), 20, width, height);
            dppvc.view.frame = frame;
            [self.view addSubview:dppvc.view];
            count++;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
