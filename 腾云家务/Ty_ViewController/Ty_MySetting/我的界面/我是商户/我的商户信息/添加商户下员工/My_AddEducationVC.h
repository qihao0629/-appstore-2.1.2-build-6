//
//  My_AddEducationVC.h
//  腾云家务
//
//  Created by AF on 14-8-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//添加员工学历
#import "TYBaseView.h"
#import "My_AddEmployeeModel.h"
@interface My_AddEducationVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * _tableView;

}
@property (nonatomic,strong)     My_AddEmployeeModel * my_AddemployeeModel;

@end
