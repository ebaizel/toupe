//
//  FBChooseUtilityViewController.h
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBChooseTariffViewCell.h"

@class FBTariff;

@interface FBChooseUtilityViewController : UIViewController <ChooseTariffViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *lseTable;
@property (strong, nonatomic) NSMutableArray *tariffs;
@property (weak, nonatomic) IBOutlet UIControl *viewButtonBackground;
@property (strong, nonatomic) NSMutableArray *lses;
@property (nonatomic, assign) NSInteger selectedLSEIndex;
@property (weak, nonatomic) IBOutlet UIButton *buttonDone;
- (IBAction)continue:(id)sender;
- (IBAction)goBack:(id)sender;
@end
