//
//  My_EmployerTableView.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_MySettingVC.h"
#import "Ty_MyAttentionWork.h"
#import "Ty_MyFansView.h"
@interface My_EmployerTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)Ty_MySettingVC * ty_mySetting;

@end
