//
//  My_ForgetPwd_busine.h
//  腾云家务
//
//  Created by AF on 14-7-21.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//忘记密码
#import <Foundation/Foundation.h>

@interface My_ForgetPwd_busine : TY_BaseBusine
/**忘记密码——验证手机号*/
-(void)MyYanzhengUserPhone:(NSString *)userPhone;
/**重置密码*/
-(void)MyChongzhiPwdPhone:(NSString *)userPhone userPassword:(NSString *)userPassword;

@end
