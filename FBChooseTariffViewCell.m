//
//  FBChooseTariffViewCell.m
//  Toupe
//
//  Created by emileleon on 1/30/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBChooseTariffViewCell.h"

@implementation FBChooseTariffViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
