//
//  UserCityViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-11-13.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
//城市
#import "TYBaseView.h"

@interface UserCityViewController : TYBaseView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray *array_city ;
}
@property (nonatomic,strong) NSMutableArray * array_areas;
@property (nonatomic,copy) NSString * str_areas;
@end
