//
//  MyAnnotation.h
//  mapView
//
//  Created by qianfeng on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>{
    NSString* _title;
    NSString* _subtitle;
    CLLocationCoordinate2D _coordinate;
}

- (id)initWithTitle:(NSString*)title Subtitle:(NSString*)subtitle Coordinate:(CLLocationCoordinate2D)coordinate;

@end
