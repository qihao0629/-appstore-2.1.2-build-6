//
//  My_Employerinformation_Busine.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_Employerinformation_Busine : TY_BaseBusine

@property (nonatomic,strong)NSString * UserSexNew;
@property (nonatomic,strong)NSString * UserNameNew;

-(void)My_Employerinformation_Req:(NSMutableDictionary *)_dic;
-(void)My_EmployerImageHead_Req:(NSMutableDictionary *)_dic;
-(void)My_EmployerinformationUserSex_Req:(NSMutableDictionary *)_dic;
-(void)My_EmployerinformationUserPwd_Req:(NSMutableDictionary *)_dic;

@end
