//
//  Ty_MapHomeVC.h
//  腾云家务
//
//  Created by AF on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//首页地图界面
#import "TYBaseView.h"
#import <MapKit/MapKit.h>
#import "BasicMapAnnotation.h"

@protocol MapViewControllerDidSelectDelegate;

@interface Ty_MapHomeVC : TYBaseView<MKMapViewDelegate>
{
    BOOL IsUpdateMap;
    NSMutableArray * _mapAnnotationArray;//数据接收数组
    NSMutableArray * _basicAnnotationArray;//大头针数组
}
@property(nonatomic,strong) MKMapView * _mapView;
@property(nonatomic,strong) NSString * workGuid;

@end
