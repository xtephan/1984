//
//  CameraDetailViewController.h
//  1984
//
//  Created by Stefan Fodor on 21/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraDetailViewController : UIViewController

@property(weak,nonatomic) NSString *cameraName;
@property(weak,nonatomic) NSString *url_string;

@property (weak, nonatomic) IBOutlet UIImageView *cameraImage;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationbar;

- (IBAction)tappedCloseModal:(id)sender;

-(void) setCameraName :(NSString *)name;
-(void) setImageURLFromUID :(NSString *)uid;

@end
