//
//  FBEnterZipCodeViewController.m
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBEnterZipCodeViewController.h"
#import "FBChooseUtilityViewController.h"
#import "FBUserProfileStore.h"

@interface FBEnterZipCodeViewController ()

@end

@implementation FBEnterZipCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _zipCodeTextField.text = [[[FBUserProfileStore sharedStore] userProfile] zipCode];
    [[self navigationController] setNavigationBarHidden:YES];
    self.viewButtonBackground.layer.cornerRadius = 5.0;
    self.viewButtonBackground.layer.masksToBounds = YES;
    self.viewButtonBackground.backgroundColor = [UIColor moneyGreenColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)continue:(id)sender {
    [[[FBUserProfileStore sharedStore] userProfile] setZipCode:_zipCodeTextField.text];
    [[FBUserProfileStore sharedStore] saveUser];
    [[self navigationController] pushViewController:[[FBChooseUtilityViewController alloc] init] animated: YES];
}

- (IBAction)goBack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
