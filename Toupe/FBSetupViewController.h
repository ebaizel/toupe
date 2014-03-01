//
//  FBSetupViewController.h
//  Toupe
//
//  Created by emileleon on 12/3/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBSetupViewController : UIViewController
- (IBAction)resetAll:(id)sender;
- (IBAction)updateSettings:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@end
