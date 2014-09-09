//
//  My_LoginYesView.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//已经登录后 我的界面
#import <UIKit/UIKit.h>
#import "My_EmployerTableView.h"
#import "Ty_MySettingVC.h"
#import "My_ShopTableView.h"

@interface My_LoginYesView : UIView{
    
    NSString *strButtonName;
    
    NSString * butImageClickName;
    
    UIButton * button_employer;

    
    UIImageView * imageViewcon;
    UIView * viewBack;
    
    
    UILabel * labelName;
    UILabel *labelAnnear;
    UIImageView * imageViewHead ;
    
    My_EmployerTableView * my_employer;
    My_ShopTableView * my_shop;
    
    UIView * viewHead;
    
}

@property (nonatomic,strong)Ty_MySettingVC * ty_mySetting;
@property (nonatomic,strong)    My_EmployerTableView * my_employer;
@property (nonatomic,strong)        My_ShopTableView * my_shop;


-(void)updateLogin;/**登录后更新界面信息*/

@end
