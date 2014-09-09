//
//  Ty_AppointmentBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_XuQiuInfo.h"
#import "My_CouponDetailedModel.h"

@interface Ty_AppointmentBusine : TY_BaseBusine
//@property(nonatomic,strong)NSString* selectworkName;
//@property(nonatomic,strong)NSString* selectworkGuid;

@property(nonatomic,strong)Ty_Model_ServiceObject* userService;
@property(nonatomic,strong)Ty_Model_XuQiuInfo* xuqiuInfo;
//@property(nonatomic,strong)My_CouponDetailedModel * coupon;//优惠券
@property(nonatomic,assign)Ty_Home_UserDetailType home_userDetailType;

-(void)pub_Appointment;
-(void)loadDatatarget;//获取选中人员的工种
@end
