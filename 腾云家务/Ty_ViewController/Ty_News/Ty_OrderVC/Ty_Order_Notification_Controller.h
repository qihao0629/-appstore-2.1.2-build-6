//
//  Ty_Order_Notification_Controller.h
//  腾云家务
//
//  Created by lgs on 14-6-25.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_News_Busine_Network.h"
#import "Ty_Order_MySetting_MasterCell.h"//抢单预约通知中，雇主的
#import "Ty_Order_MySetting_WorkerCell.h"//抢单预约通知中，雇工的
#import "SRRefreshView.h"//下拉刷新
#import "RefreshView.h"//上啦刷新

@interface Ty_Order_Notification_Controller : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
SRRefreshDelegate>
{
    SRRefreshView * _refreshView;//下拉刷新的view
    RefreshView *_refreshLoadView;//上拉刷新
    UIWebView* phoneCallWebView;
    int but_select;//按钮点击的tag
    int lastIdentity ;//上次点击时候的身份 0中介  2 个人
    
    UIButton * waitServiceButton;//待服务按钮
    UIButton * canYZButton;//可以应征的按钮
    UIButton * servieceRecordButton;//服务记录按钮
    
    BOOL waitServiceBool;//yes代表正在网络请求
    BOOL canYZBool;
    BOOL serviceRecordBool;
}
@property (nonatomic,retain) UITableView * masterTableview;//雇主的tableview
@property (nonatomic,retain) UITableView * workerTableview;//中介的tableview
@property (nonatomic,strong) Ty_News_Busine_Network * netWorkBusine;
@property(nonatomic,assign)BOOL _isRefreshing;

- (void)loginWhenNotLogin;

@end
