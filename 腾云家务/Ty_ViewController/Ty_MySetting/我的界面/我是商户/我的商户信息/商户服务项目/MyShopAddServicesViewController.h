//
//  MyShopAddServicesViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-4-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//添加服务项目界面
#import <UIKit/UIKit.h>
#import "Ty_Model_WorkListInfo.h"
#import "MyShopAddSkillViewController.h"
@interface MyShopAddServicesViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView * _tableView;
    NSDictionary * dic_price;
}

@property(nonatomic,strong)NSString * workName;//服务项目名称
@property(nonatomic,strong)NSDictionary * dic_content;

@property(nonatomic,strong)    UITableView * _tableView;

@property (nonatomic,strong) Ty_Model_WorkListInfo * WorklistModel;
@property (nonatomic,assign) MyShopAddSkillViewController * myShopAddSkill;

@end
