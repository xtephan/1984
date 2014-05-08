//
//  ViewController.h
//  1984
//
//  Created by Stefan Fodor on 20/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CameraDetailViewController.h"

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong,nonatomic) NSMutableArray *allLocations;

@end
