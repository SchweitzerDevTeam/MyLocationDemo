//
//  Statistic.m
//  Web Service
//
//  Created by Evan Shioyama on 11/19/13.
//  Copyright (c) 2013 Evan Shioyama. All rights reserved.
//

#import "Statistic.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"


@implementation Statistic

@synthesize username;
@synthesize verticalFeetSkied;
@synthesize daysSkied;

- (NSString*)getUsername {
    return username;
}

- (int)getVerticalFeetSkied {
    return verticalFeetSkied;
}

- (int)getDaysSkied {
    return daysSkied;
}

- (int)getDaysSkiedForUsername {
    NSURL *url = [NSURL URLWithString:[@"http://ada.gonzaga.edu/~eshioyama/days.php?username=" stringByAppendingString:username]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *responseDict = [parser objectWithString:responseString error:NULL];
        NSNumber *days_number = [responseDict objectForKey:@"daysSkied"];
        return [days_number intValue];
    }
    return -1;
}

- (int)getVerticalFeetSkiedForUsername {
    NSURL *url = [NSURL URLWithString:[@"http://ada.gonzaga.edu/~eshioyama/get.php?username=" stringByAppendingString:username]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *responseDict = [parser objectWithString:responseString error:NULL];
        NSNumber *vertical_number = [responseDict objectForKey:@"verticalFeetSkied"];
        return [vertical_number intValue];
    }
    return -1;
}

- (int)setAndSubmitVerticalSkied:(int)verticalSkied {
    
    verticalFeetSkied = verticalSkied;
    
    NSURL *url = [NSURL URLWithString:@"http://ada.gonzaga.edu/~eshioyama/vertical.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%d", verticalFeetSkied] forKey:@"vertftski"];
    [request setPostValue:username forKey:@"username"];
    [request setDelegate:self];
    [request startSynchronous];
        
    return request.responseStatusCode;
}

- (int)setAndUpdateVerticalSkied:(int)verticalSkied {
    
    verticalFeetSkied = verticalSkied;
    
    NSURL *url = [NSURL URLWithString:@"http://ada.gonzaga.edu/~eshioyama/updateVert.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%d", verticalFeetSkied] forKey:@"vertftski"];
    [request setPostValue:username forKey:@"username"];
    [request setDelegate:self];
    [request startSynchronous];
    
    return request.responseStatusCode;
}

-(id)initWithValues:(int)vertSkied days:(int)numDaysSkied un:(NSString *)aUsername {
    self = [super init];
    if (self) {
        self.verticalFeetSkied = vertSkied;
        self.daysSkied = numDaysSkied;
        self.username = aUsername;
    }
    return self;
}

@end
