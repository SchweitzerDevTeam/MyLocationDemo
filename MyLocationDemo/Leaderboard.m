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
    NSURL *url = [NSURL URLWithString:@"http://ada.gonzaga.edu/~eshioyama/getLeaders.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *leadersDict = [parser objectWithString:responseString error:NULL];
        NSArray *responseArray = [leadersDict objectForKey:@"leaders"];
        for (int i = 0; i < [responseArray count]; i++) {
            NSDictionary *leader = responseArray[i];
            NSNumber *vertical = [leader objectForKey:@"verticalSkied"];
            NSString *username = [leader objectForKey:@"username"];
            [leaders addObject: [[Statistic alloc] initWithValues:[vertical intValue] days:0 un:username]];
        }
        return leaders;
    }
    return NULL;
}

@end
