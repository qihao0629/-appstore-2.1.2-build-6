//
//  Ty_OrderVC_MySetting_Worker.m
//  腾云家务
//
//  Created by lgs on 14-6-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_MySetting_Worker.h"
#import "Ty_OrderVC_Worker_ReceivedOrder.h"
#import "Ty_OrderVC_Worker_ReceivedPush.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_Order_MySetting_WorkerCell.h"//我“已发抢单”“已发预约”“所有的订单”
#import "Ty_News_busine_Order_DataBase.h"

static BOOL freshNewNotificationBool;//是否处于刷新状态
static BOOL downPullBool;//是否是下拉刷新，因为出现了203，但是还有以前的旧数据

@interface Ty_OrderVC_MySetting_Worker ()

@end

@implementation Ty_OrderVC_MySetting_Worker
@synthesize tableview;
@synthesize _isRefreshing;
@synthesize netWorkBusine;
@synthesize buttonNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_MySetting_Worker"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    freshNewNotificationBool = NO;
    downPullBool = NO;
    
    switch (buttonNumber)
    {
        case 0:
            self.title = @"收到抢单";
            break;
        case 1:
            self.title = @"收到预约";
            break;
        case 4:
        case 5:
            self.title = @"所有的需求和预约订单";
            break;
        default:
            break;
    }
    
    [self.view bringSubviewToFront:self.naviGationController];
    
    //    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, MainFrame.size.height-44)];
    
    [self.view setBackgroundColor:view_BackGroudColor];
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
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
    if (buttonNumber == 0 || buttonNumber == 1)
    {
        [netWorkBusine searchMyAllKindsOfRequirementWithType:buttonNumber andUserType:0];//调用网络请求
    }
    else
    {
        [netWorkBusine searchAllRequirementWithType:buttonNumber];//调用雇主查看所有的需求和预约订单接口
    }
    freshNewNotificationBool = YES;
    downPullBool = YES;
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMySettingMaterTableDataSourse:) name:@"refreshMySettingMasterDataSouse" object:nil];
    
    [self showLoadingInView:self.view];
    
    [self initRefreshView];//定义下拉刷新
    
    //定义上拉刷新
    if (_refreshLoadView == nil)
    {
        _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        _refreshLoadView._messageLabel.text = @"正在加载...";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
}
#pragma mark 基类中返回
-(void)backClick
{
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark 定义下拉刷新
-(void)initRefreshView
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
#pragma mark -----tableview 数据源代理
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
    
    Ty_Order_MySetting_WorkerCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[Ty_Order_MySetting_WorkerCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        
//        NSLog(@"%@,%@",[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type],[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName]);
    }
    if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type] intValue] == 0)
    {//抢单
        cell.workerSmallImageLabel.text = @"抢单";
        [cell.workerSmallImageView setImage:JWImageName(@"greenBackGround")];
        
        cell.workNameLabel.text = [[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName];
    }
    else
    {
        cell.workerSmallImageLabel.text = @"预约";
        [cell.workerSmallImageView setImage:JWImageName(@"yellowBackGround")];
        
        cell.workNameLabel.text = [[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName];
    }
    
    if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] publishUserType] intValue] == 0)
    {
        [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
    }
    else
    {
        if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] publishUserSex] intValue] == 0)
        {
            [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
        }
        else
        {
            [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
        }
    }
    [cell setHight];
    int stage =[[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Stage] intValue];
    
    switch (stage)
    {
        case 0:
            cell.orderStageString = @"待应征";
            break;
        case 6:
            if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] candidateStatus] intValue] == 0)
            {
                cell.orderStageString = @"待应征";
            }
            else
            {
                cell.orderStageString = @"我已应征";
            }
            break;
        case 1:
            cell.orderStageString = @"待确认";
            break;
        case 2:
            if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText] isEqualToString:@""])
            {
                cell.orderStageString  = @"交易中";
            }
            else
            {
                cell.orderStageString  = [[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText];
            }
            break;
        case 3:
            cell.orderStageString= @"已完成";
            break;//交易完成
        case 7:
            cell.orderStageString = @"待派工";
            break;
        default:
            cell.orderStageString= @"交易关闭";
            break;

    }
    cell.orderStageLabel.text = [NSString stringWithFormat:@"[%@]",cell.orderStageString];
    
    NSMutableString * servieceAreaStr = [[NSMutableString alloc]initWithString:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] area]];
    servieceAreaStr = [NSMutableString stringWithString:[servieceAreaStr stringByAppendingString:[NSString stringWithFormat:@"  %@",[[NSMutableString alloc]initWithString:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] region]]]]];
    cell.servieceAreaLabel.text = [NSString stringWithFormat:@"服务区域:  %@",servieceAreaStr];
    
    
    NSString * servieceTimeStr =[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] startTime];
    cell.servieceTimeLabel.text = [NSString stringWithFormat:@"服务时间:  %@",servieceTimeStr];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark ----tableView的delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 101;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //确定cell的身份，到底进入那个controller
    Ty_Model_XuQiuInfo * tempXuQiu =[[Ty_Model_XuQiuInfo alloc]init];
    tempXuQiu =[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section];
    [Ty_News_busine_Order_DataBase share_Busine_DataBase].dataBaseXuQiu = tempXuQiu;

    if ([[tempXuQiu userTypeBaseOnRequirement] isEqualToString:@"1"] == YES)
    {//雇主
        if ([[tempXuQiu requirement_Type] isEqualToString:@"0"] == YES)
        {//直接发布
            Ty_OrderVC_Worker_ReceivedPush * workerReceivedPushVC = [[Ty_OrderVC_Worker_ReceivedPush alloc]init];
            workerReceivedPushVC.requirementGuid = tempXuQiu.requirementGuid;
            workerReceivedPushVC.xuQiuInfo = tempXuQiu;
            
            [self.naviGationController pushViewController:workerReceivedPushVC animated:YES];
        }
        else
        {
            Ty_OrderVC_Worker_ReceivedOrder * workerReceivedOrderVC = [[Ty_OrderVC_Worker_ReceivedOrder alloc]init];
            workerReceivedOrderVC.requirementGuid = tempXuQiu.requirementGuid;
            workerReceivedOrderVC.xuQiuInfo = tempXuQiu;
            
            [self.naviGationController pushViewController:workerReceivedOrderVC animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 15;
    }
    else
        return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * tempView = [[UIView alloc]init];
    if (section == 0)
    {
        [tempView setFrame:CGRectMake(0, 0, 320, 15)];
    }
    else
    {
        [tempView setFrame:CGRectMake(0, 0, 320, 6)];
    }
    [tempView setBackgroundColor:[UIColor clearColor]];
    return tempView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 7)];
    [tempView setBackgroundColor:[UIColor clearColor]];
    return tempView;
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
        if (buttonNumber == 5)
        {//雇主的所有的进来的
            [netWorkBusine searchAllRequirementWithType:buttonNumber];
        }
        else
        {
            [netWorkBusine searchMyAllKindsOfRequirementWithType:buttonNumber andUserType:0];
        }
        freshNewNotificationBool = YES;
        downPullBool = YES;
    }
}

