//
//  FirstViewController.m
//  MeetUp
//
//  Created by Kevin Frans on 9/6/14.
//  Copyright (c) 2014 Kevin Frans. All rights reserved.
//

#import "FirstViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


#define METERS_PER_MILE 1609.344

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation FirstViewController
{
    CLLocationManager *locationManager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (int)deviceLocationLat {
    return locationManager.location.coordinate.latitude;
}

- (int)deviceLocationLong {
    return locationManager.location.coordinate.longitude;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];

    [_textField addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];

}

-(void) textFieldDidChange
{
    NSLog(@"%d",[self deviceLocationLat]);
    NSLog(@"%d",[self deviceLocationLong]);
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self deviceLocationLat];
    zoomLocation.longitude= [self deviceLocationLong];

    NSLog(@"%d",[self deviceLocationLat]);
    NSLog(@"%d",[self deviceLocationLong]);

    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);

    // 3
    [_map setRegion:viewRegion animated:YES];
}

@end
