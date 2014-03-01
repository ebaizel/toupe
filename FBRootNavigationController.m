//
//  FBRootNavigationController.m
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBRootNavigationController.h"
#import "FBCurrentPriceViewController.h"

@interface FBRootNavigationController ()

@end

@implementation FBRootNavigationController

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

    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    [self pushViewController:[[FBCurrentPriceViewController alloc]init] animated:YES];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
