//
//  My_ShopManage_busine.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "My_AddEmployeeModel.h"
@interface My_ShopManage_busine : TY_BaseBusine
@property (nonatomic,strong) NSMutableArray * array_manage;

/**商户管理员工列表*/
-(void)My_ShopManage_Req:(NSString *) currentPage;

/**添加商户员工*/
-(void)My_AddEmployeeCode_Req:(My_AddEmployeeModel *)addModel;

@end
