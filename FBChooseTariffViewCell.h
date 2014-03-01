//
//  FBChooseTariffViewCell.h
//  Toupe
//
//  Created by emileleon on 1/30/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTariffViewCellDelegate;

@interface FBChooseTariffViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageLSE;
@property (weak, nonatomic) IBOutlet UILabel *labelTariffName;
@property (weak, nonatomic) IBOutlet UILabel *labelLSEName;

@end

@protocol ChooseTariffViewCellDelegate <NSObject>

-(void)selectTariff:(FBChooseTariffViewCell *)cell;

@end