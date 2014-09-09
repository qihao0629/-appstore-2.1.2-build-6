//
//  Ty_AppointmentSelectCategoryBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_XuQiuInfo.h"
@interface Ty_AppointmentSelectCategoryBusine : TY_BaseBusine
@property(nonatomic,strong)Ty_Model_ServiceObject *userService;
@property(nonatomic,strong)Ty_Model_XuQiuInfo *xuqiuInfo;
@property(nonatomic,assign)Ty_Home_UserDetailType home_user_detailType;
@property(nonatomic,strong)NSMutableArray *workPlist;
@property(nonatomic,strong)NSMutableArray *arrContent;
@property(nonatomic,strong)NSMutableArray *arrContent2;
-(void)sendCategory;

@end
