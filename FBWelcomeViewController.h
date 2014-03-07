//
//  FBWelcomeViewController.h
//  Toupe
//
//  Created by emileleon on 3/3/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBWelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewButtonBackground;
@property (assign, nonatomic) BOOL isRootView;
- (IBAction)continue:(id)sender;
@end
