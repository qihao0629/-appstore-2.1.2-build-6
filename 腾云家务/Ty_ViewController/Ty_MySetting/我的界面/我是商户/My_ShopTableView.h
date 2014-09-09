//
//  My_ShopTableView.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_MySettingVC.h"
#import "My_SettingUpadteModel.h"

@interface My_ShopTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)Ty_MySettingVC * ty_mySetting;
@property (nonatomic,strong)    My_SettingUpadteModel * my_setUpadteModel;

@end
