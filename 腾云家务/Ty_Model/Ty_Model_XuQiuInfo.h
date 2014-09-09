//
//  XuQiuInfo.h
//  短工平台1.0
//
//  Created by liu on 13-6-18.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
#import "My_CouponDetailedModel.h"

@interface Ty_Model_XuQiuInfo : NSObject
{
    Ty_Model_XuQiuInfo *copy;
}


@property (nonatomic,retain) NSString * workGuid;//工种的guid

@property (nonatomic,retain) NSString * workName;//工种的名字

@property (nonatomic,retain) NSString * workPhoto;//工种的图片

@property (nonatomic,retain) NSString* contact;//联系人

@property (nonatomic,retain) NSString* contactPhone;//联系人电话

@property (nonatomic,retain) NSString *submitTime;//需求的提交时间

@property (nonatomic,retain) NSString *startTime;//起始时间

@property (nonatomic,retain) NSString *endTime;//终止时间 有可能没有结束时间

@property (nonatomic,retain) NSString* workAmount;//需求的总工作量

@property (nonatomic,retain) NSString *priceUnit;//单价

@property (nonatomic,retain) NSString *priceTotal;//总价 不一定用到

@property (nonatomic,retain) NSString * appointMoney;//约定价格

@property (nonatomic,retain) NSString * realMoney;//最后成交价格

@property (nonatomic,retain) NSMutableArray* selectUserArray;//选中中介下的短工集合

@property (nonatomic,retain) NSString *city; //城市

@property (nonatomic,retain) NSString* province;//省

@property (nonatomic,retain) NSString* area;//区

@property (nonatomic,retain) NSString* region;//区域

@property (nonatomic,retain) NSString *addressDetail;//详细地址

@property (nonatomic,retain) NSMutableArray *employeeArr; //

//@property (nonatomic,strong) NSString *couponGuid;//优惠券Guid
//
//@property (nonatomic,strong) NSString *couponTitle;//优惠券名字
//
//@property (nonatomic,strong) NSString *couponPrice;//优惠券金额

/*
 服务要求中一些的要求
 */

@property (nonatomic,retain) NSString * ask_Price;//价格要求

@property (nonatomic,retain) NSString *ask_Sex; //性别要求 0 女 1 男 －1不限

@property (nonatomic,retain) NSString *ask_Age;//同上

@property (nonatomic,retain) NSString * ask_Evaluate;//星级要求

@property (nonatomic,retain) NSString *ask_WorkExperience;//同上

@property (nonatomic,retain) NSString *ask_Distance;//同上

@property (nonatomic,retain) NSString *ask_Education;//同上

@property (nonatomic,retain) NSString *ask_Ethnic;//民族要求

@property (nonatomic,retain) NSString * ask_Hometown;//籍贯要求

@property (nonatomic,retain) NSString * ask_Other;//其他要求 (备注)

/*
 需求相关的信息等
 */
@property (nonatomic,retain) NSString *requirementGuid;//需求的guid

@property (nonatomic,retain) NSString *requirementNumber;//需求编号

@property (nonatomic,retain) NSString * requirement_Stage;//需求状态

@property (nonatomic,retain) NSString * requirementStageText;//是否是服务中

@property (nonatomic,retain) NSString * pay_Stage;//支付状态  // 1：线上支付  2：线下支付 3：未支付

@property (nonatomic,retain) NSString * requirement_Type;//需求的类型 0直接发布 1直接预约


@property (nonatomic,retain)NSString* isApply; //推送给附近的服务商或人

@property (nonatomic,retain) NSString *employeeCount;//需求应征的个数

@property (nonatomic,retain) NSString *confirmTime;//需求达成交易的时间

@property (nonatomic,retain) NSString * updateTime;//需求最后的更新时间

@property (nonatomic,retain) My_CouponDetailedModel * usedCouponInfo;//使用的优惠券的信息

/*
 雇主、发布人相关的信息
 */
@property (nonatomic,retain) NSString * publishUserGuid;//雇主的userGuid

@property (nonatomic,retain) NSString * publishUserName;//雇主的userName

@property (nonatomic,retain) NSString * publishUsrRealName;//雇主的真实姓名

@property (nonatomic,retain) NSString * publishUserType;//雇主的类型 －1不限 0只显示商铺 1只显示签约员工 2只显示个人 3**

@property (nonatomic,retain) NSString * publishUserSex;//雇主的性别

@property (nonatomic,retain) NSString * publishUserPhoto;//发布人的头像地址

@property (nonatomic,retain) NSString * publishUserPhone;//发布人的电话

@property (nonatomic,retain) NSString * publishUserEvaluate;//发布人的星级

@property (nonatomic,retain) NSString * publishUserAnnear;//发布人的锤炼号

/*
 需求相关的，雇工的相关信息
 */
@property (nonatomic,retain) Ty_Model_ServiceObject * serverObject;//确定的雇工对象

@property(nonatomic,strong)NSString * oldOrderPersonRealName;//上一个预约人的姓名
/*
 用户基于需求的信息
 */
@property (nonatomic,retain) NSString * userTypeBaseOnRequirement;//基于需求，用户的身份 0 雇主 1雇工
@property (nonatomic,retain) NSString * candidateStatus;//我是否应征 0未应征 1应征

//评价
@property (nonatomic,retain) NSString *evaluateStage;//评价状态
@property (nonatomic,retain) NSString *totalPJ_For_Employee;//对雇工整体的评价
@property (nonatomic,retain) NSString *detailPJ_For_Employee;//详细的评价
@property (nonatomic,retain) NSString *servicePJ_For_Employee;//服务
@property (nonatomic,retain) NSString *speedPJ_For_Employee;//速度
@property (nonatomic,retain) NSString *attitudePJ_For_Employee;//态度
@property (nonatomic,retain) NSString * totalPJ_For_Employer;//对雇主的整体评价
@property (nonatomic,retain) NSString * detailPJ_For_Employer;//详细的评价

-(void)dealloc;

@end