#pragma mark ----上拉刷新的方法
#pragma mark 上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",_isRefreshing);
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView != nil&& tableview.contentOffset.y > 0 && freshNewNotificationBool == NO)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!_isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            _isRefreshing = YES;
            
            if (buttonNumber == 5)
            {//雇主的所有的进来的
                [netWorkBusine searchAllRequirementWithType:buttonNumber];
            }
            else
            {
                [netWorkBusine searchMyAllKindsOfRequirementWithType:buttonNumber andUserType:0];
            }
            freshNewNotificationBool = YES;
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
 -(void)refreshMySettingMaterTableDataSourse:(NSNotification *)_notification
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
#pragma mark 重新加载的回执
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    if (buttonNumber == 0 || buttonNumber == 1)
    {
        [netWorkBusine searchMyAllKindsOfRequirementWithType:buttonNumber andUserType:0];//调用网络请求
    }
    else
    {
        [netWorkBusine searchAllRequirementWithType:buttonNumber];//调用雇主查看所有的需求和预约订单接口
    }
    freshNewNotificationBool = YES;
    downPullBool = YES;
}

#pragma mark 基类网络回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];

    freshNewNotificationBool = NO;
    _isRefreshing = NO;
    [_refreshLoadView._netMind stopAnimating];
    
    [_refreshView performSelector:@selector(endRefresh)
                       withObject:nil afterDelay:0.1
                          inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];

    int number = [[[_notification object] objectForKey:@"number"] intValue];
    if (number <=2)
    {
        if (number == 0)
        {
            [self.tableview reloadData];
        }
        else if(number == 1)
        {
            if (downPullBool)
            {
                [self showMessageInView:self.view message:@"无查询信息"];
            }
            else
            {
                if ([netWorkBusine.xuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.view message:@"无查询信息"];
                } 
            }
            _refreshLoadView._messageLabel.text = @"已加载全部";
        }
        else
        {
            _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
            if ([netWorkBusine.xuQiuInfoArray count] == 0)
            {
                [self showNetMessageInView:self.view];
            }
            else
                [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];
        }
        [self loadTableViewFootView];
    }
    else if(number == 100)
    {//标明fail
        _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";

        [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];
    }
    if (downPullBool)
    {
        downPullBool = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
