//
//  FBViewController.m
//  Toupe
//
//  Created by emileleon on 12/2/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBViewController.h"
#import "FBUserProfileStore.h"

@interface FBViewController ()

@end

@implementation FBViewController

- (IBAction)updateZipcode:(id)sender {
    [[FBUserProfileStore sharedStore] saveUser];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // if no zipcode data has been saved, display label 'Please setup'
    
    // else push the current price view controller
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
