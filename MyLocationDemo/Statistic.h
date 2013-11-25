//
//  Statistic.h
//  Web Service
//
//  Created by Evan Shioyama on 11/19/13.
//  Copyright (c) 2013 Evan Shioyama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Statistic : NSObject

@property int verticalFeetSkied;

@property int daysSkied;

@property (readwrite) NSString *username;

- (int)getDaysSkied;

- (int)getVerticalFeetSkied;

- (int)setAndSubmitVerticalSkied:(int)daysSkied;

- (int)setAndUpdateVerticalSkied:(int)daysSkied;

-(id)initWithValues:(int)vertSkied days:(int)numDaysSkied un:(NSString *)aUsername;

@end
