#import "BasicMapAnnotation.h"

@interface BasicMapAnnotation()


@end

@implementation BasicMapAnnotation

- (id)initWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Coordinate:(CLLocationCoordinate2D)coordinate{
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title{
    return _title;
}

- (NSString *)subtitle{
    return _subtitle;
}

- (CLLocationCoordinate2D)coordinate{
    
    return _coordinate;
}

@end
