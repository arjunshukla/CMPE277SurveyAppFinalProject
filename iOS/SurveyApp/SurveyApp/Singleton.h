//
//  Singleton.h
//  SurveyApp
//
//  Created by Arjun Shukla on 4/28/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
@property(nonatomic,strong) NSString *moderatorId;
@property(nonatomic,assign) BOOL isLoggedIn;
@property(nonatomic,strong) NSDictionary* selectedPollDetails;
+(Singleton *)getInstance;
@end
