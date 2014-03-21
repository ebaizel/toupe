//
//  FBLaunchViewController.m
//  Toupe
//
//  Created by emileleon on 3/21/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBLaunchViewController.h"

@interface FBLaunchViewController ()

@end

@implementation FBLaunchViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
