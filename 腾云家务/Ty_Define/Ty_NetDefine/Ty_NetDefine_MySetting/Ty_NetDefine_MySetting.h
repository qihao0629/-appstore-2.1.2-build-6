//
//  Ty_NetDefine_MySetting.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//接口宏 文件
#ifndef _____Ty_NetDefine_MySetting_h
#define _____Ty_NetDefine_MySetting_h

/**登录接口*/
#define My_Login_Req @"login/Login.action"
/**获取验证码*/
#define My_YanZheng_Req @"user/CheckPhoneExitisSendCode.action"
/**验证码验证接口*/
#define My_CheckYanZheng_Req @"send/Check.action"
/**注册用户信息*/
#define My_Registered_Req @"user/newRegister.action"
/**忘记密码验证手机号*/
#define My_UserPhone_Req @"user/CheckPhoneExitsRegSendCode.action"
/**重置密码*/
#define My_ChongZhiUserPwd_Req @"user/UpdateUserPassword.action"
/**退出登录*/
#define My_LogOut_Req @"login/Loginout.action"
/**我的关注**/
#define My_MyAttention_Req @"contact/SearchMyCare.action"
/**我的粉丝**/
#define My_MyFans_Req @"contact/SearchMyFans.action"
/**我的优惠券——雇主**/
#define My_EmployerCoupon_Req @"coupon/SearchUserCouponList.action"
/**我的优惠券详细——雇主**/
#define My_CouponDetailed_Req @"coupon/SearchCouponDetail.action"
/**我的优惠券商户列表*/
#define My_CouponShopList_Req @"coupon/SearchCouponSuitCompany.action"
/**我的商户验证优惠券*/
#define My_ShopCouponYanzheng_Req @"coupon/SearchCouponRegex.action "
/**中介公司收到的优惠券*/
#define My_ShopCouponList @"coupon/SearchCompanyCouponList.action"
/**雇主信息**/
#define My_EmployerInForm_Req @"user/UpdateUser.action"
/**商户查看手下员工**/
#define My_CompanyLookEmployees_Req @"user/SearchAgencyEmployeeList.action"
/**提现接口*/
#define  My_DrawMoney_Req @"withdraw/Insert.action"
/**查询提现记录*/
#define My_DrawRecord_Req @"withdraw/Search.action"
/**银行信息*/
#define My_BankMsg_Req @"withdraw/QueryMyDefaultBankCardAndMoney.action"
/**获取商户信息**/
#define My_ShopInForm_Req @"user/SearchAgencyDetail.action"
/**查询交易记录*/
#define My_TradingRecord_Req @"requirement/QueryUserDealRecord.action"
/**修改商户信息*/
#define My_ShopInFormUpdate_Req @"user/UpdateAgency.action"
/**商户信息提交审核*/
#define My_shopSubmit_Req @"user/submitCheck.action"
/**商户下员工查询*/
#define My_SERVICE_GETSearch @"user/SearchAgencyEmployeeList.action"
//添加商户员工
#define My_AddEmployee_Req @"user/AddContractEmployee.action"
//用户技能信息查询 服务项目
#define My_USERSETSKILL @"post/SearchUserPost.action"
//用户技能信息删除 服务项目
#define My_USERSKILLDELETE @"post/DeleteUserPost.action"
//用户技能信息修改
#define My_USERSKILLUPDATE @"post/UpdateUserPost.action"
//用户技能信息添加
#define My_USERSKILLADD @"post/AddUserPost.action"
/**查询审核状态和剩余金额*/
#define My_SearchCheckStateAndMoney @"user/SearchCheckStateAndMoney.action"
/**商户信息提交审核*/
#define My_ShopSubmitCheck @"user/submitCheck.action"
/**帮助与反馈*/
#define My_Help @"config/FeedBack.action"
#endif
