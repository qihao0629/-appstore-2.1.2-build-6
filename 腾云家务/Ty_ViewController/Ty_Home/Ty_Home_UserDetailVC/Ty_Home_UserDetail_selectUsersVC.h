//
//  Ty_Home_UserDetail_selectUsersVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_Home_UserDetail_selectUsersBusine.h"
@interface Ty_Home_UserDetail_selectUsersVC : TYBaseView

@property(nonatomic,strong)Ty_Home_UserDetail_selectUsersBusine *selectUsersBusine;

-(void)Home_UserDetail:(enum Ty_Home_UserDetailType)_Ty_Home_UserDetailType;//初始化方法

@end
