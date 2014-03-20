//
//  FBHelpViewController.m
//  Toupe
//
//  Created by emileleon on 3/12/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBHelpViewController.h"
#import "FBHelp5ViewController.h"
#import "FBHelp10ViewController.h"
#import "FBHelp20ViewController.h"
#import "FBHelp30ViewController.h"

@interface FBHelpViewController ()

@end

@implementation FBHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        pageNum = 0;
        
        helpvcs = [[NSMutableArray alloc] init];
        [helpvcs addObject:[[FBHelp5ViewController alloc]init]];
        [helpvcs addObject:[[FBHelp10ViewController alloc]init]];
        [helpvcs addObject:[[FBHelp20ViewController alloc]init]];
        [helpvcs addObject:[[FBHelp30ViewController alloc]init]];
        
        [self setCurrentView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.switchAlwaysDisplay.onTintColor = [UIColor yellowColor];
    
    [[self pageControl] setNumberOfPages:[helpvcs count]];
    [[self pageControl] setCurrentPage:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setCurrentView
{
    UIViewController *currentView = (UIViewController *)[helpvcs objectAtIndex:pageNum];
//    currentView.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    currentView.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:currentView.view];
    
    // Toggle Next, Previous and Close buttons
    if (pageNum > 0) {
        [[self buttonPrev] setHidden:NO];
    } else {
        [[self buttonPrev] setHidden:YES];
    }
    
    if ((pageNum + 1) == ([helpvcs count])) {
        [[self buttonNext] setHidden:YES];
        [[self buttonClose] setHidden:NO];
        [[self switchAlwaysDisplay] setHidden:NO];
        [[self textShowHelp] setHidden:NO];
    } else {
        [[self buttonNext] setHidden:NO];
        [[self buttonClose] setHidden:YES];
        [[self switchAlwaysDisplay] setHidden:YES];
        [[self textShowHelp] setHidden:YES];
    }
}

- (void)removeCurrentView
{
    UIViewController *currentView = (UIViewController *)[helpvcs objectAtIndex:pageNum];
    [currentView.view removeFromSuperview];
}

- (IBAction)dismiss:(id)sender {
    [[self delegate] dismissHelp:[_switchAlwaysDisplay isOn]];
}

- (IBAction)goToNextPage:(id)sender {
    [self removeCurrentView];
    pageNum++;
    [[self pageControl] setCurrentPage:pageNum];
    
    [self setCurrentView];
}

- (IBAction)goToPreviousPage:(id)sender {
    [self removeCurrentView];
    pageNum--;
    [[self pageControl] setCurrentPage:pageNum];
    
    [self setCurrentView];
}
@end
