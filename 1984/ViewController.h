//
//  ViewController.h
//  1984
//
//  Created by Stefan Fodor on 20/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic) NSMutableArray *allLocations;

@end
