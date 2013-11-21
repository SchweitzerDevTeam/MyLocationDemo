//
//  MyTester.m
//  MyLocationDemo
//
//  Created by martha quiring on 10/13/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import "MyTester.h"

@implementation MyTester


- (void) initialize
{
    elevations[0] = 0;
    elevations[1] = 2000;
    elevations[2] = 4500;
    
    isDownHill = false;
    
    currentLocation = 0;
    lastLocation = 0;
    lastLastLocation = 0;
    verticalSkied = 0;

}


@end
