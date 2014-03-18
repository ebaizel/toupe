//
//  FBFAQDetailViewController.h
//  Toupe
//
//  Created by emileleon on 3/17/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBFAQ;

@interface FBFAQDetailViewController : UIViewController
@property (strong, nonatomic) FBFAQ *faq;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
@property (weak, nonatomic) IBOutlet UITextView *textAnswer;
- (id)initWithFAQ:(FBFAQ *)faq;
@end
