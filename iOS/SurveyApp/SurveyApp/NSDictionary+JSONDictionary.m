//
//  NSDictionary+JSONDictionary.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/29/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "NSDictionary+JSONDictionary.h"

@implementation NSDictionary (JSONDictionary)
// in case of [NSNull null] values a nil is returned ...
- (id)objectForKeyNotNull:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end
