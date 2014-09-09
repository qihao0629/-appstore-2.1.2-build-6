#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BasicMapAnnotation : NSObject <MKAnnotation> {
    NSString* _title;
    NSString* _subtitle;
    CLLocationCoordinate2D _coordinate;
}

- (id)initWithTitle:(NSString*)title Subtitle:(NSString*)subtitle Coordinate:(CLLocationCoordinate2D)coordinate;

@end
