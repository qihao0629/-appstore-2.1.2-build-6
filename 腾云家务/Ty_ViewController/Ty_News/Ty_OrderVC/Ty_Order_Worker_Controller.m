//
//  Ty_Order_Worker_Controller.m
//  腾云家务
//
//  Created by lgs on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Worker_ReceivedPush.h"
#import "Ty_OrderVC_Worker_ReceivedOrder.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "My_LoginViewController.h"
#import "AppDelegateViewController.h"


static BOOL freshNewNotificationBool;//是否处于刷新状态

#import "Ty_Order_Worker_Controller.h"

@interface Ty_Order_Worker_Controller ()

@end

@implementation Ty_Order_Worker_Controller
@synthesize tableview;
@synthesize netWorkBusine;
@synthesize _isRefreshing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_Order_Worker_Controller"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    freshNewNotificationBool = NO;
    lastUserGuid = MyLoginUserGuid;
    
    self.title = @"订单";
    
    [self.view bringSubviewToFront:self.naviGationController];
    
//    self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.imageView_background.hidden = YES;
    [self.view setBackgroundColor:view_BackGroudColor];
    
    but_select = 1;
    lastIdentity = 0;//中介
    
    [self loadFilterButton];//加载筛选按钮
    
    self.tableview =[[UITableView alloc]initWithFrame:CGRectMake(10, 32, self.view.frame.size.width - 20, self.view.frame.size.height - 64 - 49 - 32) style:UITableViewStylePlain];
    
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
    [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
    freshNewNotificationBool = YES;
    
    //去掉底部红点
    [self removeBottomRedIcon];
    
    [self showLoadingInView:self.view];
    
    [self refreshViewInit];//定义下拉刷新
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTopTipNotificationWithIndex:) name:@"WorkerShowTopTip" object:nil];

    //定义上拉刷新
    if (_refreshLoadView == nil)
    {
        _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 32, self.view.bounds.size.width - 20, 40.0)];
        _refreshLoadView._messageLabel.text = @"正在加载...";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([lastUserGuid isEqualToString:MyLoginUserGuid])
    {//相同的话
        [super viewWillAppear:animated];
        [self.tableview reloadData];
    }
    else
    {
        [super viewWillAppear:animated];
        lastUserGuid = MyLoginUserGuid;
        
        [self hideMessageView];
        [self hideNetMessageView];
        
        //buttonselect 变为1
        but_select = 1;
        
        [self showLoadingInView:self.view];
        [netWorkBusine freshData];
        [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
        freshNewNotificationBool = YES;
        
        //去掉底部红点
        [self removeBottomRedIcon];
        
        [self.tableview reloadData];
    }
}
-(void)loadFilterButton
{
    waitServiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [waitServiceButton setFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 32)];
    [waitServiceButton setTitle:@"待服务" forState:UIControlStateNormal];
    [waitServiceButton setTitleColor:ColorRedText forState:UIControlStateNormal];
    [waitServiceButton setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
    waitServiceButton.tag = 2401;
    waitServiceButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [waitServiceButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //红点
    waitServiceRedIcon = [[UIImageView alloc]initWithFrame:CGRectMake(81, 3, 20, 20)];
    [waitServiceRedIcon setImage:[UIImage imageNamed:@"Message_UnreadImage"]];
    waitServiceRedIcon.hidden = YES;
    
    UIImageView * imageLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 31)];
    imageLine1.image = [UIImage imageNamed:@"my_coupon_line.png"];
    [waitServiceButton addSubview:waitServiceRedIcon];
    [waitServiceButton addSubview:imageLine1];
    
    
    canYZButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [canYZButton setFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 32)];
    [canYZButton setTitle:@"待应征" forState:UIControlStateNormal];
    [canYZButton setTitleColor:text_blackColor forState:UIControlStateNormal];
    [canYZButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
    canYZButton.tag = 2400;
    canYZButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [canYZButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //红点
    canYZRedIcon = [[UIImageView alloc]initWithFrame:CGRectMake(81, 3, 20, 20)];
    [canYZRedIcon setImage:[UIImage imageNamed:@"Message_UnreadImage"]];
    canYZRedIcon.hidden = YES;

    UIImageView * imageLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 31)];
    imageLine2.image = [UIImage imageNamed:@"my_coupon_line.png"];
    [canYZButton addSubview:canYZRedIcon];
    [canYZButton addSubview:imageLine2];
    
    servieceRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [servieceRecordButton setFrame:CGRectMake(2 * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 32)];
    [servieceRecordButton setTitle:@"服务记录" forState:UIControlStateNormal];
    [servieceRecordButton setTitleColor:text_blackColor forState:UIControlStateNormal];
    [servieceRecordButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
    servieceRecordButton.tag = 2402;
    servieceRecordButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    
    servieceRecordRedIcon = [[UIImageView alloc]initWithFrame:CGRectMake(81, 3, 20, 20)];
    [servieceRecordRedIcon setImage:[UIImage imageNamed:@"Message_UnreadImage"]];
    servieceRecordRedIcon.hidden = YES;

    [servieceRecordButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * imageLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 31)];
    imageLine3.image = [UIImage imageNamed:@"my_coupon_line.png"];
    [servieceRecordButton addSubview:servieceRecordRedIcon];
    [servieceRecordButton addSubview:imageLine3];
    
    
    [self.view addSubview:waitServiceButton];
    [self.view addSubview:canYZButton];
    [self.view addSubview:servieceRecordButton];
    waitServiceBool = NO;
    canYZBool = NO;
    serviceRecordBool = NO;
}
#pragma mark -----tableView的数据源代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (but_select == 0)
    {
        return [netWorkBusine.canYZxuQiuInfoArray count];
    }
    else if (but_select == 1)
    {
        return [netWorkBusine.waitServiceXuQiuInfoArray count];
    }
    else
    {
        return [netWorkBusine.serviceRecordXuQiuInfoArray count];
    }
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
    }
    
    if (but_select == 0)
    {
        if ([[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type] intValue] == 0)
        {//抢单
            cell.workerSmallImageLabel.text = @"抢单";
            [cell.workerSmallImageView setImage:JWImageName(@"greenBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        else
        {
            cell.workerSmallImageLabel.text = @"预约";
            [cell.workerSmallImageView setImage:JWImageName(@"yellowBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        
        if ([[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] publishUserType] intValue] == 0)
        {
            [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
        }
        else
        {
            if ([[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] publishUserSex] intValue] == 0)
            {
                [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
            }
            else
            {
                [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
            }
        }
        [cell setHight];
        int stage =[[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] requirement_Stage] intValue];
        
        switch (stage)
        {
            case 0:
                cell.orderStageString = @"待应征";
                break;
            case 6:
                if ([[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] candidateStatus] intValue] == 0)
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
                if ([[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText] isEqualToString:@""])
                {
                    cell.orderStageString  = @"交易中";
                }
                else
                {
                    cell.orderStageString  = [[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText];
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
        
        NSMutableString * servieceAreaStr = [[NSMutableString alloc]initWithString:[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] area]];
        servieceAreaStr = [NSMutableString stringWithString:[servieceAreaStr stringByAppendingString:[NSString stringWithFormat:@"  %@",[[NSMutableString alloc]initWithString:[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] region]]]]];
        cell.servieceAreaLabel.text = [NSString stringWithFormat:@"服务区域:  %@",servieceAreaStr];
        
        
        NSString * servieceTimeStr =[[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section] startTime];
        cell.servieceTimeLabel.text = [NSString stringWithFormat:@"服务时间:  %@",servieceTimeStr];
        
    }
    else if (but_select == 1)
    {
        if ([[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type] intValue] == 0)
        {//抢单
            cell.workerSmallImageLabel.text = @"抢单";
            [cell.workerSmallImageView setImage:JWImageName(@"greenBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        else
        {
            cell.workerSmallImageLabel.text = @"预约";
            [cell.workerSmallImageView setImage:JWImageName(@"yellowBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        
        if ([[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] publishUserType] intValue] == 0)
        {
            [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
        }
        else
        {
            if ([[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] publishUserSex] intValue] == 0)
            {
                [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
            }
            else
            {
                [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
            }
        }
        [cell setHight];
        int stage =[[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] requirement_Stage] intValue];
        
        switch (stage)
        {
            case 0:
                cell.orderStageString = @"待应征";
                break;
            case 6:
                if ([[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] candidateStatus] intValue] == 0)
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
                if ([[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText] isEqualToString:@""])
                {
                    cell.orderStageString  = @"交易中";
                }
                else
                {
                    cell.orderStageString  = [[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText];
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
        
        NSMutableString * servieceAreaStr = [[NSMutableString alloc]initWithString:[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] area]];
        servieceAreaStr = [NSMutableString stringWithString:[servieceAreaStr stringByAppendingString:[NSString stringWithFormat:@"  %@",[[NSMutableString alloc]initWithString:[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] region]]]]];
        cell.servieceAreaLabel.text = [NSString stringWithFormat:@"服务区域:  %@",servieceAreaStr];
        
        
        NSString * servieceTimeStr =[[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section] startTime];
        cell.servieceTimeLabel.text = [NSString stringWithFormat:@"服务时间:  %@",servieceTimeStr];
    }
    else
    {
        if ([[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] requirement_Type] intValue] == 0)
        {//抢单
            cell.workerSmallImageLabel.text = @"抢单";
            [cell.workerSmallImageView setImage:JWImageName(@"greenBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        else
        {
            cell.workerSmallImageLabel.text = @"预约";
            [cell.workerSmallImageView setImage:JWImageName(@"yellowBackGround")];
            
            cell.workNameLabel.text = [[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] workName];
        }
        
        if ([[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] publishUserType] intValue] == 0)
        {
            [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
        }
        else
        {
            if ([[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] publishUserSex] intValue] == 0)
            {
                [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
            }
            else
            {
                [cell.workerBigImageView setImageWithURL:[NSURL URLWithString:[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] publishUserPhoto]] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
            }
        }
        [cell setHight];
        int stage =[[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] requirement_Stage] intValue];
        
        switch (stage)
        {
            case 0:
                cell.orderStageString = @"待应征";
                break;
            case 6:
                if ([[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] candidateStatus] intValue] == 0)
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
                if ([[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText] isEqualToString:@""])
                {
                    cell.orderStageString  = @"交易中";
                }
                else
                {
                    cell.orderStageString  = [[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] requirementStageText];
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
        
        NSMutableString * servieceAreaStr = [[NSMutableString alloc]initWithString:[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] area]];
        servieceAreaStr = [NSMutableString stringWithString:[servieceAreaStr stringByAppendingString:[NSString stringWithFormat:@"  %@",[[NSMutableString alloc]initWithString:[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] region]]]]];
        cell.servieceAreaLabel.text = [NSString stringWithFormat:@"服务区域:  %@",servieceAreaStr];
        
        
        NSString * servieceTimeStr =[[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section] startTime];
        cell.servieceTimeLabel.text = [NSString stringWithFormat:@"服务时间:  %@",servieceTimeStr];
    }
    
    
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
    
    if (but_select == 0)
    {
        tempXuQiu =[netWorkBusine.canYZxuQiuInfoArray objectAtIndex:indexPath.section];
    }
    else if (but_select == 1)
    {
        tempXuQiu =[netWorkBusine.waitServiceXuQiuInfoArray objectAtIndex:indexPath.section];
    }
    else
    {
        tempXuQiu =[netWorkBusine.serviceRecordXuQiuInfoArray objectAtIndex:indexPath.section];
    }
    
    [Ty_News_busine_Order_DataBase share_Busine_DataBase].dataBaseXuQiu = tempXuQiu;
    
    if ([[tempXuQiu userTypeBaseOnRequirement] isEqualToString:@"1"] == YES)
    {//雇工
        if ([[tempXuQiu requirement_Type] isEqualToString:@"0"] == YES)
        {//推送给我的
            Ty_OrderVC_Worker_ReceivedPush * receivedPushVC = [[Ty_OrderVC_Worker_ReceivedPush alloc]init];
            receivedPushVC.requirementGuid = tempXuQiu.requirementGuid;
            
            [self.naviGationController pushViewController:receivedPushVC animated:YES];
        }
        else
        {//直接预约我的
            Ty_OrderVC_Worker_ReceivedOrder * receivedOrder = [[Ty_OrderVC_Worker_ReceivedOrder alloc]init];
            receivedOrder.requirementGuid = tempXuQiu.requirementGuid;
            
            [self.naviGationController pushViewController:receivedOrder animated:YES];
        }
    }
    else
    {//雇主
        NSLog(@"中介订单界面出错了");
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
        freshNewNotificationBool = YES;
        //请求新的数据
        [netWorkBusine freshPage];
        [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
        
        if (0 == but_select)
        {
            [self removeTopTipWithIndex:1];
        }
        else if (1 == but_select)
        {
            [self removeTopTipWithIndex:0];
        }
        else if (2 == but_select)
        {
            [self removeTopTipWithIndex:1];
        }
        
        //去掉底部红点
        [self removeBottomRedIcon];
    }
}

#pragma mark ----上拉刷新的方法
#pragma mark 上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",_isRefreshing);
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView != nil&& tableview.contentOffset.y > 0 && NO == freshNewNotificationBool)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!_isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            _isRefreshing = YES;
            
            [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
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
    
    if (but_select == 0)
    {
        canYZBool = NO;
    }
    else if (but_select == 1)
    {
        waitServiceBool = NO;
    }
    else
    {
        serviceRecordBool = NO;
    }
    
    _isRefreshing = NO;
    [_refreshLoadView._netMind stopAnimating];
    freshNewNotificationBool = NO;
    [_refreshView performSelector:@selector(endRefresh)
                       withObject:nil afterDelay:0.1
                          inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    

    int objectNumber = [[[_notification object] objectForKey:@"number"] intValue];
    if (objectNumber <=2)
    {
        if (objectNumber == 0)
        {
            [self.tableview reloadData];
        }
        else if(objectNumber == 1)
        {
            if(but_select == 0)
            {
                if ([netWorkBusine.canYZxuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.tableview message:@"无待应征的订单"];
                }
            }
            else if (but_select == 1)
            {
                if ([netWorkBusine.waitServiceXuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.tableview message:@"无待服务的订单"];
                }
            }
            else
            {
                if ([netWorkBusine.serviceRecordXuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.tableview message:@"无查询信息"];
                }
            }
            _refreshLoadView._messageLabel.text = @"已加载全部";
        }
        else
        {
            [self showToastMakeToast:@"网络请求失败,请重试" duration:1 position:@"center"];
            
            _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
            if(but_select == 0)
            {
                if ([netWorkBusine.canYZxuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.tableview];
                }
            }
            else if (but_select == 1)
            {
                if ([netWorkBusine.waitServiceXuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.tableview];
                }
            }
            else
            {
                if ([netWorkBusine.serviceRecordXuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.tableview];
                }
            }
            
        }
        [self loadTableViewFootView];
    }
    else if(objectNumber == 100)
    {//标明fail
        
        _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
        
        [self showNetMessageInView:self.view];
        //        [self showToastMakeToast:@"网络请求失败,请重试" duration:1 position:@"center"];
    }
    
}

#pragma mark 重新加载回执
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
    freshNewNotificationBool = YES;
    
    //去掉底部红点
    [self removeBottomRedIcon];
}

#pragma mark 筛选的按钮点击
-(void)filterButtonPressed:(UIButton *)but
{
    _refreshLoadView._messageLabel.text = @"正在加载...";
    
    //去掉底部红点
    [self removeBottomRedIcon];

    switch (but.tag)
    {
        case 2400:
        {
            //待应征
            but_select = 0;
            [netWorkBusine freshPage];
            [netWorkBusine freshArrayWithButtonTag:but_select];
            
            [self removeTopTipWithIndex:1];
            
            if (!canYZBool)
            {
                canYZBool = YES;
                [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
            }
            
            [self.tableview reloadData];
            
            [but setTitleColor:ColorRedText forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
            
            [waitServiceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [waitServiceButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [servieceRecordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [servieceRecordButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            
            [self showLoadingInView:self.view];
            
            break;
        }
        case 2401:
            //待服务
        {
            but_select = 1;
            [netWorkBusine freshPage];
            [netWorkBusine freshArrayWithButtonTag:but_select];
            
            [self removeTopTipWithIndex:0];

            if (!waitServiceBool)
            {
                waitServiceBool = YES;
                [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
            }
            [self.tableview reloadData];
            
            
            [but setTitleColor:ColorRedText forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
            
            [canYZButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [canYZButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [servieceRecordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [servieceRecordButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [self showLoadingInView:self.view];
            
            break;
        }
            
        case 2402:
        {
            
            //服务记录
            but_select = 2;
            [netWorkBusine freshPage];
            [netWorkBusine freshArrayWithButtonTag:but_select];
            
            [self removeTopTipWithIndex:2];

            if (!serviceRecordBool)
            {
                serviceRecordBool = YES;
                [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
            }
            
            [self.tableview reloadData];
            
            [but setTitleColor:ColorRedText forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
            
            
            [canYZButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [canYZButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [waitServiceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [waitServiceButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [self showLoadingInView:self.view];
            
            break;
        }
        default:
            break;
    }
}
#pragma mark 顶层通知
-(void)showTopTipNotificationWithIndex:(NSNotification *)_notification
{
    int _index = [[[_notification object] objectForKey:@"index"]intValue];
    if (0 == _index)
    {
        waitServiceRedIcon.hidden = NO;
    }
    else if (1 == _index)
    {
        canYZRedIcon.hidden = NO;
    }
    else
    {
        servieceRecordRedIcon.hidden = NO;
    }
}
/*
 移除顶部的通知
 */
-(void)removeTopTipWithIndex:(int)_index
{
    if (0 == _index)
    {
        waitServiceRedIcon.hidden = YES;
    }
    else if (1 == _index)
    {
        canYZRedIcon.hidden = YES;
    }
    else
    {
        servieceRecordRedIcon.hidden = YES;
    }
}
/**
 移除底部的红点
 **/
-(void)removeBottomRedIcon
{
    //设置底部的红点取消
    AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [appDelegateVC setOrderTabBarIcon:0];
    appDelegateVC = nil;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
