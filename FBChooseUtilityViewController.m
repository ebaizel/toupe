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
    cell.backgroundColor = [UIColor whiteColor];
    cell.tintColor = [UIColor whiteColor];
    
    cell.layer.cornerRadius = 5.0;
    cell.layer.masksToBounds = YES;

    //    FBTariff *tariff = [[self tariffs] objectAtIndex:[indexPath row]];
    FBLSE *lse = [[self lses] objectAtIndex:[indexPath row]];
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@.png", BaseImageURL, lse.lseId];
    [cell.imageLSE setImageWithURL:[NSURL URLWithString:imageURL]];

//    UIView *selectionColor = [[UIView alloc] init];
//    selectionColor.backgroundColor = [UIColor honeydewColor];
//    cell.selectedBackgroundView = selectionColor;
    
    cell.labelTariffName.textColor = [UIColor skyBlueColor];
    //    cell.labelTariffName.text = [NSString stringWithFormat:@"%@ - %@",[tariff tariffCode], [tariff tariffName]];
    cell.labelTariffName.text = [lse lseName];
    cell.labelLSEName.textColor = [UIColor black75PercentColor];
    cell.labelLSEName.text = [lse lseName];

    if ([indexPath row] == _selectedLSEIndex) {
        [cell setBackgroundColor:[UIColor skyBlueColor]];
        cell.labelTariffName.textColor = [UIColor whiteColor];
    } else {
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.labelTariffName.textColor = [UIColor skyBlueColor];
//        cell.accessoryType = UITableViewCellAccessoryNone;
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
    [[self viewButtonBackground] setHidden:NO];
    [[self buttonDone] setHidden:NO];
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
            
            if (_lses && ([_lses count] > 0)) {
                [[weakSelf lseTable] reloadData];
                [weakSelf adjustLSETableHeight];
            } else {
                [self displayNoLSEAlert];
            }
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

-(void)displayNoLSEAlert
{
    NSString *msg = [NSString stringWithFormat:@"No utilities found"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                    message:@"Please go back and try a different zip code"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
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
    [self adjustLSETableHeight];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectedLSEIndex = -1;
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
    [self adjustLSETableHeight];
    
    self.lseTable.separatorColor = [UIColor clearColor];
    
    self.viewButtonBackground.layer.cornerRadius = 5.0;
    self.viewButtonBackground.layer.masksToBounds = YES;
    self.viewButtonBackground.backgroundColor = [UIColor skyBlueColor];

}


-(void)adjustLSETableHeight
{
    CGRect bounds = [[self lseTable] bounds];
    [[self lseTable] setBounds:CGRectMake(bounds.origin.x,
                                          bounds.origin.y,
                                          bounds.size.width,
                                          [[self lses]count] * 60)];
//                                          bounds.size.height + 60)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continue:(id)sender {
    
    if (_selectedLSEIndex >= 0) {
        FBLSE *lse = [_lses objectAtIndex:_selectedLSEIndex];

        NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
        
        //prune tariffs not belonging to the chosen lse
        for (int i = 0; i < [_tariffs count]; i++) {
            if (![[[_tariffs objectAtIndex:i] lseId] isEqualToString:lse.lseId]) {
                [indexes addIndex:i];
            }
        }
        [_tariffs removeObjectsAtIndexes:indexes];

        [[[FBUserProfileStore sharedStore] userProfile] setLse:lse];
        [[[FBUserProfileStore sharedStore] userProfile] setTariffs:_tariffs];
        [[FBUserProfileStore sharedStore] saveUser];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LSEUpdated" object:self];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    } else {
        NSString *msg = [NSString stringWithFormat:@"Select a utility"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                        message:@"Please select a utility"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
}
- (IBAction)goBack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end










