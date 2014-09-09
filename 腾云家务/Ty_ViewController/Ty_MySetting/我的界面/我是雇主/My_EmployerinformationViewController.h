//
//  My_EmployerinformationViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//雇主信息
#import "TYBaseView.h"

@interface My_EmployerinformationViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView * _tableView;
    UIImageView * imageHView;
    
    NSString * savePath;
}
@end
