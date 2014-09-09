//
//  Ty_NewsVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_NewsVC.h"
#import "MessageVC.h"
#import "Ty_Model_MessageInfo.h"
#import "Ty_Order_Notification_Controller.h"
#import "Ty_UPPayVC.h"
#import "My_LoginViewController.h"
#import "Ty_Pub_RequirementsVC.h"
#import "AppDelegateViewController.h"
#import "Ty_SystemMessageVC.h"
#import "Ty_LifeTipsVC.h"

@interface Ty_NewsVC ()

@end

@implementation Ty_NewsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"消息";
        
    }
    return self;
}

#pragma mark  -----  有新消息时，刷新消息列表页面
- (void)refreshMsgTableList
{
    [_messageListBusine getAllMessageList];
    _messageListTableView.allMessageArr = _messageListBusine.allMessageArr;
    [_messageListTableView reloadData];
}

#pragma mark --- jumpToNextDelegat
#pragma mark --- 跳到下级页面
- (void)jumpToNextPageWithIndexRow:(int)indexRow
{
    if (indexRow != 1 && indexRow != 2 /*&& indexRow != 3*/)
    {
        MessageVC *messageVC = [[MessageVC alloc]init];
        Ty_Model_MessageInfo *messageInfo = [_messageListBusine.allMessageArr objectAtIndex:indexRow];
        
        messageVC.contactRealName = messageInfo.messageContactRealName;
        messageVC.contactName = messageInfo.messageContactName;
        messageVC.contactGuid = messageInfo.messageContactGuid;
        messageVC.contactJIDName = messageInfo.messageContactJIDName;
        messageVC.contactAnnear = messageInfo.messageContactAnnear;
        messageVC.contactImg = messageInfo.messageContactPhoto;
        
        [self.naviGationController pushViewController:messageVC animated:YES];
    }
    /*
    else if (indexRow == 2)
    {
        //此处为抢单和预约
        if (IFLOGINYES)
        {
            Ty_Order_Notification_Controller * notificationVC = [[Ty_Order_Notification_Controller alloc]init];
            [self.naviGationController pushViewController:notificationVC animated:YES];
        }
        else
        {
            UIAlertView * tempAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登陆", nil];
            [tempAlertView show];
        }
    }
     */
    else if (indexRow == 1)
    {
        Ty_SystemMessageVC *sysmessageVC = [[Ty_SystemMessageVC alloc]init];
        [self.naviGationController pushViewController:sysmessageVC animated:YES];
        
    }
    
    else if (indexRow == 2)
    {
        Ty_LifeTipsVC *lifeTipsVC = [[Ty_LifeTipsVC alloc]init];
        [self.naviGationController pushViewController:lifeTipsVC animated:YES];
    }
    
    
}
- (void)deleteGroup:(NSString *)contactGuid
{
    [_messageListBusine updateGroupDeleteByContactGuid:contactGuid];
    [self setIconNum];
}

#pragma mark --- 测试支付方法
- (void)testPay
{
    
    Ty_UPPayVC *payVC = [[Ty_UPPayVC alloc]init];
    [self.naviGationController pushViewController:payVC animated:YES];
    payVC = nil;
     
}

- (void)setIconNum
{
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
    {
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        [appDelegateVC setTabBarIcon:[_messageListBusine getAllUnreadMessageNum] atIndex:1];
    }
}

#pragma mark rightBarButtion Action
-(void)rightButtonAction
{
    if (IFLOGINYES) {
        Ty_Pub_RequirementsVC *ty_pub_Requirements=[[Ty_Pub_RequirementsVC alloc]init];
        ty_pub_Requirements.title = @"发抢单";
        [self.naviGationController pushViewController:ty_pub_Requirements animated:YES];
    }else{
        My_LoginViewController* loginVC=[[My_LoginViewController alloc]init];
        [self.naviGationController pushViewController:loginVC animated:YES];
    }
    
}

#pragma mark --- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _messageListTableView = [[MessageListTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 20  -44 ) style:UITableViewStylePlain];
    _messageListTableView.jumpDelegate = self;
    [self.view addSubview:_messageListTableView];
    
    
    _messageListBusine = [[Ty_MessageList_Busine alloc]init];
    
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMsgTableList) name:@"RefreshMsgList" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMsgTableList) name:@"RefreshMessageList" object:nil];
    
    
    
    //此处为测试支付按钮
   // [self.naviGationController.leftBarButton addTarget:self action:@selector(testPay) forControlEvents:UIControlEventTouchUpInside];
    [self.naviGationController.rightBarButton setTitle:@"发抢单" forState:UIControlStateNormal];
    [self.naviGationController.rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    [self.naviGationController.rightBarButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    
    
}
-(void)setrightBarButton
{
    //初始化导航右侧按钮
    if ([MyLoginUserType isEqualToString:@"2"]) {
        self.naviGationController.rightBarButton.hidden=NO;
    }else{
        self.naviGationController.rightBarButton.hidden=YES;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_messageListBusine createQDataIntoTable];
    [_messageListTableView deselectRowAtIndexPath:[_messageListTableView indexPathForSelectedRow] animated:YES];
    [_messageListBusine getAllMessageList];
    _messageListTableView.allMessageArr = _messageListBusine.allMessageArr;
    [_messageListTableView reloadData];

    
    [self setIconNum];
    [self setrightBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
