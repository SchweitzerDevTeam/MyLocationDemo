//
//  MyTester.h
//  MyLocationDemo
//
//  Created by martha quiring on 10/13/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTester : NSObject
{

    int verticalSkied;
    int count;
    int currentLocation;
    int lastLocation;
    int lastLastLocation;
    bool isDownHill;
    
    NSInteger elevations[3];
}
@property (nonatomic, assign)int verticalSkied;
@property (nonatomic, assign)int count;
@property (nonatomic, assign)int currentLocation;
@property (nonatomic, assign)int lastLastLocation;
@property (nonatomic, assign)int lastLocation;
@property (nonatomic, assign)NSInteger elevations;

- (void) initialize;

@end
