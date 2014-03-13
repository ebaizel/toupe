//
//  FBHelpViewController.h
//  Toupe
//
//  Created by emileleon on 3/12/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelpViewDelegate;

@interface FBHelpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *switchAlwaysDisplay;
@property (weak, nonatomic) id <HelpViewDelegate> delegate;
- (IBAction)dismiss:(id)sender;

@end

@protocol HelpViewDelegate

- (void)dismissHelp:(BOOL)alwaysShow;

@end