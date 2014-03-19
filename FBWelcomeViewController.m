//
//  FBWelcomeViewController.m
//  Toupe
//
//  Created by emileleon on 3/3/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBWelcomeViewController.h"
#import "FBEnterZipCodeViewController.h"
#import "FBWebViewController.h"

@interface FBWelcomeViewController ()

@end

@implementation FBWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [[self navigationController] setNavigationBarHidden:YES animated:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewButtonBackground.layer.cornerRadius = 5.0;
    self.viewButtonBackground.layer.masksToBounds = YES;
    self.viewButtonBackground.backgroundColor = [UIColor skyBlueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES];
}

- (IBAction)continue:(id)sender {
    FBEnterZipCodeViewController *ezcvc = [[FBEnterZipCodeViewController alloc]init];
    [ezcvc setIsRootView:NO];
    [[self navigationController] pushViewController:[[FBEnterZipCodeViewController alloc]init] animated:YES];
}

- (IBAction)buttonShowGenability:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.genability.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    FBWebViewController *wvc = [[FBWebViewController alloc]init];
    [[wvc webView] loadRequest:req];
    
    [[wvc navigationItem] setTitle:@"Genability"];
    
    // Push the view controller.
    [self.navigationController pushViewController:wvc animated:YES];
}
@end
