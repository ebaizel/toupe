//
//  FBFAQViewController.h
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FAQDelegate;

@interface FBFAQViewController : UIViewController
- (IBAction)dismiss:(id)sender;
@property (weak, nonatomic) id <FAQDelegate> delegate;
@end

@protocol FAQDelegate

- (void)dismissFAQ;

@end