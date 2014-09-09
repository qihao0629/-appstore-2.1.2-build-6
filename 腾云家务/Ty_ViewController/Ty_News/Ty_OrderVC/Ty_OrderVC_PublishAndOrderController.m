//
//  Ty_OrderVC_PublishAndOrderController.m
//  腾云家务
//
//  Created by lgs on 14-6-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_PublishAndOrderController.h"
#import "Ty_OrderVC_MasterOrder.h"
#import "Ty_OrderVC_MasterPublish.h"
#import "Ty_OrderVC_Worker_ReceivedPush.h"
#import "Ty_OrderVC_Worker_ReceivedOrder.h"
#import "Ty_Model_XuQiuInfo.h"
#import "MessageVC.h"

static BOOL freshNewNotificationBool;//是否处于刷新状态
int currentPressedWhichCell;//当前点击的是哪一个cell

@interface Ty_OrderVC_PublishAndOrderController ()

@end

@implementation Ty_OrderVC_PublishAndOrderController
@synthesize tableview;
@synthesize netWorkBusine;
@synthesize _isRefreshing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addNotificationForName:@"Ty_OrderVC_PublishAndOrderController"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    freshNewNotificationBool = NO;
    currentPressedWhichCell = 0;
    but_select = -1;
    
    self.title = @"抢单和预约通知";
    
    [self.view bringSubviewToFront:self.naviGationController];
    self.imageView_background.hidden = YES;
    [self loadBackButton];
    
//    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, MainFrame.size.height-44)];
    
    [self.view setBackgroundColor:view_BackGroudColor];
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    [self.tableview setBackgroundColor:view_BackGroudColor];
    
    tableview.showsVerticalScrollIndicator = NO;//不显示滚动条
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线

    tableview.dataSource = self;
    tableview.delegate = self;
    
    [self.view addSubview:tableview];
    
    //实例化网络业务层
    netWorkBusine = [[Ty_News_Busine_Network alloc]init];
    netWorkBusine.delegate = self;
    
    [netWorkBusine freshData];
    [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];//调用网络请求
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotificationTableViewDataSourse:) name:@"refreshDateSource" object:nil];
    
    [self showLoadingInView:self.view];
    
    [self refreshViewInit];//定义下拉刷新
    
    //定义上拉刷新
    if (_refreshLoadView == nil)
    {
        _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        _refreshLoadView._messageLabel.text = @"正在加载...";
    }
    
    //定义弹出的对话框
    [self loadAlertView];
