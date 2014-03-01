//
//  JSONSerializable.h
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void)readFromJSONDictionary:(NSDictionary *)d;
@end