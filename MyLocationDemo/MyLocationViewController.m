//
//  MyLocationViewController.m
//  MyLocationDemo
//
//  Created by martha quiring on 10/6/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import "MyLocationViewController.h"
#import <UIKit/UIKit.h>
#import "MyTester.h"
#import "Region.h"
#import "Statistic.h"

@interface MyLocationViewController () {

    MyTester *_skier;
    MyTester *_skier2;
    MyTester *_skier3;
    
    Statistic *stat;
    
    int _curSkier;
    
    CLLocationManager *_locationManager;
    
    Region *_topRegion;
    Region *_sideRegion;
    Region *_middleRegion;
    Region *_bottomRegion;
}

@property (weak, nonatomic) IBOutlet UILabel *verSkiedLabel;
@property (weak, nonatomic) IBOutlet UILabel *curLiftLabel;
@property (weak, nonatomic) IBOutlet UILabel *prevLiftLabel;
- (IBAction)Submit:(id)sender;
- (IBAction)getvert:(id)sender;

@end

@implementation MyLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    /*
    [topRegion makeCenter: new
            AndRegionName: @"Top"
                AndRadius: 25
             AndElevation: 2000];
     */
    

    _topRegion = [[Region alloc] initWithCenter:CLLocationCoordinate2DMake(47.669368, -117.398121)
                                     regionName:@"Top"
                                         radius:15
                                      elevation:1000];
    

    _sideRegion = [[Region alloc]
                 initWithCenter: CLLocationCoordinate2DMake(47.669466, -117.401361)
                 regionName: @"Side"
                 radius: 25
                 elevation: 1700];
    

    
    _middleRegion = [[Region alloc]
                    initWithCenter: CLLocationCoordinate2DMake(47.664613, -117.397907)
                    regionName: @"Middle"
                    radius: 25
                    elevation: 1000];
    

    
    _bottomRegion= [[Region alloc]
                   initWithCenter: CLLocationCoordinate2DMake(47.662012, -117.397864)
                   regionName: @"Bottom"
                   radius: 25
                   elevation: 0];
    

    
    _skier = [[MyTester alloc] init];
    [_skier initialize];
    
    stat = [[Statistic alloc] initWithValues:0 days:0 un:@"urmom"];
    
    
    [_locationManager startMonitoringForRegion:_topRegion.skiRegion];
    
    
    
    [_locationManager startMonitoringForRegion: _sideRegion.skiRegion];
    [_locationManager startMonitoringForRegion: _middleRegion.skiRegion];
    [_locationManager startMonitoringForRegion: _bottomRegion.skiRegion];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    [self showRegionAlert:@"Monitoring Failed!" forRegion:region.identifier];
}


- (void)checkRegion {
    
    _curLiftLabel.text = [NSString stringWithFormat: @"%d", _skier.currentLocation];
    _prevLiftLabel.text = [NSString stringWithFormat: @"%d", _skier.lastLocation];
    
    
    
    //_verSkiedLabel.text = [NSString stringWithFormat: @"%d", _skier.verticalSkied];
    
    _verSkiedLabel.text = [NSString stringWithFormat: @"%d", [stat getVerticalFeetSkied]];
    
    
    [_locationManager startUpdatingLocation];
    
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLCircularRegion *)region {
    

    
        if ([region.identifier  isEqual: @"Top"])
        {
            _skier.lastLastLocation = _skier.lastLocation;
            _skier.lastLocation = _skier.currentLocation;
            _skier.currentLocation = 2;

        }
        else if ([region.identifier  isEqual: @"Middle"])
        {
            _skier.lastLastLocation = _skier.lastLocation;
            _skier.lastLocation = _skier.currentLocation;
            _skier.currentLocation = 1;
        }
        else if ([region.identifier  isEqual: @"Side"])
        {
            _skier.lastLastLocation = _skier.lastLocation;
            _skier.lastLocation = _skier.currentLocation;
            _skier.currentLocation = 3;
        }
        else if ([region.identifier  isEqual: @"Bottom"])
        {
            _skier.lastLastLocation = _skier.lastLocation;
            _skier.lastLocation = _skier.currentLocation;
            _skier.currentLocation = 0;
        }


    if (_skier.currentLocation == 0)
    {
        if (_skier.lastLocation == 1)
        {
            _skier.verticalSkied += 1200;
        }
        else if (_skier.lastLocation == 2)
        {
            _skier.verticalSkied += 2000;
        }
        else if (_skier.lastLocation == 3)
        {
            _skier.verticalSkied += 1700;
        }
    }
    
    else if (_skier.currentLocation == 1)
    {
        if (_skier.lastLocation == 2)
        {
            _skier.verticalSkied += 800;
        }
        else if (_skier.lastLocation == 3)
        {
            _skier.verticalSkied += 500;
        }
    }
    
    else if (_skier.currentLocation == 3)
    {
        if (_skier.lastLocation == 2)
        {
            _skier.verticalSkied += 300;
        }
    }
    
    [stat setAndSubmitVerticalSkied:_skier.verticalSkied];
    
    
    [self checkRegion];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self showRegionAlert:@"Leaving: " forRegion:region.identifier];
}



- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    //[self showRegionAlert:@"Monitoring: " forRegion:region.identifier];
    
}

 
- (void) showRegionAlert:(NSString *)alertText forRegion:(NSString *)regionIdentifier {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertText
                                                      message:regionIdentifier
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}


- (void)showAlertWithMessage:(NSString*)alertText {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message:"
                                                        message:alertText
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)Submit:(id)sender {
    
    _skier.verticalSkied = 5000;
    [stat setAndSubmitVerticalSkied: _skier.verticalSkied];
}

- (IBAction)getvert:(id)sender {
    _verSkiedLabel.text = [NSString stringWithFormat: @"%d", [stat getVerticalFeetSkied]];
}
@end
