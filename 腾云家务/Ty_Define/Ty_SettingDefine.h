//
//  Ty_SettingDefine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_SettingDefine_h
#define _____Ty_SettingDefine_h

#pragma mark ----字体大小

/**
 *字体大小
 */
#define FONT7_SYSTEM [UIFont systemFontOfSize:7]
#define FONT8_SYSTEM [UIFont systemFontOfSize:8]
#define FONT9_SYSTEM [UIFont systemFontOfSize:9]
#define FONT10_SYSTEM [UIFont systemFontOfSize:10]
#define FONT11_SYSTEM [UIFont systemFontOfSize:11]
#define FONT12_SYSTEM [UIFont systemFontOfSize:12]
#define FONT13_SYSTEM [UIFont systemFontOfSize:13]
#define FONT14_SYSTEM [UIFont systemFontOfSize:14]
#define FONT15_SYSTEM [UIFont systemFontOfSize:15]
#define FONT16_SYSTEM [UIFont systemFontOfSize:16]
#define FONT17_SYSTEM [UIFont systemFontOfSize:17]
#define FONT18_SYSTEM [UIFont systemFontOfSize:18]
#define FONT19_SYSTEM [UIFont systemFontOfSize:19]
#define FONT20_SYSTEM [UIFont systemFontOfSize:20]

#define FONT7_BOLDSYSTEM [UIFont boldSystemFontOfSize:7]
#define FONT8_BOLDSYSTEM [UIFont boldSystemFontOfSize:8]
#define FONT9_BOLDSYSTEM [UIFont boldSystemFontOfSize:9]
#define FONT10_BOLDSYSTEM [UIFont boldSystemFontOfSize:10]
#define FONT11_BOLDSYSTEM [UIFont boldSystemFontOfSize:11]
#define FONT12_BOLDSYSTEM [UIFont boldSystemFontOfSize:12]
#define FONT13_BOLDSYSTEM [UIFont boldSystemFontOfSize:13]
#define FONT14_BOLDSYSTEM [UIFont boldSystemFontOfSize:14]
#define FONT15_BOLDSYSTEM [UIFont boldSystemFontOfSize:15]
#define FONT16_BOLDSYSTEM [UIFont boldSystemFontOfSize:16]
#define FONT17_BOLDSYSTEM [UIFont boldSystemFontOfSize:17]
#define FONT18_BOLDSYSTEM [UIFont boldSystemFontOfSize:18]
#define FONT19_BOLDSYSTEM [UIFont boldSystemFontOfSize:19]
#define FONT20_BOLDSYSTEM [UIFont boldSystemFontOfSize:20]

/**
 *颜色
 */

#define view_BackGroudColor [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]

//字体颜色
#define text_RedColor [UIColor redColor]//红色
#define text_GreenColor [UIColor colorWithRed:0.0/255.0 green:176.0/255.0 blue:90.0/255.0 alpha:1]//绿色
#define text_grayColor [UIColor grayColor]//灰色
#define text_blackColor [UIColor blackColor]//红色
#define text_morenGrayColor [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1]//默认灰色
#define text_ReqColor [UIColor colorWithRed:218.0/255.0 green:103.0/255.0 blue:0/255.0 alpha:1]
#define Color_210 [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1]
#define Color_173 [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1]
#define Color_218 [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
#define Color_225 [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1]
#define Color_230 [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1]
#define Color_245 [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]
#define Color_217 [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1]
#define Color_200 [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1]
#define Color_orange [UIColor colorWithRed:252.0/255.0 green:123.0/255.0 blue:46.0/255.0 alpha:1]
/**红色字体*/
#define ColorRedText [UIColor colorWithRed:220.0/255.0 green:0.0/255 blue:17.0/255 alpha:1.0f]

//分页页码
#define pageSize_Req @"10"

////省份
//#define USERPROVINCE  [[UserDefaultData sharedInstance] getProvince]
////城市
//#define USERCITY  [[UserDefaultData sharedInstance] getCity]
////区
//#define USERAREA  [[UserDefaultData sharedInstance] getArea]
////区域
//#define USERREGION  [[UserDefaultData sharedInstance] getRegion]
////详细地址
//#define USERADDRESSDETAIL  [[UserDefaultData sharedInstance] getAddressDetail]

//省份
#define USERPROVINCE  [[NSUserDefaults standardUserDefaults]objectForKey:@"province"]

//城市
#define USERCITY  [[NSUserDefaults standardUserDefaults] objectForKey:@"city"]

////区
#define USERAREA  [[NSUserDefaults standardUserDefaults] objectForKey:@"area"]
////区域
#define USERREGION  [[NSUserDefaults standardUserDefaults] objectForKey:@"region"]
////详细地址
#define USERADDRESSDETAIL  [[NSUserDefaults standardUserDefaults] objectForKey:@"addressDetail"]

//设置省
#define SETUSERPROVINCE(province) [[NSUserDefaults standardUserDefaults] setObject:province forKey:@"province"]
//设置城市
#define SETUSERCITY(city) [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"]
//设置区
#define SETUSERAREA(area) [[NSUserDefaults standardUserDefaults] setObject:area forKey:@"area"]
//设置区域
#define SETUSERREGION(region) [[NSUserDefaults standardUserDefaults] setObject:region forKey:@"region"]
//设置详细地址
#define SETUSERADDRESSDETAIL(addressdetail) [[NSUserDefaults standardUserDefaults] setObject:addressdetail forKey:@"addressDetail"]

#endif
