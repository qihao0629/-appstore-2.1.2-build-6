//
//  Ty_MapGlobalSingleton.m
//  腾云家务
//
//  Created by AF on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MapGlobalSingleton.h"

@implementation Ty_MapGlobalSingleton

@synthesize mapView = _mapView;

static Ty_MapGlobalSingleton * mapGlobal = nil;


+ (Ty_MapGlobalSingleton*)sharedInstance
{
    if (mapGlobal == nil) {
        mapGlobal = [[super allocWithZone:NULL] init];
        
    }

    return mapGlobal;
}

-(void)UpdateMapView{

    _mapView.delegate = nil;

}

- (id)init{

    self = [super init];
    if (self) {
        
        _mapView = [[MKMapView alloc]init];
        
    }
    return self;
}



@end
