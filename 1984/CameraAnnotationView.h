//
//  CameraAnnotationView.h
//  1984
//
//  Created by Stefan Fodor on 20/04/14.
//  Copyright (c) 2014 Stefan Fodor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CameraAnnotationView : MKAnnotationView {
    
}

-(id) initWithAnnotationWithImage:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier annotationViewImage:(UIImage *) anonViewImage;

@end
