//
//  Ty_MapGlobalSingleton.h
//  腾云家务
//
//  Created by AF on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//地图全局单例
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Ty_MapGlobalSingleton : NSObject

//初始化
+ (Ty_MapGlobalSingleton*)sharedInstance;

@property(nonatomic,strong) MKMapView * mapView;

@end
