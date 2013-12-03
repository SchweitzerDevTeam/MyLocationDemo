//
//  Leaderboard.m
//  MyLocationDemo
//
//  Created by Evan Shioyama on 11/25/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import "Leaderboard.h"
#include "Statistic.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"

@implementation Leaderboard

@synthesize leaders;

-(id)init{
    self = [super init];
    if (self) {
        self.leaders = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray*)getLeaders {
    /*NSURL *url = [NSURL URLWithString:@"http://ada.gonzaga.edu/~eshioyama/getLeaders.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSArray *responseArray = [parser objectWithString:responseString error:NULL];
        for (int i = 0; i < [responseArray count]; i++) {
            NSDictionary *leader = responseArray[i];
            NSNumber *vertical = [leader objectForKey:@"vertftski"];
            NSString *username = [leader objectForKey:@"username"];
            [leaders addObject: [[Statistic alloc] initWithValues:[vertical intValue] days:0 un:username]];
        }
        return leaders;
    }
    return NULL;*/
    Statistic *stat1 = [[Statistic alloc] initWithValues: 1700 days:0 un: @"test1"];
    Statistic *stat2 = [[Statistic alloc] initWithValues: 1900 days:0 un: @"test2"];
    [leaders addObject: stat1];
    [leaders addObject: stat2];
    return leaders;
}

@end
