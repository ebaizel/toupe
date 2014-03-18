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

-(void)keyboardWillShow {
	// Animate the current view out of the way
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, -160, 320, 480);
    }];
}

-(void)keyboardWillHide {
	// Animate the current view back to its original position
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }];
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
    self.viewButtonBackground.backgroundColor = [UIColor skyBlueColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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
//    [[FBUserProfileStore sharedStore] saveUser];
    [self.view endEditing:YES];
    [[self navigationController] pushViewController:[[FBChooseUtilityViewController alloc] init] animated: YES];
}

- (IBAction)goBack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
