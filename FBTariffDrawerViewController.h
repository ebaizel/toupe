//
//  FBTariffDrawerViewController.h
//  Toupe
//
//  Created by emileleon on 3/10/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBTariff;

@protocol TariffDrawerDelegate;

@interface FBTariffDrawerViewController : UIViewController
{
    FBTariff *selectedTariff;
}
@property (weak, nonatomic) IBOutlet UITableView *tableDrawer;
@property (assign, nonatomic) id <TariffDrawerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *labelViewAnotherRatePlan;
@property (weak, nonatomic) IBOutlet UIButton *buttonClose;
- (IBAction)dismiss:(id)sender;
- (void)setSelectedTariff:(FBTariff *)tariff;

@end

@protocol TariffDrawerDelegate

- (void)selectTariff:(NSString *)tariffId;
- (void)dismissDrawer;

@end