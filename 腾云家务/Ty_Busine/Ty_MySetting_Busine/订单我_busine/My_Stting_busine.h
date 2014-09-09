//
//  My_Stting_busine.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "My_SettingUpadteModel.h"
@interface My_Stting_busine : TY_BaseBusine
@property (nonatomic,strong) My_SettingUpadteModel * my_setUpadteModel;
/**查询商户状态,余额*/
-(void)loadUpdateMySetting;

@end
