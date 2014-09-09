//
//  MyShopAddJobViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-4-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//选择服务项目
#import <UIKit/UIKit.h>
#import "MyShopAddServicesViewController.h"
#import "MyShopAddSkillViewController.h"
@interface MyShopAddJobViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * array_serve;
}
@property(nonatomic,assign) MyShopAddServicesViewController * myShopService;
@property (nonatomic,assign) MyShopAddSkillViewController * myShopAddSkill;
@end
