//
//  My_AddEmployeeViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//添加员工界面
#import "TYBaseView.h"
#import "My_AddEmployeeModel.h"
@interface My_AddEmployeeViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    My_AddEmployeeModel * my_AddemployeeModel;
}
@end
