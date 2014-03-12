//
//  FBTariffDrawerViewController.h
//  Toupe
//
//  Created by emileleon on 3/10/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TariffDrawerDelegate;

@interface FBTariffDrawerViewController : UIViewController
@property (assign, nonatomic) id <TariffDrawerDelegate> delegate;
- (IBAction)dismiss:(id)sender;
@end

@protocol TariffDrawerDelegate

- (void)selectTariff:(NSString *)tariffId;
- (void)dismissDrawer;

@end