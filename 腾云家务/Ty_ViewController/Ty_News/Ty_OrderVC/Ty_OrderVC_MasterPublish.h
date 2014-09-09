//
//  Ty_OrderVC_MasterPublish.h
//  腾云家务
//
//  Created by lgs on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_UserView_Order_SemgentButton.h"
#import "Ty_UserView_OrderView_RequirementDetail_TopView.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_News_Busine_Network.h"
#import "MasterLookYZPeopleCell.h"
#import "RefreshView.h"//上啦刷新

@interface Ty_OrderVC_MasterPublish : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
SemgentButtonDelegate,
MasterDeterminePersonButton>
{
    UIButton * centerButton;//取消需求的button；
    UILabel * centerButtonLabel;//取消需求按钮上的Lebel;
    NSDictionary * evaluateDictionary;//评价的字典
    
    UIAlertView * quitPublishAlertView;//取消需求弹出的对话框
    UIAlertView * surePersonAlertView;//确定人选的对话框
    
    Ty_UserView_OrderView_RequirementDetail_TopView * _requirementTopView;//上面需求详情的部分展示
    
    UIView * evaluateView;//评价view的展示
    int  noReadMessageNum;//针对某个人，有多少条未读的消息
    
    int semgentButtonTag;//上面那个三个按钮，现在正点击哪一个
    UIWebView * phoneCallWebView;//拨打电话的view
    
    Ty_Model_ServiceObject * hirePersonObject;//确定预约的对象
    UIButton * privateButton;//底部的私信按钮
    
    BOOL ifDataLoad;
    RefreshView *_refreshLoadView;//上拉刷新
    int surePersonTag;//确定那个人的tag;
}
@property (nonatomic,retain) Ty_Model_XuQiuInfo * xuQiuInfo;//需求的一个对象
@property (nonatomic,retain) UITableView * masterPublish_TableView;
@property (nonatomic,retain) NSString * requirementGuid;//需求的guid
@property (nonatomic,strong) Ty_News_Busine_Network * master_Order_Network_Busine;
//@property (nonatomic,assign) int payStage;//支付状态
@property (nonatomic,assign)BOOL _isRefreshing;

@end
