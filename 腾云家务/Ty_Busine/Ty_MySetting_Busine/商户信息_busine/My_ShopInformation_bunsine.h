//
//  My_ShopInformation_bunsine.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/8.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_ShopInformation_bunsine : TY_BaseBusine

/**我的商户信息*/
-(void)My_Shopinformation_Req;

/**修改商户信息*/
-(void)My_ShopinformationUpdate_Req:(NSMutableDictionary *) _dic;

/**提交商户信息*/
-(void)My_ShopsubmitCheck_Req;

@end