//    [self loadTableViewFootView];
}
-(void)loadBackButton
{
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setBackgroundImage:[UIImage imageNamed:@"Message_back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(popToLastController) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
}
-(void)popToLastController
{
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark 实例化alertView
-(void)loadAlertView
{
    quitOrderAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要取消预约么,一旦取消将无法达成交易" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    quitPublishAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要取消自己发布的需求么，一旦取消将无法和应征的服务商达成交易" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    contactMasterAlertView = [[UIAlertView alloc]initWithTitle:@"请选择" message:@"请您选择联系方式" delegate:self cancelButtonTitle:@"电话联系雇主" otherButtonTitles:@"私信联系她",@"再考虑一下", nil];
    contactWorkerAlertView = [[UIAlertView alloc]initWithTitle:@"请选择" message:@"请您选择联系方式" delegate:self cancelButtonTitle:@"电话联系雇工" otherButtonTitles:@"私信联系她",@"再考虑一下", nil];
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{



}
#pragma mark -----tableView的数据源代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [netWorkBusine.xuQiuInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
    
    if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.row] userTypeBaseOnRequirement] isEqualToString:@"0"])
    {
        Ty_OrderVC_Master_Notivation_CustonCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[Ty_OrderVC_Master_Notivation_CustonCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
            cell.xuQiu = [netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section];
            cell.masterLeftDelegate = self;
            cell.masterRightDelegate = self;
            [cell loadUIAndIndex:indexPath.section];
            [cell loadValues];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    else
    {
        Ty_OrderVC_Worker_Notificaton_CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[Ty_OrderVC_Worker_Notificaton_CustomCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
            cell.xuQiu = [netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section];
            cell.workerLeftButtonDelegate = self;
            cell.workerRightButtonDelegate = self;
            [cell loadUIAndIndex:indexPath.section];
            [cell loadValues];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    
}

#pragma mark ----tableView的delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 17;
    }
    else
        return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section != [netWorkBusine.xuQiuInfoArray count] -1)
    {
        return 8;
    }
    else
        return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 17)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        return headerView;
    }
    else
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 7)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        return headerView;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != [netWorkBusine.xuQiuInfoArray count] -1)
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 8)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        return headerView;
    }
    else
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 28)];
        [headerView setBackgroundColor:[UIColor clearColor]];
        return headerView;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //确定cell的身份，到底进入那个controller
    Ty_Model_XuQiuInfo * tempXuQiu =[[Ty_Model_XuQiuInfo alloc]init];
    tempXuQiu =[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section];
    
    if ([[tempXuQiu userTypeBaseOnRequirement] isEqualToString:@"0"] == YES)
    {//雇主
        if ([[tempXuQiu requirement_Type] isEqualToString:@"0"] == YES)
        {//直接发布
            Ty_OrderVC_MasterPublish * masterPublishVC = [[Ty_OrderVC_MasterPublish alloc]init];
            masterPublishVC.requirementGuid = tempXuQiu.requirementGuid;
            [self.naviGationController pushViewController:masterPublishVC animated:YES];
        }
        else
        {
            Ty_OrderVC_MasterOrder * masterOrderVC = [[Ty_OrderVC_MasterOrder alloc]init];
            masterOrderVC.requirementGuid = tempXuQiu.requirementGuid;
            [self.naviGationController pushViewController:masterOrderVC animated:YES];
        }
    }
    else
    {//雇工
        if ([[tempXuQiu requirement_Type] isEqualToString:@"0"] == YES)
        {//推送给我的
            
        }
        else
        {//直接预约我的
            
        }
    }
}
#pragma mark -----雇主自定义cell中的按钮代理  左右
-(void)masterLeftButtonAction:(id)sender
{
    int tag = ((UIButton*)sender).tag - 1000;
    currentPressedWhichCell = tag;
    if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:tag] userTypeBaseOnRequirement] isEqualToString:@"0"] == YES)
    {//我是雇主
        [contactWorkerAlertView show];
    }
    else
        [contactMasterAlertView show];
}
-(void)masterRightButtonAction:(id)sender
{
    int tag = ((UIButton*)sender).tag - 2000;
    currentPressedWhichCell = tag;
    if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:tag] requirement_Type] isEqualToString:@"0"] == YES)
    {//这是直接发布的需求
        [quitPublishAlertView show];
    }
    else
        [quitOrderAlertView show];
}

#pragma mark ----alertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == contactMasterAlertView)
    {
        NSString * phoneString = [NSString stringWithFormat:@"tel:%@",[[netWorkBusine.xuQiuInfoArray objectAtIndex:currentPressedWhichCell] publishUserPhone]];
        NSURL *phoneURL = [NSURL URLWithString:phoneString];
        switch (buttonIndex)
        {
            case 0:
                if (!phoneCallWebView )
                {
                    phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
                }
                [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
                break;
            case 1:
                break;
            default:
                break;
        }
    }
    else if (alertView == contactWorkerAlertView)
    {
        NSString * phoneString;
        NSURL *phoneURL;
        if ([[[[netWorkBusine.xuQiuInfoArray objectAtIndex:currentPressedWhichCell] serverObject] userType] isEqualToString:@"1"])
        {//中介下的短工
            phoneString = [NSString stringWithFormat:@"tel:%@",[[[netWorkBusine.xuQiuInfoArray objectAtIndex:currentPressedWhichCell] serverObject] companyPhoneNumber]];
            phoneURL = [NSURL URLWithString:phoneString];
        }
        else
        {
            phoneString = [NSString stringWithFormat:@"tel:%@",[[[netWorkBusine.xuQiuInfoArray objectAtIndex:currentPressedWhichCell] serverObject] phoneNumber]];
            phoneURL = [NSURL URLWithString:phoneString];
        }
        switch (buttonIndex)
        {
            case 0:
                if (!phoneCallWebView )
                {
                    phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
                }
                [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
                break;
            case 1:
                break;
            default:
                break;
        }
    }
    else if (alertView == quitPublishAlertView || alertView == quitOrderAlertView)
    {
        [netWorkBusine notificationCloseRequiremengAndRequirementGuid:[[netWorkBusine.xuQiuInfoArray objectAtIndex:currentPressedWhichCell] requirementGuid]];
        [self showProgressHUD:@"正在取消"];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeRequirementRefreshNotificationDataSourse:) name:@"closeRefreshDateSource" object:nil];
    }
