//
//  CameraDetailViewController.m
//  1984
//
//  Created by Stefan Fodor on 21/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import "CameraDetailViewController.h"

@interface CameraDetailViewController ()

@end

@implementation CameraDetailViewController {
    CLLocationCoordinate2D *camera_position;
}

@synthesize cameraName,url_string,cameraImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //grab the image
    NSURL *imageURL = [NSURL URLWithString:url_string];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    //image.size.width;
    
    //no not hide it anymore
    //cameraImage.image.size
    cameraImage.image = image;
    cameraImage.hidden = NO;
    
    //set the title
    self.navigationItem.title = self.cameraName;

    //[setCameraDistancePrompt :];
}

/*
 * Close the modal
 */
- (IBAction)tappedCloseModal:(id)sender {
    [self dismissViewControllerAnimated: YES completion:nil];
}

/*
 * Set the camera name
 */
-(void) setCameraName :(NSString *)name {
    cameraName = name;
}

/*
 * And the Image URL
 */
-(void) setImageURLFromUID :(NSString *)uid {
    
    url_string = [NSString stringWithFormat:@"%@%@", @"http://kameraspotter.information.dk/image/", uid];

}

-(void) setCameraPosition :(CLLocationCoordinate2D *)position {
    camera_position = position;
}

/*
 * Updates the view
 */
-(void)setCameraDistancePrompt :(CLLocationDistance)nearestCameraDistance {
    
    NSString *displayString;
    
    //less than 100m
    if( nearestCameraDistance < 100 ) {
        
        displayString = [NSString stringWithFormat:@"Camera Distance: %.2f meters", nearestCameraDistance];
        
    }else if (nearestCameraDistance < 1000) {
        
        displayString = [NSString stringWithFormat:@"Camera Distance: %.0f meters", nearestCameraDistance];
        
    } else if (nearestCameraDistance < 10000) {
        
        nearestCameraDistance = nearestCameraDistance / 1000;
        displayString = [NSString stringWithFormat:@"Camera Distance: %.2f km", nearestCameraDistance];
        
    } else {
        nearestCameraDistance = nearestCameraDistance / 1000;
        displayString = [NSString stringWithFormat:@"Camera Distance: %.0f km", nearestCameraDistance];
    }
    
    //display
    self.navigationItem.prompt = displayString;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
