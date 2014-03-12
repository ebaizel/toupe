//
//  FBTariffDrawerTableViewCell.h
//  Toupe
//
//  Created by emileleon on 3/10/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBTariffDrawerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTariffName;
@property (strong, nonatomic) NSString *tariffId;
@end