//    else if (alertView == quitOrderAlertView)
//    {
//        
//    }
}

#pragma mark ---- 实例化下拉刷新
- (void) refreshViewInit
{
    _refreshView = [[SRRefreshView alloc] init];
    _refreshView.delegate = self;
    _refreshView.upInset = 0;
    _refreshView.slimeMissWhenGoingBack = YES;
    _refreshView.slime.bodyColor = [UIColor grayColor];
    _refreshView.slime.skinColor = [UIColor whiteColor];
    _refreshView.slime.lineWith = 1;
    _refreshView.slime.shadowBlur = 4;
    _refreshView.slime.shadowColor = [UIColor grayColor];
    
    [tableview addSubview:_refreshView];
}
#pragma mark - scrollView delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshView scrollViewDidEndDraging];
}
#pragma mark ---- 下拉刷新的代理
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    if (refreshView == _refreshView && freshNewNotificationBool == NO)
    {
        freshNewNotificationBool = YES;
        //请求新的数据
        [netWorkBusine freshPage];
        [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];//调用网络请求
    }
}

#pragma mark ----上拉刷新的方法
#pragma mark 上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",_isRefreshing);
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView != nil)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!_isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            _isRefreshing = YES;
            
            [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];//调用网络请求
        }
    }
}
-(void)loadTableViewFootView
{
    if (tableview.contentSize.height>=tableview.bounds.size.height)
    {
        self.tableview.tableFooterView = _refreshLoadView;
    }
    else
        self.tableview.tableFooterView = nil;
}
/*
#pragma mark 网络请求回来之后，刷新数据源
-(void)refreshNotificationTableViewDataSourse:(NSNotification *)_notification
{
    [self hideLoadingView];
    freshNewNotificationBool = NO;
    [_refreshView performSelector:@selector(endRefresh)
                       withObject:nil afterDelay:0.1
                          inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];

    if ([[_notification object] isEqualToString:@"1"])
    {
        _isRefreshing = NO;
        [self.tableview reloadData];
    }
    else if([[_notification object] isEqualToString:@"2"])
    {
        _isRefreshing = NO;
        _refreshLoadView._messageLabel.text = @"已加载全部";
    }
    else
    {
        _isRefreshing = NO;
        _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
        if ([netWorkBusine.xuQiuInfoArray count] == 0)
        {
            [self showNetMessageInView:self.view];
        }
    }
    [self loadTableViewFootView];
}
 */
/*
#pragma mark 关闭需求，网络请求回来
-(void)closeRequirementRefreshNotificationDataSourse:(NSNotification *)_notification
{
    [self hideProgressHUD];
    if ([[_notification object] isEqualToString:@"1"])
    {
        freshNewNotificationBool = YES;
        //请求新的数据
        [netWorkBusine freshPage];
        [netWorkBusine publishAndOrderNotification];
    }
    else
    {
        [self showMessageInView:self.view message:@"关闭失败"];
    }
}
*/
#pragma mark 网络层通知
-(void)netRequestReceived:(NSNotification *)_notification
{
    int objectNumber = [[[_notification object] objectForKey:@"number"] intValue];
    if (objectNumber <=2)
    {
        [self hideLoadingView];
        freshNewNotificationBool = NO;
        [_refreshView performSelector:@selector(endRefresh)
                           withObject:nil afterDelay:0.1
                              inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
        
        if (objectNumber == 0)
        {
            _isRefreshing = NO;
            [self.tableview reloadData];
        }
        else if(objectNumber == 1)
        {
            _isRefreshing = NO;
            _refreshLoadView._messageLabel.text = @"已加载全部";
        }
        else
        {
            _isRefreshing = NO;
            _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
            if ([netWorkBusine.xuQiuInfoArray count] == 0)
            {
                [self showNetMessageInView:self.view];
            }
        }
        [self loadTableViewFootView];
    }
    else
    {
        [self hideProgressHUD];
        if (objectNumber == 3)
        {
            freshNewNotificationBool = YES;
            //请求新的数据
            [netWorkBusine freshPage];
            [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];//调用网络请求
        }
        else
        {
            [self showMessageInView:self.view message:@"关闭失败"];
        }

    }
}

#pragma mark 重新加载的回执
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];//调用网络请求
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
