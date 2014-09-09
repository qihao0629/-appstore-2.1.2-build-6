//
//  Ty_Pub_RequirementsBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_XuQiuInfo.h"
@interface Ty_Pub_RequirementsBusine : TY_BaseBusine
@property(nonatomic,strong)Ty_Model_XuQiuInfo* xuqiuInfo;
-(void)pub_Requirements;
@end
