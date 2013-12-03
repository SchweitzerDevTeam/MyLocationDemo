//
//  Leaderboard.h
//  MyLocationDemo
//
//  Created by Evan Shioyama on 11/25/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Leaderboard : NSObject

@property NSMutableArray *leaders;

- (NSMutableArray*)getLeaders;

@end
