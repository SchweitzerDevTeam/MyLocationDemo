//
//  Region.h
//  MyLocationDemo
//
//  Created by martha quiring on 11/19/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//
	
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLCircularRegion.h>

@interface Region : NSObject
{
    CLCircularRegion *skiRegion;
    CLLocationCoordinate2D center;
    NSString *regionName;
    int radius;
    int elevation;
}

@property (nonatomic, strong)CLCircularRegion *skiRegion;
@property (nonatomic, assign)CLLocationCoordinate2D center;
@property (nonatomic, strong)NSString *regionName;
@property (nonatomic, assign)int radius;
@property (nonatomic, assign)int elevation;

-(id)initWithCenter:(CLLocationCoordinate2D)aCenter regionName:(NSString *)aRegionName radius:(int)aRadius elevation:(int)aElevation;

@end


/*`

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


*/