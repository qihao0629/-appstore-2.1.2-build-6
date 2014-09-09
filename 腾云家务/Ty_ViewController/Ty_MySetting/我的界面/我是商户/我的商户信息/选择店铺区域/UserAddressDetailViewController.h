//
//  UserAddressDetailViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-11-13.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
//地区
#import "TYBaseView.h"
@interface UserAddressDetailViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;

}

@property (nonatomic,strong)NSMutableArray * array_area;
@property (nonatomic,copy) NSString * str_area;

@end
