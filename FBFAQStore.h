//
//  FBFAQStore.h
//  Toupe
//
//  Created by emileleon on 3/17/14.
//  Copyright (c) 2014 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFAQStore : NSObject
{
    NSMutableArray *faqs;
}

+ (FBFAQStore *)sharedStore;
- (NSMutableArray *)getFAQs;
@end
