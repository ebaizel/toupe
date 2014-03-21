//
//  FBFAQStore.m
//  Toupe
//
//  Created by emileleon on 3/17/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import "FBFAQStore.h"
#import "FBFAQ.h"

@implementation FBFAQStore

+ (FBFAQStore *)sharedStore
{
    static FBFAQStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (NSMutableArray *)getFAQs
{
    if (!faqs){
        faqs = [[NSMutableArray alloc]init];
        FBFAQ *faq = [[FBFAQ alloc]init];
        faq.question = @"Where do you get the data?";
        faq.answer = @"Genability http://www.genability.com";
        [faqs addObject:faq];
        
        faq = [[FBFAQ alloc]init];
        faq.question = @"In what unit is the pricing?";
        faq.answer = @"Cost per kilowatt hour (kWh)";
        [faqs addObject:faq];
        
        faq = [[FBFAQ alloc]init];
        faq.question = @"How accurate is the data?";
        faq.answer = @"Very accurate.  Compare it to your utility bill to see for yourself!";
        [faqs addObject:faq];

        faq = [[FBFAQ alloc]init];
        faq.question = @"Who built this app?";
        faq.answer = @"Fresh Basil.  Contact us at: info@freshbasilllc.com";
        [faqs addObject:faq];

        faq = [[FBFAQ alloc]init];
        faq.question = @"Where can I send feedback?";
        faq.answer = @"Send all questions and comments to: info@freshbasilllc.com";
        [faqs addObject:faq];

        faq = [[FBFAQ alloc]init];
        faq.question = @"What can I do with the price information?";
        faq.answer = @"Quite a bit!  First, if you are not on a Time of Use (TOU) plan, see if your utility offers a TOU plan.\nTOU plans offer you a chance to take more control of your electricity bill.";
        [faqs addObject:faq];
        
        faq = [[FBFAQ alloc]init];
        faq.question = @"Is the price the cumulative price?";
        faq.answer = @"Not likely.  Typically your bill includes other items like fixed charges and taxes.  Toupe displays the consumption prices, i.e. the price you pay per kWh used.";
        [faqs addObject:faq];

        faq = [[FBFAQ alloc]init];
        faq.question = @"Why the name Toupe?";
        faq.answer = @"Toupe is a play on Time of Use, also known as TOU.  Another explanation is, we had to choose something.";
        [faqs addObject:faq];
        
    }
    
    return faqs;
}

@end
