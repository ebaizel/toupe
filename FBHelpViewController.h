//
//  FBHelpViewController.h
//  Toupe
//
//  Created by emileleon on 3/12/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelpViewDelegate;

@interface FBHelpViewController : UIViewController
{
    NSMutableArray *helpvcs;
    NSInteger pageNum;
}

@property (weak, nonatomic) IBOutlet UISwitch *switchAlwaysDisplay;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) id <HelpViewDelegate> delegate;
- (IBAction)dismiss:(id)sender;
- (IBAction)goToNextPage:(id)sender;
- (IBAction)goToPreviousPage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIButton *buttonPrev;
@property (weak, nonatomic) IBOutlet UIButton *buttonClose;
@property (weak, nonatomic) IBOutlet UITextView *textShowHelp;

@end

@protocol HelpViewDelegate

- (void)dismissHelp:(BOOL)alwaysShow;

@end