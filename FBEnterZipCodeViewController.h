//
//  FBEnterZipCodeViewController.h
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBEnterZipCodeViewController : UIViewController

@property (assign, nonatomic) BOOL isRootView;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end
