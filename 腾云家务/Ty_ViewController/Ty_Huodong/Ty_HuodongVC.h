//
//  Ty_HuodongVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Huodong_Busine.h"
#import "Ty_HuodongTableViewCell.h"
#import "Ty_HuodongMoreVC.h"

@interface Ty_HuodongVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    Ty_Huodong_Busine *huodong_Busine;
    
    NSMutableArray *arrHuodong;
}

@property(nonatomic,strong)UITableView *tableview;

- (void)loginWhen;
- (void)loginWhenNotLogin;

@end
