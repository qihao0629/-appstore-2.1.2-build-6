//
//  Ty_OrderVC_MySetting_Worker.h
//  腾云家务
//
//  Created by lgs on 14-6-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_News_Busine_Network.h"
#import "SRRefreshView.h"//下拉刷新
#import "RefreshView.h"//上啦刷新

@interface Ty_OrderVC_MySetting_Worker : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
SRRefreshDelegate>
{
    SRRefreshView * _refreshView;//下拉刷新的view
    RefreshView *_refreshLoadView;//上拉刷新
}
@property (nonatomic,retain) UITableView * tableview;
@property (nonatomic,retain) Ty_News_Busine_Network * netWorkBusine;
@property (nonatomic,assign) BOOL _isRefreshing;
@property (nonatomic,assign) int buttonNumber;

@end
