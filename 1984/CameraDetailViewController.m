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

@synthesize cameraName,url_string;

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
    
    NSLog(@"View loaded");
    NSLog(@"%@",self.cameraName);
    NSLog(@"%@",self.url_string);
}

/*
 * Set the camera name
 */
-(void) setCameraName :(NSString *)name {
    cameraName = name;
    NSLog(@"Camera name set!");
}

/*
 * And the Image URL
 */
-(void) setImageURLFromUID :(NSString *)uid {
    
    url_string = [NSString stringWithFormat:@"%@%@", @"http://kameraspotter.information.dk/image/", uid];

    NSLog(@"Image URL set!");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
