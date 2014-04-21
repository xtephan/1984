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

@implementation CameraDetailViewController

@synthesize cameraName,url_string,cameraImage,navigationbar;

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
    navigationbar.title = self.cameraName;
}

/*
 * Close the modal
 */
- (IBAction)tappedCloseModal:(id)sender {
    [self dismissModalViewControllerAnimated: YES];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
