//
//  Region.m
//  MyLocationDemo
//
//  Created by martha quiring on 11/19/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import "Region.h"

@implementation Region
@synthesize center, regionName, radius, elevation, skiRegion;

-(id)initWithCenter:(CLLocationCoordinate2D)aCenter regionName:(NSString *)aRegionName radius:(int)aRadius elevation:(int)aElevation {
    self = [super init];
    if (self) {
        self.center = aCenter;
        self.regionName = aRegionName;
        self.radius = aRadius;
        self.elevation = aElevation;

        self.skiRegion = [[CLCircularRegion alloc] initWithCenter:center
                                                           radius:radius
                                                       identifier:regionName];
    }
    return self;
}

@end
