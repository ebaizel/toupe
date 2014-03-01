//
//  FBSetupViewController.m
//  Toupe
//
//  Created by emileleon on 12/3/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBSetupViewController.h"

@interface FBSetupViewController ()

@end

@implementation FBSetupViewController

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
    [[self navigationItem] setTitle:@"Setup"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetAll:(id)sender {
}

- (IBAction)updateSettings:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"518" forKey:@"tariffId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"94115" forKey:@"zipCode"];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}
@end
