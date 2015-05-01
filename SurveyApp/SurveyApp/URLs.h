//
//  URLs.h
//  SurveyApp
//
//  Created by Arjun Shukla on 4/29/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#ifndef SurveyApp_URLs_h
#define SurveyApp_URLs_h

// Login
#define URLLoginPOST @"http://10.0.0.21:8080/api/v1/moderators/login"

// Moderator
#define URLCreateModeratorPOST @"http://10.0.0.21:8080/api/v1/moderators"
#define URLGetModeratorsWithIDGET @"http://localhost:8080/api/v1/moderators/%@"
#define URLUpdateModeratorPUT @"http://localhost:8080/api/v1/moderators/%@"

// Polls
#define URLCreatePollPOST @"http://10.0.0.21:8080/api/v1/moderators/%@/polls"
#define URLGetPollWithoutResultGET @"http://localhost:8080/api/v1/polls/%@"
#define URLGetPollForModeratorIdWithResultGET @"http://localhost:8080/api/v1/moderators/%@/polls/%@"
#define URLGetAllPollsGET @"http://10.0.0.21:8080/api/v1/moderators/%@/polls"
#define URLDeletePollDELETE @"http://localhost:8080/api/v1/moderators/%@/polls/%@"

// Vote
#define URLCastVotePUT @"http://localhost:8080/api/v1/polls/%@?choice=%d"

#define URL

#endif