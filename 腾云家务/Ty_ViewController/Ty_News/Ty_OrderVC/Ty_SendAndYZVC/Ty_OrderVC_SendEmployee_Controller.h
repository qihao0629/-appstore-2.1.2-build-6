//
//  Ty_OrderVC_SendEmployee_Controller.h
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_News_Busine_Network.h"
//#import "RefreshView.h"//上啦刷新

@interface Ty_OrderVC_SendEmployee_Controller : TYBaseView<UITableViewDataSource,
UITableViewDelegate>
{
    Ty_News_Busine_Network * sendEmployeeBusine;
    UIButton * sureSendButton;
    UILabel * sureSendButtonLabel;
//    RefreshView *_refreshLoadView;//上拉刷新

    UIWebView * phoneCallWebView;//拨打电话的view
    int selectTag;//确定哪个
    Ty_Model_ServiceObject * companyNewServiceObject;
    BOOL ifNewObject;//是否是新创建的
}
@property (nonatomic,assign) BOOL ifHaveWishPerson;
@property (nonatomic,strong) Ty_Model_ServiceObject * masterWisePersonObject;
@property (nonatomic,strong) UITableView * sendEmployeeTableView;
@property (nonatomic,retain) NSString * requirementString;
@property (nonatomic,assign)BOOL _isRefreshing;
@property (nonatomic,retain) NSString * _workGuid;
@property (nonatomic,retain) NSString * _workName;


@end
