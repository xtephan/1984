//
//  CameraAnnotationView.m
//  1984
//
//  Created by Stefan Fodor on 20/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import "CameraAnnotationView.h"

@implementation CameraAnnotationView

-(id) initWithAnnotationWithImage:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier annotationViewImage:(UIImage *) anonViewImage {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    self.image = anonViewImage;
    
    return self;
}

@end
