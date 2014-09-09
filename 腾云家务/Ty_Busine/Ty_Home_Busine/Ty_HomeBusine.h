//
//  Ty_HomeBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_HomeWorkButton.h"
@interface Ty_HomeBusine : TY_BaseBusine
@property(nonatomic,strong)NSMutableArray *MainArray;//首页获取布局信息
@property(nonatomic,strong)NSMutableArray *NumArray;//标记Cell类型数组
@property(nonatomic,strong)NSMutableArray *HomeButtonArray;//首页button值的数据源
@property(nonatomic,strong)NSMutableArray *worktypeArr;//首页二级工种数据源
@property(nonatomic,strong)NSArray* workPlist;//所有工种
@property(nonatomic,strong)NSString* workFristName;//一级工种名字
@property(nonatomic,strong)NSString* workFristGuid;//一级工种GUID
@property(nonatomic,strong)NSMutableArray* MainArr;//首页二级工种数据
@property(nonatomic,strong)NSMutableArray* bannerArr;//首页banner数据源
@property(nonatomic,assign)BOOL requestBool;

-(void)queryWorkTree;//获取所有工种存入plist
-(void)getNetHomeButton;
-(UIViewController*)Click_pub_Requirements;//发布需求
-(UIViewController*)Click_LoginVC;//登录
-(UIViewController*)searchClick:(id)sender;//搜索
-(UIViewController*)Click_WorkTypeList:(id)sender;//点击工种跳转找服务列表
-(UIViewController *)click_homeWorkButton:(Ty_HomeWorkButton *)sender;//点击红色工种方法

@end
