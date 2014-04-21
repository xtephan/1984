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

-(void) setCameraName :(NSString *)name;
-(void) setImageURLFromUID :(NSString *)uid;

@end
