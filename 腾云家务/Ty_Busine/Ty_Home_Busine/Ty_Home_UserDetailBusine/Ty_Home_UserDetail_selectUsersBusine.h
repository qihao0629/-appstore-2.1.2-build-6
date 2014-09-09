//
//  Ty_Home_UserDetail_selectUsersBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_XuQiuInfo.h"
@interface Ty_Home_UserDetail_selectUsersBusine : TY_BaseBusine
{
    
}
@property(nonatomic,strong)NSString* _selectWorkName;
@property(nonatomic,strong)NSString* _selectWorkGuid;
@property(nonatomic,strong)Ty_Model_ServiceObject* userService;
@property(nonatomic,strong)Ty_Model_XuQiuInfo *xuqiuInfo;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)BOOL _isRefreshing;
-(void)selectUser:(int)sender;

-(UIViewController*)appointMentUsersAction:(int)sender;

-(UIViewController*)usersDetail:(int)sender home_DetailType:(enum Ty_Home_UserDetailType)_Ty_Home_UserDetailType; //查看个人详情

-(void)loadUsers;
@end
