//
//  CameraDetailViewController.h
//  1984
//
//  Created by Stefan Fodor on 21/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CameraDetailViewController : UIViewController

@property(weak,nonatomic) NSString *cameraName;
@property(weak,nonatomic) NSString *url_string;

@property (weak, nonatomic) IBOutlet UIImageView *cameraImage;

- (IBAction)tappedCloseModal:(id)sender;

-(void) setCameraPosition :(CLLocationCoordinate2D *)position;
-(void) setCameraName :(NSString *)name;
-(void) setImageURLFromUID :(NSString *)uid;

@end
