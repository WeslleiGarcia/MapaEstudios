//
//  ViewController.m
//  BPDMaps
//
//  Created by Wesllei on 12/05/15.
//  Copyright (c) 2015 Wesllei. All rights reserved.
//

#import "ViewController.h"
#import "BPDStudios.h"
#import "BPDStudioStore.h"


@interface ViewController ()

@end


#define WIMB_LATITUDE -3.1278022508677714;
#define WIMB_LONGITUDE -60.02970690000001;

//Span
#define THE_SPAN 0.01f;

@implementation ViewController

@synthesize mapview = _mapview;
@synthesize achou;
@synthesize locationManager;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapview.delegate = self;
    
    [self.view addSubview:self.mapview];
    MKCoordinateRegion myRegion;
    
    //Center
    CLLocationCoordinate2D center;
    center.latitude = WIMB_LATITUDE;
    center.longitude = WIMB_LONGITUDE;
    
    //Span
    MKCoordinateSpan span;
    span.latitudeDelta = THE_SPAN;
    span.longitudeDelta = THE_SPAN;
    
    myRegion.center = center;
    myRegion.span = span;
    
    
    //Set our mapView
    [_mapview setRegion:myRegion animated:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        [locationManager requestWhenInUseAuthorization];
        
    }
    
    [locationManager startUpdatingLocation];
    mapview.showsUserLocation = YES;
    mapview.delegate = self;
    
    
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    //Cords
    CLLocationCoordinate2D myLocation = [userLocation coordinate];
    if(achou==0){
        //Zoom
        achou=1;
        MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 300, 300);
        
        //Show Location
        [self.mapview setRegion:zoomRegion animated:YES];
        
    }
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *view = [self.mapview dequeueReusableAnnotationViewWithIdentifier:@"annoView"];
    if(!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annoView"];
    }
    view.image = [UIImage imageNamed:@"disco16px.ico"];
    view.canShowCallout = YES;
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil; }
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            _mapview.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mapview.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mapview.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}
@end
