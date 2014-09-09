//
//  Ty_Order_Master_Controller.h
//  腾云家务
//
//  Created by lgs on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_News_Busine_Network.h"
#import "Ty_Order_MySetting_MasterCell.h"//抢单预约通知中，雇主的
#import "SRRefreshView.h"//下拉刷新
#import "RefreshView.h"//上啦刷新

@interface Ty_Order_Master_Controller : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
SRRefreshDelegate>
{
    SRRefreshView * _refreshView;//下拉刷新的view
    RefreshView *_refreshLoadView;//上拉刷新
    UIWebView* phoneCallWebView;

    int lastIdentity ;//上次点击时候的身份 0中介  2 个人
    NSString * lastUserGuid;//上次的guid
    
    UIImageView * remindImageView;
    UILabel * remindLabel;
}
@property (nonatomic,retain) UITableView * tableview;
@property (nonatomic,strong) Ty_News_Busine_Network * netWorkBusine;
@property(nonatomic,assign)BOOL _isRefreshing;

@end
