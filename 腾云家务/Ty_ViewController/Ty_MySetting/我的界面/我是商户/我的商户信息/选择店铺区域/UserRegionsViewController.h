//
//  UserRegionsViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-1-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//区域
#import "TYBaseView.h"

@interface UserRegionsViewController :TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@property(nonatomic,strong)NSMutableArray * array_city;
@property (nonatomic,copy) NSString * str_city;

@end
