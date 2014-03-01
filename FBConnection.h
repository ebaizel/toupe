//
//  FBConnection.h
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface FBConnection : NSObject
{
    NSURLConnection *internalConnection;
    NSMutableData *container;
}

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property (nonatomic, strong) id <JSONSerializable> jsonRootObject;

- (id)initWithRequest: (NSURLRequest *)req;
- (void) start;
@end
