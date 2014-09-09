//
//  My_AddManangeInformationViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/10.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//添加员工完善信息界面
#import "TYBaseView.h"
#import "My_AddEmployeeModel.h"
@interface My_AddManangeInformationViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UIView * viewEmployee;
    
    UITableView * _tableView;
    NSMutableArray * array_skill;
}
@property (nonatomic ,strong)My_AddEmployeeModel * my_AddemployeeModel;


@end
