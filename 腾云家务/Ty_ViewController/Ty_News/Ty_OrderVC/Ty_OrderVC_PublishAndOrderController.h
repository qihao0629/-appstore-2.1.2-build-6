//
//  Ty_OrderVC_PublishAndOrderController.h
//  腾云家务
//
//  Created by lgs on 14-6-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_News_Busine_Network.h"
#import "Ty_OrderVC_Master_Notivation_CustonCell.h"//抢单预约通知中，雇主的
#import "Ty_OrderVC_Worker_Notificaton_CustomCell.h"//抢单预约通知中，雇工的
#import "SRRefreshView.h"//下拉刷新
#import "RefreshView.h"//上啦刷新

@interface Ty_OrderVC_PublishAndOrderController : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
SRRefreshDelegate,
MasterLeftButton,
masterRightButton,
WorkerLeftButton,
WorkerRightButton>
{
    UIAlertView * contactWorkerAlertView;//联系商户
    UIAlertView * quitOrderAlertView;//取消预约
    UIAlertView * quitPublishAlertView;//取消需求
    UIAlertView * contactMasterAlertView;//联系雇主
    UIAlertView * workerRightAlertView;//应征，接单，取消应征
    
    SRRefreshView * _refreshView;//下拉刷新的view
    RefreshView *_refreshLoadView;//上拉刷新
    UIWebView* phoneCallWebView;
    int but_select;
}
@property (nonatomic,retain) UITableView * tableview;
@property (nonatomic,strong) Ty_News_Busine_Network * netWorkBusine;
@property(nonatomic,assign)BOOL _isRefreshing;
@end
