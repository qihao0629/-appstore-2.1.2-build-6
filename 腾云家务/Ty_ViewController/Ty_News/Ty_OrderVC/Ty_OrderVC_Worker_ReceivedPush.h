//
//  Ty_OrderVC_Worker_ReceivedPush.h
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
#import "Ty_Order_DetailCell.h"

@interface Ty_OrderVC_Worker_ReceivedPush : TYBaseView<UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
SemgentButtonDelegate,
Detail_PhoneCall>
{
    UIButton * centerButton;//中间按钮，可能评价，可能派工
    UILabel * centerLabel;
    
    UIAlertView * cancleYZAlertView;//拒绝预约弹出的对话框
    
    Ty_UserView_OrderView_RequirementDetail_TopView * _requirementTopView;//上面需求详情的部分展示
    
    UIView * evaluateView;//评价view的展示
    int  noReadMessageNum;//和雇主有多少条未读的消息
    
    int semgentButtonTag;//上面那个三个按钮，现在正点击哪一个
    UIWebView * phoneCallWebView;//拨打电话的view
    
    Ty_Model_ServiceObject * myYZDataServiceObject;//我应征时候的信息
    
    UIButton * privateButton;//底部的私信按钮
    
    BOOL ifDataLoad;//是否网络加载回来
    BOOL myYZDataLoad;//是否我应征的信息加载回来
}
@property (nonatomic,retain) Ty_Model_XuQiuInfo * xuQiuInfo;//需求的一个对象
@property (nonatomic,retain) UITableView * workerReceivedPush_TableView;
@property (nonatomic,retain) NSString * requirementGuid;//需求的guid
@property (nonatomic,strong) Ty_News_Busine_Network * worker_ReceivedPush_Network_Busine;

@end
