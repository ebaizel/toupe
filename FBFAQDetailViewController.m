//
//  FBFAQDetailViewController.m
//  Toupe
//
//  Created by emileleon on 3/17/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBFAQDetailViewController.h"
#import "FBFAQ.h"

@interface FBFAQDetailViewController ()

@end

@implementation FBFAQDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFAQ:(FBFAQ *)faq
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _faq = faq;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelQuestion.textColor = [UIColor skyBlueColor];
    self.textAnswer.textColor = [UIColor skyBlueColor];
    self.labelQuestion.text = _faq.question;
    self.textAnswer.text = _faq.answer;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
