//
//  Ty_News_busine_Order_DataBase.h
//  腾云家务
//
//  Created by lgs on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_Model_ServiceObject.h"

@interface Ty_News_busine_Order_DataBase : NSObject
{
}
@property (nonatomic,retain) Ty_Model_XuQiuInfo * dataBaseXuQiu;
@property (nonatomic,retain) Ty_Model_ServiceObject * dataBaseServiceObject;

+ (Ty_News_busine_Order_DataBase *)share_Busine_DataBase;

#pragma mark 需求详情表的相关

-(NSString *)getRequirementUpdateTime:(NSString *)_requirementGuid;/**获取这个需求的更新时间*/

//0雇主 1雇工
-(void)saveRequirementDetail:(NSMutableDictionary *)_dic andUserType:(NSString *)_userType;/**保存到数据库中*/

-(BOOL)getRequirementDetailWithGuid:(NSString *)_requirementGuid;/**是否得到这条需求的详情*/

-(void)updateRequirementDetailAndGuid:(NSString *)_requirementGuid ankDic:(NSMutableDictionary *)_dic;
-(void)updateRequirementDetailAndGuid:(NSString *)_requirementGuid andKeys:(NSMutableArray *)_keys andValues:(NSMutableArray *)_values;/**更新需求详情的某些数据*/

-(void)saveOrderCoupon:(NSMutableDictionary *)_dic withRequiremnetGuid:(NSString *)_requirementGuid;

-(BOOL)getOrderCoupon:(NSString *)_requirementGuid;//是否得到该需求的优惠券

//个人认为不需要更新

#pragma mark 评价相关的

-(BOOL)judgeIfExitEvaluateWithGuid:(NSString *)_requirementGuid;//判断是否数据库是否有这个评价

-(void)saveEvaluateAndRequirementGuid:(NSString *)_requirementGuid andEvaluateDic:(NSMutableDictionary *)_evaluateDic;/**保存某条需求的评价*/

-(NSMutableDictionary *)getEvaluateAndGuid:(NSString *)_requirementGuid;/**得到某条需求的评价*/

-(void)updateEvaluateAndGuid:(NSString *)_requirementGuid andDic:(NSMutableDictionary *)_dic;

//-(void)updateEvaluateAndGuid:(NSString *)_requirementGuid andKeys:(NSMutableArray *)_keys andValues:(NSMutableArray *)_values;/**更新评价*/

#pragma mark 预约人相关的

-(BOOL)judgeIfExitOrderPersonAndRequirementGuid:(NSString *)_requirementGuid;//判断数据库是否有

-(void)saveOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andOrderUserGuid:(NSString *)_orderUserGuid andServiceObject:(Ty_Model_ServiceObject *)_object;/**预约人的详情，入库*/

-(BOOL)getOrderPersonAndRequirementGuid:(NSString *)_requirementGuid;/**是否得到预约人的相关信息*/

-(void)updateOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andServiceObject:(Ty_Model_ServiceObject *)_object;
//-(void)updateOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andDic:(NSMutableDictionary *)_dic;/**修改预约人的相关信息*/

@end
