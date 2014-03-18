//
//  FBFAQViewController.m
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBFAQViewController.h"
#import "FBFAQ.h"
#import "FBFAQStore.h"
#import "FBTariffDrawerTableViewCell.h"
#import "FBFAQDetailViewController.h"

@interface FBFAQViewController ()

@end

@implementation FBFAQViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[FBFAQStore sharedStore] getFAQs]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
//    FBTariffDrawerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[FBTariffDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    FBFAQ *faq = (FBFAQ *)[[[FBFAQStore sharedStore] getFAQs] objectAtIndex:[indexPath row]];
//    cell.labelTariffName.textColor = [UIColor orangeColor];
//    cell.labelTariffName.text = faq.question;
//    cell.labelTariffName.text = @"test test";
    cell.textLabel.text = faq.question;
    cell.textLabel.textColor = [UIColor skyBlueColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.minimumScaleFactor = 0.5;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBFAQ *faq = [[[FBFAQStore sharedStore]getFAQs]objectAtIndex:[indexPath row]];
    FBFAQDetailViewController *faqdvc = [[FBFAQDetailViewController alloc]initWithFAQ:faq];
    
    // Push the view controller.
    [self.navigationController pushViewController:faqdvc animated:YES];
}


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
    // Setup the navigation bar
    [[self navigationItem] setTitle:@"FAQs"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [[self delegate]dismissFAQ];
}
@end
