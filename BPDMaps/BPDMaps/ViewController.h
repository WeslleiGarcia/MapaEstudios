//
//  ViewController.h
//  BPDMaps
//
//  Created by Wesllei on 12/05/15.
//  Copyright (c) 2015 Wesllei. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    
    MKMapView *mapview;
}
@property int achou;

@property (strong, nonatomic) IBOutlet MKMapView *mapview;
- (IBAction)setMap:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *setSearchBar;

@property(strong, nonatomic) CLLocationManager *locationManager;