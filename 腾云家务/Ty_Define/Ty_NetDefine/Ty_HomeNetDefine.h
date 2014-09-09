//
//  Ty_HomeNetDefine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_HomeNetDefine_h
#define _____Ty_HomeNetDefine_h

//检测版本号
//检测版本号
#define GetIosVersionUrl @"config/GetIosVersionInfo.action"

//获取所有工种
#define Home_QueryWorkTree @"work/queryWorkTree.action"

//banner 获取
#define Home_BannerUrl @"activitie/SearchAcSign.action"

//工种列表
#define WorkTypeUrl @"work/SearchLookServeList.action"

//发布抢单
#define AddRequirementUrl  @"requirement/AddRequirement.action"

//找服务列表
#define EmployeeUrl @"post/SearchPostListByWork.action"

//模糊搜索匹配短工列表
#define SearchEmployeeUrl @"post/SearchPostListByTerm.action"

//个人详细信息获取
#define EmployeeDetailUrl @"user/SearchUserByUserGuidAndMyGuid.action"

//根据工种获取中介下员工
#define Ty_UserDetail_UserUrl @"post/SearchPostListByWorkGuid.action"

//获取历史评价
#define Ty_UserDetail_EvaluateUrl @"evaluate/SearchUserHistoryEvaluate.action"

//直接预约选择工种
#define AddRequirementWorkTypeUrl @"work/SearchUserWrokTree.action"

//收藏及取消收藏
#define AddUserUrl @"contact/AddContact.action"

//获取可选优惠券
#define CouponSelectUrl @"coupon/SearchSuitableCouponList.action"

//电话统计
#define PhoneUrl @"config/phoneTotal.action"

#endif
