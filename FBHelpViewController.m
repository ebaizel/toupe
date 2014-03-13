//
//  FBHelpViewController.m
//  Toupe
//
//  Created by emileleon on 3/12/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBHelpViewController.h"

@interface FBHelpViewController ()

@end

@implementation FBHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [[self delegate] dismissHelp:[_switchAlwaysDisplay isOn]];
}
@end
