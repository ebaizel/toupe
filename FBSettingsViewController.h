//
//  FBSettingsViewController.h
//  Toupe
//
//  Created by emileleon on 3/6/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textZipCode;
@property (weak, nonatomic) IBOutlet UITextField *textMonthlyConsumption;
@property (weak, nonatomic) IBOutlet UISwitch *switchShowHelp;
@property (weak, nonatomic) IBOutlet UIControl *buttonContinue;

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)continue:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)resetAllSettings:(id)sender;

@end
