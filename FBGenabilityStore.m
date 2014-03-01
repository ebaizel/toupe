//
//  FBGenabilityStore.m
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBGenabilityStore.h"
#import "FBSmartPriceSummary.h"
#import "FBConnection.h"
#import "FBTariffSearchResult.h"

@implementation FBGenabilityStore

- (void)getPrice:(NSString *)masterTariffId withMonthlyConsumption:(int)monthlyConsumption forBlock:(void (^)(FBSmartPriceSummary *smartPriceSummary, NSError *err))block
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm'Z'"];
    
    NSDate *newDate = [currDate dateByAddingTimeInterval:3600*24*7];
    NSString *toDateString = [dateFormatter stringFromDate:newDate];
    
    NSString *priceURL = [NSString stringWithFormat:@"%@/rest/prices?masterTariffId=%@&consumptionAmount=%d&toDateTime=%@&%@", BaseURL, masterTariffId, monthlyConsumption, toDateString, AuthCreds];
    NSLog(@"Getting price url: %@", priceURL);
    NSURL *url = [NSURL URLWithString:priceURL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    FBSmartPriceSummary *trsRootObject = [[FBSmartPriceSummary alloc]init];
    FBConnection *connect = [[FBConnection alloc]initWithRequest:req];
    [connect setJsonRootObject:trsRootObject];
    
    [connect setCompletionBlock:^(FBSmartPriceSummary *smartPriceResult, NSError *err) {
        if (!err) {
            block(smartPriceResult, nil);
        } else {
            block(nil, err);
        }
    }];
    [connect start];
    
}

- (void)getTariffs:(NSString *)zipCode forBlock:(void (^)(NSMutableArray *tariffsResult, NSError *err))block
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *effectiveDate = [dateFormatter stringFromDate:currDate];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/rest/public/tariffs?customerClasses=RESIDENTIAL&tariffTypes=DEFAULT,ALTERNATIVE&zipCode=%@&effectiveOn=%@&%@", BaseURL, zipCode, effectiveDate, AuthCreds];
    NSLog(@"Getting tariffs with url of %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    FBTariffSearchResult *tsrRootObject = [[FBTariffSearchResult alloc]init];
    FBConnection *connect = [[FBConnection alloc]initWithRequest:req];
    [connect setJsonRootObject:tsrRootObject];
    
    [connect setCompletionBlock:^(FBTariffSearchResult *tariffSearchResult, NSError *err) {
        if (!err) {
            NSLog(@"**SUCCESS.  There are %d tariffs.", [[tariffSearchResult tariffs] count]);
            NSLog(@"**SUCCESS.  Tariffs are %@", [tariffSearchResult tariffs]);
            block([tariffSearchResult tariffs], nil);
        } else {
            block(nil, err);
        }
    }];
    [connect start];
    
}


//
//- (void)getTariff:(void (^)(FBTariffRateSummary *tariffRateSummary, NSError *err))block
//{
//    NSURL *url = [NSURL URLWithString:@"http://api.genability.com/rest/public/tariffs?appId=3b5ba2f0&appKey=9ddcfa56f00b45dcf83f62150c3e8b70&zipCode=94110&customerClasses=RESIDENTIAL&tariffTypes=DEFAULT,ALTERNATIVE"];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    
//    FBTariffRateSummary *trsRootObject = [[FBTariffRateSummary alloc]init];
//    FBConnection *connect = [[FBConnection alloc]initWithRequest:req];
//    [connect setJsonRootObject:trsRootObject];
//    
//    [connect setCompletionBlock:^(FBTariffRateSummary *trsConnectResult, NSError *err) {
//        if (!err) {
//            block(trsConnectResult, nil);
//        } else {
//            block(nil, err);
//        }
//    }];
//    [connect start];
//    
//}

+ (FBGenabilityStore *)sharedStore
{
    static FBGenabilityStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}
@end
