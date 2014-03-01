//
//  FBChooseUtilityViewController.m
//  Toupe
//
//  Created by emileleon on 1/28/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBChooseUtilityViewController.h"
#import "Colours.h"
#import "FBChooseTariffViewController.h"
#import "FBGenabilityStore.h"
#import "FBUserProfileStore.h"
#import "FBUserProfile.h"
#import "FBTariff.h"
#import "FBChooseTariffViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "FBLSE.h"

@interface FBChooseUtilityViewController ()

@end

@implementation FBChooseUtilityViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self lses] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FBChooseTariffViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FBChooseTariffViewCell"];
    if (cell == nil) {
        cell = [[FBChooseTariffViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FBChooseTariffViewCell"];
    }
    
    UIFont *cellFont = [UIFont fontWithName: @"Arial" size: 16.0 ];
    cell.textLabel.font = cellFont;
    cell.tag = [indexPath row];
    [cell setBackgroundColor:[UIColor whiteColor]];

    //    FBTariff *tariff = [[self tariffs] objectAtIndex:[indexPath row]];
    FBLSE *lse = [[self lses] objectAtIndex:[indexPath row]];
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@.png", BaseImageURL, lse.lseId];
    [cell.imageLSE setImageWithURL:[NSURL URLWithString:imageURL]];

    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor honeydewColor];
    cell.selectedBackgroundView = selectionColor;
    
    cell.labelTariffName.textColor = [UIColor moneyGreenColor];
    //    cell.labelTariffName.text = [NSString stringWithFormat:@"%@ - %@",[tariff tariffCode], [tariff tariffName]];
    cell.labelTariffName.text = [lse lseName];
    cell.labelLSEName.textColor = [UIColor black75PercentColor];
    cell.labelLSEName.text = [lse lseName];

    if ([indexPath row] == _selectedLSEIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setBackgroundColor:[UIColor honeydewColor]];        
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setNeedsDisplay];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedLSEIndex = [indexPath row];
    [_lseTable reloadData];
    
}

- (void)fetchTariffs
{
    
    UIView *currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    __weak FBChooseUtilityViewController *weakSelf = self;
    FBUserProfile *user = [[FBUserProfileStore sharedStore] userProfile];
    
    [[FBGenabilityStore sharedStore] getTariffs:[user zipCode] forBlock:^(NSMutableArray *tariffsResult, NSError *err) {
        
        [[weakSelf navigationItem] setTitleView:currentTitleView];
        
        if (!err) {
            _tariffs = tariffsResult;
            _lses = [self parseLSEsFromTariffs];
            
            [[weakSelf lseTable] reloadData];
        } else {
            UIAlertView *av =[[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:[err localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
            [av show];
        }
    }];
}

- (NSMutableArray *)parseLSEsFromTariffs
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (FBTariff *tariff in self.tariffs) {
        NSString *lseId = tariff.lseId;
        BOOL exists = false;
        for (FBLSE *lse in result) {
            if ([lse.lseId isEqualToString:lseId]) {
                exists = true;
                break;
            }
        }
        if (!exists) {
            FBLSE *newLSE = [[FBLSE alloc]init];
            newLSE.lseId = lseId;
            newLSE.lseName = tariff.lseName;
            [result addObject:newLSE];
        }
    }
    return result;
}

-(void)selectTariff:(FBChooseTariffViewCell *)cell
{
    _selectedLSEIndex = cell.tag;
    [_lseTable reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectedLSEIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Utility"];
    UINib *nib = [UINib nibWithNibName:@"FBChooseTariffViewCell" bundle:nil];
    [[self lseTable] registerNib:nib forCellReuseIdentifier:@"FBChooseTariffViewCell"];
    [self fetchTariffs];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continue:(id)sender {
    
    FBLSE *lse = [_lses objectAtIndex:_selectedLSEIndex];
    [[[FBUserProfileStore sharedStore] userProfile] setLse:lse];
    [[[FBUserProfileStore sharedStore] userProfile] setTariffs:_tariffs];

    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    
    //prune tariffs not belonging to the chosen lse
    for (int i = 0; i < [_tariffs count]; i++) {
        if (![[[_tariffs objectAtIndex:i] lseId] isEqualToString:lse.lseId]) {
            [indexes addIndex:i];
        }
    }
    [_tariffs removeObjectsAtIndexes:indexes];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSEUpdated" object:self];    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end










