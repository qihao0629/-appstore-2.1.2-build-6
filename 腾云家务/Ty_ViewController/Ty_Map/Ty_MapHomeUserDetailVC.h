//
//  Ty_MapHomeUserDetailVC.h
//  腾云家务
//
//  Created by AF on 14-7-25.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import <MapKit/MapKit.h>
#import "Ty_Model_ServiceObject.h"
@interface Ty_MapHomeUserDetailVC : TYBaseView<MKMapViewDelegate>

@property(nonatomic,strong) MKMapView * _mapView;
@property(nonatomic,strong)Ty_Model_ServiceObject* userService;

@end
