//
//  MyShopAddSkillViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-4-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//商户的服务项目 界面
#import <UIKit/UIKit.h>

@interface MyShopAddSkillViewController : TYBaseView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    
    NSMutableArray * array_skill;
    NSDictionary * dic_price;
    NSMutableArray * array_job;
}
@property(nonatomic,strong)NSString * userGuid;
//服务项目
-(void)loadDataGetSkill;

@end
