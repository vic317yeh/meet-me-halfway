//
//  FirstViewController.m
//  MeetUp
//
//  Created by Kevin Frans on 9/6/14.
//  Copyright (c) 2014 Kevin Frans. All rights reserved.
//

#import "Singleton.h"

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


- (float)deviceLocationLat {
    return _map.userLocation.location.coordinate.latitude;
}

- (float)deviceLocationLong {
    return _map.userLocation.location.coordinate.longitude;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    [locationManager startUpdatingLocation];
    
    [_textField addTarget:self
                   action:@selector(textFieldDidChange)
         forControlEvents:UIControlEventEditingChanged];
    
    
    [self performSelector:@selector(textFieldDidChange) withObject:nil afterDelay:2.0];

    
}


-(void) textFieldDidChange
{
    [self changeMap];
    
    [self performSelector:@selector(textFieldDidChange) withObject:nil afterDelay:2.0];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self changeMap];
}

-(void) changeMap
{
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

- (void)viewWillAppear:(BOOL)animated {
    // 1
    [self changeMap];
}

@end
