//
//  My_LoginNoView.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//未登录 我的界面
#import <UIKit/UIKit.h>
#import "Ty_MySettingVC.h"
@interface My_LoginNoView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}
@property (nonatomic,assign) Ty_MySettingVC * ty_mySetting;

@end
