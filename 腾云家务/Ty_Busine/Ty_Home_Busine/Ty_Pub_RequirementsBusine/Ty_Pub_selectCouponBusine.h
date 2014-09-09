//
//  Ty_Pub_selectCouponBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-8-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "My_CouponDetailedModel.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_Model_ServiceObject.h"
@interface Ty_Pub_selectCouponBusine : TY_BaseBusine
@property (nonatomic,strong) My_CouponDetailedModel * my_coupon_model;
@property (nonatomic,strong) NSMutableArray * array_Coupon;
@property (nonatomic,strong) Ty_Model_XuQiuInfo * xuqiuInfo;
@property (nonatomic,strong) Ty_Model_ServiceObject * serverObject;
-(void)Pub_CouponRequest;
@end
