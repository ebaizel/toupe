//
//  FBChooseTariffViewController.m
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBChooseTariffViewController.h"
#import "Colours.h"

@interface FBChooseTariffViewController ()

@end

@implementation FBChooseTariffViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.textColor = [UIColor moneyGreenColor];
    if ([indexPath row] == 0) {
        cell.textLabel.text = @"Time of Use 1";
    } else if ([indexPath row] == 1) {
        cell.textLabel.text = @"Time of Use 2";
    } else {
        cell.textLabel.text = @"Time of Use 3";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
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
    [[self navigationItem] setTitle:@"Tariff"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continue:(id)sender {
}
@end
