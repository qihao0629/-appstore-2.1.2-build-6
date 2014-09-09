//
//  Ty_Order_Master_Controller.m
//  腾云家务
//
//  Created by lgs on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_MasterOrder.h"
#import "Ty_OrderVC_MasterPublish.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "My_LoginViewController.h"
#import "AppDelegateViewController.h"

static BOOL freshNewNotificationBool;//是否处于刷新状态
static BOOL downPullBool;//是否是下拉刷新，因为出现了203，但是还有以前的旧数据

#import "Ty_Order_Master_Controller.h"

@interface Ty_Order_Master_Controller ()

@end

@implementation Ty_Order_Master_Controller
@synthesize tableview;
@synthesize netWorkBusine;
@synthesize _isRefreshing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_Order_Master_Controller"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    freshNewNotificationBool = NO;
    downPullBool = NO;
    
    lastUserGuid = MyLoginUserGuid;
    
    self.title = @"订单";

//    [self setNavigationBarHidden:YES animated:NO];
    [self.view bringSubviewToFront:self.naviGationController];
    self.imageView_background.hidden = YES;
    
//    self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
//    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
//    UIView * tempVIwe = [[UIView alloc]initWithFrame:CGRectMake(0, 1, 320, 2)];
//    [tempVIwe setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:tempVIwe];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTopTipNotification) name:@"ShowTopTipNotification" object:nil];

    [self.view setBackgroundColor:view_BackGroudColor];
    
    lastIdentity = 2;//个人
    
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, self.view.frame.size.height - 49 - 64) style:UITableViewStylePlain];
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
    [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
    freshNewNotificationBool = YES;
    downPullBool = YES;

    //设置底部的红点取消
    AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [appDelegateVC setOrderTabBarIcon:0];
    [self removeTopTipNotification];

    appDelegateVC = nil;

    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotificationTableViewDataSourse:) name:@"refreshDateSource" object:nil];
    
    [self showLoadingInView:self.view];
    
    [self refreshViewInit];//定义下拉刷新
    
    //定义上拉刷新
    if (_refreshLoadView == nil)
    {
        _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        _refreshLoadView._messageLabel.text = @"正在加载...";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([lastUserGuid isEqualToString:MyLoginUserGuid])
    {//相同的话
        if ([netWorkBusine.xuQiuInfoArray count] == 0 && freshNewNotificationBool == NO)
        {
            [super viewWillAppear:animated];
            
            [self hideMessageView];
            [self hideNetMessageView];
            
            [self showLoadingInView:self.view];
            [netWorkBusine freshPage];
            [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
            freshNewNotificationBool = YES;
            
            //设置底部的红点取消
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
            [appDelegateVC setOrderTabBarIcon:0];
            [self removeTopTipNotification];

            appDelegateVC = nil;
        }
        else
        {
            [super viewWillAppear:animated];
            [self.tableview reloadData];
        }
    }
    else
    {
        [super viewWillAppear:animated];
        lastUserGuid = MyLoginUserGuid;
        
        [self hideMessageView];
        [self hideNetMessageView];
        
        [self showLoadingInView:self.view];
        [netWorkBusine freshData];
        [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
        freshNewNotificationBool = YES;
        
        //设置底部的红点取消
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        [appDelegateVC setOrderTabBarIcon:0];
        [self removeTopTipNotification];

        appDelegateVC = nil;

        
        [self.tableview reloadData];
    }
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
    
    if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] userTypeBaseOnRequirement] isEqualToString:@"0"])
    {
        Ty_Order_MySetting_MasterCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[Ty_Order_MySetting_MasterCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        }
        NSLog(@"%@,%@",[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type],[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName]);
        
        if ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type] intValue] == 0)
        {//抢单
            cell.masterSmallImageLabel.text = @"抢单";
            
            [cell.masterSmallImageView setImage:JWImageName(@"greenBackGround")];
            cell.workNameLabel.text = [[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        else
        {
            cell.masterSmallImageLabel.text = @"预约";
            [cell.masterSmallImageView setImage:JWImageName(@"yellowBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        int stage =[[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Stage] intValue];
        
        if (stage == 2 || stage == 3)
        {//是否显示服务商的姓名
            if ([[[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] serverObject] userType] intValue] == 0)
            {
                cell.workerNameLabel.text = [NSString stringWithFormat:@"服务人:  %@",[[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] serverObject] respectiveCompanies]];
            }
            else
            {
                cell.workerNameLabel.text = [NSString stringWithFormat:@"服务人:  %@",[[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] serverObject] userRealName]];
            }
        }
        else if (stage == 1)
        {
            cell.workerNameLabel.text = @"请等待您预约的服务商确认";
        }
        else if (stage == 0)
        {
            cell.workerNameLabel.text = @"请等待商户应征";
        }
        else if (stage == 6)
        {
            cell.workerNameLabel.text = [NSString stringWithFormat:@"已经有%@人应征",[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] employeeCount]];
        }
        else if(stage == 7)
        {
            cell.workerNameLabel.text = @"请等待您预约的服务商派工";
        }
        else
        {
            cell.workerNameLabel.text = @"该需求交易关闭";
        }
        Ty_News_Busine_HandlePlist  * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
        
        NSString * tempWorkName =[NSString stringWithString:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] workName]];
        
        [cell.masterBigImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempBusine findWorkPhotoAddress:tempWorkName]]]];
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[tempBusine findWorkPhotoAddress:[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.row] workName]]]);
        tempBusine = nil;
        
        [cell setHight];
        switch ([[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] requirement_Stage] intValue])
        {
            case 0:
                cell.orderStageString = @"待应征";
                break;
            case 6:
                cell.orderStageString = @"有应征";
                break;
            case 1://预约
                cell.orderStageString= @"待服务商确认";
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
        
        NSString * servieceTimeStr =[[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section] startTime];
        cell.servieceTimeLabel.text = [NSString stringWithFormat:@"服务时间:  %@",servieceTimeStr];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    else//出错了
    {
        NSLog(@"订单雇主界面，出错了");
        return nil;
    }
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
    
    if ([[tempXuQiu userTypeBaseOnRequirement] isEqualToString:@"0"] == YES)
    {//雇主
        if ([[tempXuQiu requirement_Type] isEqualToString:@"0"] == YES)
        {//直接发布
            Ty_OrderVC_MasterPublish * masterPublishVC = [[Ty_OrderVC_MasterPublish alloc]init];
            masterPublishVC.requirementGuid = tempXuQiu.requirementGuid;
            masterPublishVC.xuQiuInfo = tempXuQiu;
            
            [self.naviGationController pushViewController:masterPublishVC animated:YES];
        }
        else
        {
            Ty_OrderVC_MasterOrder * masterOrderVC = [[Ty_OrderVC_MasterOrder alloc]init];
            masterOrderVC.requirementGuid = tempXuQiu.requirementGuid;
            masterOrderVC.xuQiuInfo = tempXuQiu;
            
            [self.naviGationController pushViewController:masterOrderVC animated:YES];
        }
    }
    else
    {//雇工
        NSLog(@"订单雇主界面，出错了");
        return;
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
#pragma mark ----定义下拉刷新
-(void) refreshViewInit
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
        //请求新的数据
        [netWorkBusine freshPage];
        [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
        freshNewNotificationBool = YES;
        downPullBool = YES;
        
        //设置底部的红点取消
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        [appDelegateVC setOrderTabBarIcon:0];
        [self removeTopTipNotification];

        appDelegateVC = nil;
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
            
            [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
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
#pragma mark 网络层通知
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    [self hideProgressHUD];
    
    _isRefreshing = NO;
    [_refreshLoadView._netMind stopAnimating];
    [_refreshView performSelector:@selector(endRefresh)
                       withObject:nil afterDelay:0.1
                          inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    freshNewNotificationBool = NO;
    
    int objectNumber = [[[_notification object] objectForKey:@"number"] intValue];
    if (objectNumber <=2)
    {
        if (objectNumber == 0)
        {
            [self.tableview reloadData];
        }
        else if(objectNumber == 1)
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
                [self showToastMakeToast:@"网络请求失败,请重试" duration:1 position:@"center"];
        }
        [self loadTableViewFootView];
    }
    else if(objectNumber == 100)
    {//标明fail
        _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
        
        [self showNetMessageInView:self.view];
        //        [self showToastMakeToast:@"网络请求失败,请重试" duration:1 position:@"center"];
    }
    //如果是的话，变成不是
    if (YES == downPullBool)
    {
        downPullBool = NO;
    }
}

#pragma mark 重新加载回执
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
    freshNewNotificationBool = YES;
    downPullBool = YES;

    //设置底部的红点取消
    AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [appDelegateVC setOrderTabBarIcon:0];
    [self removeTopTipNotification];
    
    appDelegateVC = nil;
}

#pragma mark 顶层通知
-(void)showTopTipNotification
{
    if (remindImageView == nil)
    {
        remindImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        [remindImageView setBackgroundColor:[UIColor colorWithRed:1.0000 green:0.3804 blue:0 alpha:0.5]];
        
        remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, remindImageView.frame.size.width, 14)];
        remindLabel.textColor = [UIColor whiteColor];
        [remindLabel setFont:FONT14_BOLDSYSTEM];
        remindLabel.text = @"订单发生变化,请您下拉刷新";
        remindLabel.textAlignment = NSTextAlignmentCenter;
        [remindLabel setBackgroundColor:[UIColor clearColor]];
        
        [remindImageView addSubview:remindLabel];
        [self.view addSubview:remindImageView];
    }
}
/*
 移除顶部的通知
 */
-(void)removeTopTipNotification
{
    [remindImageView removeFromSuperview];
    remindImageView = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
