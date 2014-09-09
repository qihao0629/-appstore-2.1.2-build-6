//
//  Ty_HomeDefine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_HomeDefine_h
#define _____Ty_HomeDefine_h

typedef NS_ENUM(NSInteger, Ty_Home_UserDetailType) {
    Ty_Home_UserDetailTypeDefault=0, //从首页正常进入
    Ty_Home_UserDetailTypeRequirement,//从需求进入
    Ty_Home_UserDetailTypeMap,//从地图进入
    Ty_Home_UserDetailTypeOther,//从关注或者粉丝进入
    Ty_Home_UserDetailTypeSelect,//从选择人进入
    Ty_Home_UserDetailTypeCoupon,//从优惠券进入
    Ty_Home_UserDetailTypeNone//无
    
};

#define Req_WorkGuid [[NSUserDefaults standardUserDefaults] objectForKey:@"Req_workGuid"]
#define Req_WorkName [[NSUserDefaults standardUserDefaults] objectForKey:@"Req_workName"]
#define Req_WorkAmount [[NSUserDefaults standardUserDefaults] objectForKey:@"Req_workAmount"]

#define SetReq_WorkGuid(id) [[NSUserDefaults standardUserDefaults] setObject:id forKey:@"Req_workGuid"]
#define SetReq_WorkName(id) [[NSUserDefaults standardUserDefaults] setObject:id forKey:@"Req_workName"]
#define SetReq_WorkAmount(id) [[NSUserDefaults standardUserDefaults] setObject:id forKey:@"Req_workAmount"]

#endif
