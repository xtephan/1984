//
//  ViewController.m
//  1984
//
//  Created by Stefan Fodor on 20/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import "ViewController.h"
#import "Annotation.h"

#define MAP_SPAN 0.01f

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView,allLocations;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initData];
    
    [self centerMap];
    
    NSLog(@"docdscdcsdne");
    
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:@"http://kameraspotter.information.dk/api/list"]];
    

    NSError *error;
    NSMutableDictionary *allCourses = [NSJSONSerialization
                                       JSONObjectWithData:allCoursesData
                                       options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                       error:&error];


    if( error ) {
        NSLog(@"%@", [error localizedDescription]);
    
    } else {
        
        for ( NSDictionary *theCourse in allCourses ) {
            
             NSLog(@"Title: %@", theCourse[@"uid"] );
            
            /*NSLog(@"----");
            NSLog(@"Title: %@", theCourse[@"title"] );
            NSLog(@"Speaker: %@", theCourse[@"speaker"] );
            NSLog(@"Time: %@", theCourse[@"time"] );
            NSLog(@"Room: %@", theCourse[@"room"] );
            NSLog(@"Details: %@", theCourse[@"details"] );
            NSLog(@"----");*/
        }
        
    }
    
    
    //add a few cameras
    [self addCamera: 55.3964792 :10.3920484 :@"First Camera" :@"Subtitle for #1"];
    [self addCamera: 55.394566 :10.3841305 :@"Seconds Camera" :@"Subtitle for #2"];
    
    //and drop them to view
    [self drawCameras];
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
    
    //list of all camera locations
    allLocations = [[NSMutableArray alloc] init];
}

/*
 * Adds a camera to the list of cameras to be displayed
 */
-(void) addCamera :(double)latitude :(double)longitude :(NSString *)title :(NSString *)subtitle {

    
    //set lat and long
    CLLocationCoordinate2D cameraLocation;
    cameraLocation.latitude = latitude;
    cameraLocation.longitude = longitude;
    
    
    //Set the annotation
    Annotation *cameraAnnotation = [[Annotation alloc] init];
    
    cameraAnnotation.coordinate = cameraLocation;
    cameraAnnotation.title = title;
    cameraAnnotation.subtitle = subtitle;
    
    //add it to the list
    [self.allLocations addObject:cameraAnnotation];
}

/*
 * Center the map around the "tobe" user location
 */
-(void) centerMap {
    
    //spawn map at a given coordonate
    CLLocationCoordinate2D mapCenter;
    mapCenter.latitude = 55.3939695;
    mapCenter.longitude = 10.3872602;
    
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
