//
//  FBConnection.m
//  Toupe
//
//  Created by emileleon on 12/20/13.
//  Copyright (c) 2013 Fresh Basil. All rights reserved.
//

#import "FBConnection.h"
#import "FBSmartPriceSummary.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation FBConnection

- (id)initWithRequest: (NSURLRequest *)req
{
    self = [super init];
    if (self) {
        [self setRequest:req];
    }
    return self;
}

- (void) start
{
    container = [[NSMutableData alloc]init];
    internalConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self startImmediately:YES];
    
    if (!sharedConnectionList) {
        sharedConnectionList = [[NSMutableArray alloc]init];
    }
    
    [sharedConnectionList addObject:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self jsonRootObject]) {
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil];
        [[self jsonRootObject] readFromJSONDictionary:d];
    }
    
    if ([self completionBlock]) {
        [self completionBlock]([self jsonRootObject], nil);
    }
    
    [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self completionBlock]) {
        [self completionBlock](nil, error);
    }
    [sharedConnectionList removeObject:self];
}

@end
