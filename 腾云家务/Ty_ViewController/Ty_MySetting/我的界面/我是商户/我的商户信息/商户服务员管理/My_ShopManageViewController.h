//
//  My_ShopManageViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//签约员工管理
#import "TYBaseView.h"
#import "RefreshView.h"
@interface My_ShopManageViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * array_singend;
    
    BOOL isSingend;
    BOOL _isRefreshing;
    RefreshView *_refreshView;
    NSInteger reqint;
}
/**第一次网络请求*/
-(void)My_ShopManageReq;

@end
