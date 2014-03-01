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

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:_isRootView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Zip Code"];
    _zipCodeTextField.text = [[[FBUserProfileStore sharedStore] userProfile] zipCode];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    return (textField.text.length <= 6);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)continue:(id)sender {
    [[[FBUserProfileStore sharedStore] userProfile] setZipCode:_zipCodeTextField.text];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [[self navigationController] pushViewController:[[FBChooseUtilityViewController alloc] init] animated: YES];
}

@end
