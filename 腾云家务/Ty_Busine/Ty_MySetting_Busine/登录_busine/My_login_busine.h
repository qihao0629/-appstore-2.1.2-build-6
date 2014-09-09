//
//  My_login_busine.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_login_busine : TY_BaseBusine


/**
 *	@brief	登录数据处理网络请求
 *
 *	@param 	dic  登录账号密码
 */
-(void)my_login_busine:(NSMutableDictionary *)dic;

/**开启登录*/
-(void)my_loginSucceed_busine:(NSMutableDictionary *)_dic;

@end
