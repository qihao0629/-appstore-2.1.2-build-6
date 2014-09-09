//
//  My_ShopAddWork_busine.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_WorkListInfo.h"
@interface My_ShopAddWork_busine : TY_BaseBusine

/**商户添加服务项目*/
-(void)loadDataAddWork:(Ty_Model_WorkListInfo *)WorklistModel;

@end
