//
//  Ty_Home_UserDetail_moreEvaluationBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
@interface Ty_Home_UserDetail_moreEvaluationBusine : TY_BaseBusine
@property(nonatomic,strong)Ty_Model_ServiceObject* userService;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)BOOL _isRefreshing;
-(void)loadEvaluationData;
@end
