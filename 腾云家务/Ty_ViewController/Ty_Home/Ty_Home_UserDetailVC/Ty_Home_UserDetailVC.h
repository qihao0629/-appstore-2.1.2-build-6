//
//  Ty_Home_UserDetailVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_Home_UserDetailBusine.h"

@interface Ty_Home_UserDetailVC : TYBaseView
@property(nonatomic,strong)Ty_Home_UserDetailBusine* userDetailBusine;


-(void)Home_UserDetail:(enum Ty_Home_UserDetailType)_Ty_Home_UserDetailType;//初始化方法
@end
