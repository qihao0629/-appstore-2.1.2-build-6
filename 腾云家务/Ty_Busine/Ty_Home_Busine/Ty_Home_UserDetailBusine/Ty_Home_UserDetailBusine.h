//
//  Ty_Home_UserDetailBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_XuQiuInfo.h"
#import "My_CouponDetailedModel.h"
@interface Ty_Home_UserDetailBusine : TY_BaseBusine
@property(nonatomic,strong)Ty_Model_ServiceObject* userService;
@property(nonatomic,strong)Ty_Model_XuQiuInfo* xuqiuInfo;//需求
@property(nonatomic,strong)My_CouponDetailedModel * coupon;//优惠券
@property(nonatomic,strong)NSString* _selectWorkName;//选中的工种名字
@property(nonatomic,strong)NSString* _selectWorkGuid;//选中的工种的guid
-(void)loadDatatarget;//初始化网络获取数据

-(UIViewController*)appointMentAction:(enum Ty_Home_UserDetailType)_ty_home_UserDetailType;//预约下单或选定（下方按钮点击方法）

-(UIViewController*)appointMentUsersAction:(int)sender;//点击员工的预约下单

-(UIViewController*)moreUsersAction:(enum Ty_Home_UserDetailType)_home_userDetailType;//更多员工

-(UIViewController*)moreEvaluation;//更多评价

-(UIViewController*)addressForMap;//跳入地图

-(void)clickWorkType:(NSInteger)_index;//点击某一服务（工种）

-(UIViewController*)clickUsers:(NSInteger)_index Home_UserDetailType:(enum Ty_Home_UserDetailType)_home_UserDetailType;//点击某位员工

-(UIViewController*)clickMessage;//消息聊天

-(void)setAddUser;//关注与取消

@end
