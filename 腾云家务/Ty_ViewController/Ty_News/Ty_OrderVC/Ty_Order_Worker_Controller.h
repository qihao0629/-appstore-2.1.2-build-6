//
//  Ty_Order_Worker_Controller.h
//  腾云家务
//
//  Created by lgs on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_News_Busine_Network.h"
#import "Ty_Order_MySetting_WorkerCell.h"//抢单预约通知中，雇工的
#import "SRRefreshView.h"//下拉刷新
#import "RefreshView.h"//上啦刷新

@interface Ty_Order_Worker_Controller : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
SRRefreshDelegate>
{
    SRRefreshView * _refreshView;//下拉刷新的view
    RefreshView *_refreshLoadView;//上拉刷新
    UIWebView* phoneCallWebView;
    
    int but_select;//按钮点击的tag
    
    int lastIdentity ;//上次点击时候的身份 0中介  2 个人
    NSString * lastUserGuid;//上次的guid
    
    UIButton * waitServiceButton;//待服务按钮
    UIButton * canYZButton;//可以应征的按钮
    UIButton * servieceRecordButton;//服务记录按钮
    
    BOOL waitServiceBool;//yes代表正在网络请求
    BOOL canYZBool;
    BOOL serviceRecordBool;
    
    UIImageView * waitServiceRedIcon;
    UIImageView * canYZRedIcon;
    UIImageView * servieceRecordRedIcon;
}
@property (nonatomic,retain) UITableView * tableview;
@property (nonatomic,strong) Ty_News_Busine_Network * netWorkBusine;
@property(nonatomic,assign)BOOL _isRefreshing;

/***
 _index 0代表待服务 1代表待应征 2代表服务记录
 
 **/
-(void)showTopTipNotificationWithIndex:(NSNotification *)_notification;
/**
 同上
 **/
-(void)removeTopTipWithIndex:(int)_index;

@end
