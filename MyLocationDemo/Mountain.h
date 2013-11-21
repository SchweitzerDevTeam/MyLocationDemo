//
//  Mountain.h
//  MyLocationDemo
//
//  Created by martha quiring on 11/20/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLCircularRegion.h>
#import "Region.h"
#import "MyTester.h"

@interface Mountain : NSObject
{
    NSDictionary *liftInfo;
}

@property (nonatomic, strong)NSDictionary *liftInfo;


/*
-(id)UpdateVertical:(NSString*)prevRegion currRegion:(NSString*)currRegion skier:(MyTester**)aSkier;
*/


@end
