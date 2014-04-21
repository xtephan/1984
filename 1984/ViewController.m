//
//  ViewController.m
//  1984
//
//  Created by Stefan Fodor on 20/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import "ViewController.h"
#import "Annotation.h"
#import "CameraAnnotationView.h"
#import "CameraDetailViewController.h"

#define MAP_SPAN 0.01f
#define SPAWN_LATITUDE 55.3939695
#define SPAWN_LONGITUDE 10.3872602

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading_spin;
@end

@implementation ViewController {
    
    CLLocationManager *locationManager;
    
    CLLocationCoordinate2D lastPosition;
    
}

@synthesize mapView,allLocations;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //inittiate the data
    [self initData];
    
    //grab the current location
    [locationManager startUpdatingLocation];
    
    //download data
    [self fetchData];
    
    //center the map and show it show the map
    mapView.hidden = NO;
    [self centerMap];
    
    //and drop them to view
    [self drawCameras];
    
    //done, hide the spinner
    [_loading_spin stopAnimating];
}

/*
 * fetched a list of all the cameras
 */
-(void) fetchData {
    
    NSURL *json_url = [NSURL URLWithString:@"http://kameraspotter.information.dk/api/list"];
    NSData *allCamerasData = [[NSData alloc] initWithContentsOfURL: json_url];
    
    
    NSError *error;
    NSMutableDictionary *allCameras = [NSJSONSerialization
                                       JSONObjectWithData:allCamerasData
                                       options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                       error:&error];
    
    if( error ) {
        NSLog(@"%@", [error localizedDescription]);
        exit(0);
    }
    
    for ( NSDictionary *thisCamera in allCameras ) {
    
        NSString *title = Nil;
        NSString *accuracy = @"Accuracy: ";
        
        if( [thisCamera[@"message"] length] == 0 ) {
            title = @"No title";
        } else {
            title = thisCamera[@"message"];
        }
        
        
        if( [thisCamera[@"accuracy"] length] == 0 ) {
            accuracy = [accuracy stringByAppendingString:@"N/A"];
        } else {
            accuracy = [accuracy stringByAppendingString:thisCamera[@"accuracy"]];
        }
        
        [self addCamera :[thisCamera[@"latitude"] doubleValue]
                        :[thisCamera[@"longitude"] doubleValue]
                        :title
                        :accuracy
                        :thisCamera[@"uid"]
         ];
    
    }
    
}

/*
 * Used to dispay custom annotation
 */
-(MKAnnotationView *)mapView :(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    //do not change the blue dot, aka user location
    if( [annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    NSString *annotationIdentifier = @"CameraViewAnnotation";
    
    CameraAnnotationView *cameraAnnotationView = (CameraAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if(!cameraAnnotationView) {
        cameraAnnotationView = [[CameraAnnotationView alloc] initWithAnnotationWithImage:annotation reuseIdentifier:annotationIdentifier annotationViewImage:[UIImage imageNamed:@"video.png"]];
        
        cameraAnnotationView.canShowCallout = YES;
        cameraAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    return cameraAnnotationView;
}

/*
 * Intercept the tap event on the callout
 */
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    [self performSegueWithIdentifier:@"Camera Detail Segue" sender:view];

}

/*
 * Pass the annotation details to the new view
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"Camera Detail Segue"]) {
        
        //controller for the new view
        CameraDetailViewController *cdvc = [segue destinationViewController];
        
        //annotationview
        CameraAnnotationView *annotationView = (CameraAnnotationView *)sender;
        
        //extract the actual annotation from the view
        Annotation *annotation = [annotationView annotation];
        
        //and set values for the view controller
        [cdvc setCameraName:annotation.title];
        [cdvc setImageURLFromUID:annotation.uid];

    }
    
}


/*
 * Draw cameras
 */
-(void) drawCameras {
    [self.mapView addAnnotations:allLocations];
}

/*
 * Initiate data loading
 */
-(void) initData {
    
    //init the location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //delegate map to self
    mapView.delegate = self;
    
    //list of all camera locations
    allLocations = [[NSMutableArray alloc] init];
}

/*
 * Error getting location
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@",error);
    NSLog(@"Failed getting location");
}

/*
 * Location has updated
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if( lastPosition.longitude != newLocation.coordinate.longitude && lastPosition.latitude != newLocation.coordinate.latitude ) {
    
        //save the new position
        lastPosition.latitude = newLocation.coordinate.latitude;
        lastPosition.longitude = newLocation.coordinate.longitude;
        
        //recenter the map
        [self centerMap];
        
        NSLog(@"New Position: %.8f %.8f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
        
    }
    
}

/*
 * Adds a camera to the list of cameras to be displayed
 */
-(void) addCamera :(double)latitude :(double)longitude :(NSString *)title :(NSString *)subtitle :(NSString *)uid {

    
    //set lat and long
    CLLocationCoordinate2D cameraLocation;
    cameraLocation.latitude = latitude;
    cameraLocation.longitude = longitude;
    
    
    //Set the annotation
    Annotation *cameraAnnotation = [[Annotation alloc] init];
    
    cameraAnnotation.coordinate = cameraLocation;
    cameraAnnotation.title = title;
    cameraAnnotation.subtitle = subtitle;
    cameraAnnotation.uid = uid;
    
    //add it to the list
    [self.allLocations addObject:cameraAnnotation];
}

/*
 * Center the map around the "tobe" user location
 */
-(void) centerMap {
    
    //center map at a given coordonate or at user location
    CLLocationCoordinate2D mapCenter;
    if( lastPosition.latitude && lastPosition.longitude ) {
        
        mapCenter.latitude = lastPosition.latitude;
        mapCenter.longitude = lastPosition.longitude;
        
    } else {
        
        mapCenter.latitude = SPAWN_LATITUDE;
        mapCenter.longitude = SPAWN_LONGITUDE;
        
    }
    
    //view span
    MKCoordinateSpan span;
    span.latitudeDelta = MAP_SPAN;
    span.longitudeDelta = MAP_SPAN;
    
    MKCoordinateRegion viewRegion;
    viewRegion.center = mapCenter;
    viewRegion.span = span;
    
    //Set the region
    [mapView setRegion:viewRegion animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
