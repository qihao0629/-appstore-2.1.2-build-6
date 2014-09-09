//
//  My_Registered_busine.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_Registered_busine : TY_BaseBusine

/**验证码获取*/
-(void)my_YanZhengMa_busine:(NSMutableDictionary *)_dic;
/**短信验证码验证*/
-(void)my_CheckYanZhengMa_busine:(NSMutableDictionary *)_dic;
/**注册用户信息*/
-(void)my_Registered_busine:(NSMutableDictionary *)_dic;

/**注册商户信息*/
-(void)my_enterpriseRegisterd_busine:(NSMutableDictionary *)_dic;

@end
