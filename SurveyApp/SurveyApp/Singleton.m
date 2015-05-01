//
//  Singleton.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/28/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "Singleton.h"

static Singleton *singletonInstance = nil;
@implementation Singleton
@synthesize moderatorId,isLoggedIn,viewList;

+(Singleton *)getInstance{

        if(singletonInstance == nil){
            singletonInstance = [[Singleton alloc] init];
            
        }
        return singletonInstance;
    }

@end
