//
//  Ty_MySetting_Define.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_MySetting_Define_h
#define _____Ty_MySetting_Define_h


//是否开发服务商登录 0 开放  1 不开放
#define TARGET_SHOP_OPEN 1

//判断iphone 5
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

/*键盘落下*/
#define ResignFirstResponder [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

/**屏幕大小*/
#define MainFrame [[UIScreen mainScreen] applicationFrame]
#define MainBounds [[UIScreen mainScreen] bounds]

//登录成功后状态
#define IFLOGINYES  [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLoginYes"] isEqualToString:@"1"]

/*登录成功后信息保存*/
#define MyLoginInformation [[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"]
/*登录成功后的用户userGuid*/
#define MyLoginUserGuid [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"]objectForKey:@"userGuid"]
/*用户名*/
#define MyLoginUserName [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"]objectForKey:@"userName"]
/*用户姓名*/
#define MyLoginUserRealName [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"]objectForKey:@"userRealName"]
/*用户电话*/
#define MyLoginUserPhone [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"]objectForKey:@"userPhone"]

/*用户Type 0是商户 2个人*/
#define MyLoginUserType [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"]objectForKey:@"userType"]

//MyShopInformation 商户信息
#define MyShopInforDefaults [[NSUserDefaults standardUserDefaults] objectForKey:@"MyShopInformation"]

//我的工种信息保存
#define MyWorkTreeDefaults [[NSUserDefaults standardUserDefaults] objectForKey:@"MyAddWorkTree"]

//商户信息 保存 更新的
#define MYshopInforDefaultsUpdate [[NSUserDefaults standardUserDefaults] objectForKey:@"MyShopInformationUpdate"]

//验证短信验证码的网络回调通知
#define MyPostNetNotification(id) [[NSNotificationCenter defaultCenter]postNotificationName:@"MyNetRequestReceivedCheck" object:id]

#endif
