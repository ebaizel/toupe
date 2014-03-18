//
//  FBSettingsViewController.m
//  Toupe
//
//  Created by emileleon on 3/6/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBSettingsViewController.h"
#import "FBUserProfileStore.h"
#import "FBChooseUtilityViewController.h"

@interface FBSettingsViewController ()

@end

@implementation FBSettingsViewController

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
    _textZipCode.text = [[[FBUserProfileStore sharedStore] userProfile] zipCode];
    _textMonthlyConsumption.text = [NSString stringWithFormat:@"%d", [[[FBUserProfileStore sharedStore] userProfile] monthlyConsumption]];
    _switchShowHelp.on = [[[FBUserProfileStore sharedStore] userProfile] showHelp];
    _switchShowHelp.onTintColor = [UIColor skyBlueColor];
    
    _buttonContinue.layer.cornerRadius = 5.0;
    _buttonContinue.layer.masksToBounds = YES;
    _buttonContinue.backgroundColor = [UIColor skyBlueColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continue:(id)sender {
    BOOL zipChanged = NO;
    if (![_textZipCode.text isEqualToString:[[[FBUserProfileStore sharedStore]userProfile]zipCode]]) {
        zipChanged = YES;
    }

    [[[FBUserProfileStore sharedStore] userProfile] setZipCode:_textZipCode.text];
    [[[FBUserProfileStore sharedStore] userProfile] setMonthlyConsumption:_textMonthlyConsumption.text.intValue];
    [[[FBUserProfileStore sharedStore] userProfile] setShowHelp:_switchShowHelp.on];
    [[FBUserProfileStore sharedStore] saveUser];
    
    if (zipChanged) {
        [[self navigationController] pushViewController:[[FBChooseUtilityViewController alloc] init] animated: YES];
    } else {
        [[self navigationController] popViewControllerAnimated:YES];        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatedUserSettings" object:self];
    }
    
    
//    [[self navigationController] popViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatedUserSettings" object:self];

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSEUpdated" object:self];
//    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (IBAction)goBack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)resetAllSettings:(id)sender {
    [[FBUserProfileStore sharedStore]resetUser];
//    [[self navigationController] popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetUserSettings" object:self];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
}

@end
