//
//  Ty_Order_Notification_Controller.m
//  腾云家务
//
//  Created by lgs on 14-6-25.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
#import "Ty_OrderVC_PublishAndOrderController.h"
#import "Ty_OrderVC_MasterOrder.h"
#import "Ty_OrderVC_MasterPublish.h"
#import "Ty_OrderVC_Worker_ReceivedPush.h"
#import "Ty_OrderVC_Worker_ReceivedOrder.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "My_LoginViewController.h"


static BOOL freshNewNotificationBool;//是否处于刷新状态

#import "Ty_Order_Notification_Controller.h"

@interface Ty_Order_Notification_Controller ()

@end

@implementation Ty_Order_Notification_Controller
@synthesize masterTableview;
@synthesize workerTableview;
@synthesize netWorkBusine;
@synthesize _isRefreshing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_Order_Notification_Controller"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    freshNewNotificationBool = NO;
    
    self.title = @"订单";
    
    [self.view bringSubviewToFront:self.naviGationController];
//    [self loadBackButton];
    
    //    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, MainFrame.size.height-44)];
    
    [self.view setBackgroundColor:view_BackGroudColor];
    
    but_select = -1;//按钮初设置为第一个

    if (IFLOGINYES)
    {
        if ([MyLoginUserType intValue] == 0 || [MyLoginUserType intValue] == 1)
        {//中介
            but_select = 1;
            lastIdentity = 0;//中介
            
            [self loadFilterButton];//加载筛选按钮
            
            self.workerTableview =[[UITableView alloc]initWithFrame:CGRectMake(10, 32, self.view.frame.size.width - 20, self.view.frame.size.height - 64 - 49 - 32) style:UITableViewStylePlain];
            [self.workerTableview setBackgroundColor:view_BackGroudColor];
            
            workerTableview.showsVerticalScrollIndicator = NO;//不显示滚动条
            workerTableview.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
            
            workerTableview.dataSource = self;
            workerTableview.delegate = self;
            
            [self.view addSubview:workerTableview];

        }
        else
        {
            lastIdentity = 2;//个人
            
            self.masterTableview =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
            [self.masterTableview setBackgroundColor:view_BackGroudColor];
            
            masterTableview.showsVerticalScrollIndicator = NO;//不显示滚动条
            masterTableview.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
            
            masterTableview.dataSource = self;
            masterTableview.delegate = self;
            
            [self.view addSubview:masterTableview];
        }

    }
    
    
    //实例化网络业务层
    netWorkBusine = [[Ty_News_Busine_Network alloc]init];
    netWorkBusine.delegate = self;
    
    [netWorkBusine freshData];
    [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotificationTableViewDataSourse:) name:@"refreshDateSource" object:nil];
    
    [self showLoadingInView:self.view];
    
    [self refreshViewInit];//定义下拉刷新
    
    //定义上拉刷新
    if (_refreshLoadView == nil)
    {
        if (but_select == -1)
        {
            _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        }
        else
        {
            _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 32, self.view.bounds.size.width - 20, 40.0)];
        }
        _refreshLoadView._messageLabel.text = @"正在加载...";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([MyLoginUserType intValue] != lastIdentity)
    {
        lastIdentity = [MyLoginUserType intValue];
        
        [super viewWillAppear:animated];
        if ([MyLoginUserType intValue] == 0)
        {
            but_select = 1;
            
            [self.masterTableview removeFromSuperview];
            [self loadFilterButton];
            
            [self.view addSubview:self.workerTableview];
        }
        else if([MyLoginUserType intValue] == 2)
        {
            but_select = -1;
            
            [waitServiceButton removeFromSuperview];
            [canYZButton removeFromSuperview];
            [servieceRecordButton removeFromSuperview];
            
            [self.workerTableview removeFromSuperview];
            [self.view addSubview:self.masterTableview];
        }
        
        [netWorkBusine freshPage];
        [netWorkBusine freshArrayWithButtonTag:-1];
        [self showLoadingInView:self.view];
        [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
    }
    else
    {
        [super viewWillAppear:animated];
        if ([MyLoginUserType intValue] == 0 || [MyLoginUserType intValue] == 1)
        {
            [self.workerTableview reloadData];
        }
        else
        {
            if ([netWorkBusine.xuQiuInfoArray count] == 0 && freshNewNotificationBool == NO)
            {
                [self hideMessageView];
                [self hideNetMessageView];
                
                [self showLoadingInView:self.view];
                [netWorkBusine freshPage];
                [netWorkBusine publishAndOrderNotificationWithButtonTag:-1];
            }
            else
                [self.masterTableview reloadData];
        }
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
    
    UIImageView * imageLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 31)];
    imageLine1.image = [UIImage imageNamed:@"my_coupon_line.png"];
    [waitServiceButton addSubview:imageLine1];
    
    
    canYZButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [canYZButton setFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 32)];
    [canYZButton setTitle:@"待应征" forState:UIControlStateNormal];
    [canYZButton setTitleColor:text_blackColor forState:UIControlStateNormal];
    [canYZButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
    canYZButton.tag = 2400;
    canYZButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    
    [canYZButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * imageLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 31)];
    imageLine2.image = [UIImage imageNamed:@"my_coupon_line.png"];
    [canYZButton addSubview:imageLine2];

    servieceRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [servieceRecordButton setFrame:CGRectMake(2 * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 32)];
    [servieceRecordButton setTitle:@"服务记录" forState:UIControlStateNormal];
    [servieceRecordButton setTitleColor:text_blackColor forState:UIControlStateNormal];
    [servieceRecordButton setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
    servieceRecordButton.tag = 2402;
    servieceRecordButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    
    [servieceRecordButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * imageLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 31)];
    imageLine3.image = [UIImage imageNamed:@"my_coupon_line.png"];
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
    if (but_select == -1)
    {
        NSLog(@"network array=%d",[netWorkBusine.xuQiuInfoArray count]);
        return [netWorkBusine.xuQiuInfoArray count];
        
    }
    else if (but_select == 0)
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
    
    if (but_select == -1)
    {
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
            return nil;
    }
    else
    {
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
    if (but_select == -1)
    {
        tempXuQiu =[netWorkBusine.xuQiuInfoArray objectAtIndex:indexPath.section];
    }
    else if (but_select == 0)
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
    
    if (-1 == but_select)
    {
        [self.masterTableview addSubview:_refreshView];
    }
    else
    {
        [self.workerTableview addSubview:_refreshView];
    }
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
    }
}

#pragma mark ----上拉刷新的方法
#pragma mark 上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",_isRefreshing);
    UITableView * tableview;

    if ([MyLoginUserType intValue] == 0 || [MyLoginUserType intValue] == 1)
    {
        tableview = workerTableview;
    }
    else
        tableview = masterTableview;
    
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView != nil&& tableview.contentOffset.y > 0)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!_isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            _isRefreshing = YES;
            
            [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
        }
    }
}
-(void)loadTableViewFootView
{
    if ([MyLoginUserType intValue] == 0 || [MyLoginUserType intValue] == 1)
    {
        if (workerTableview.contentSize.height>=workerTableview.bounds.size.height)
        {
            self.workerTableview.tableFooterView = _refreshLoadView;
        }
        else
            self.workerTableview.tableFooterView = nil;

    }
    else
    {
        if (masterTableview.contentSize.height>=masterTableview.bounds.size.height)
        {
            self.masterTableview.tableFooterView = _refreshLoadView;
        }
        else
            self.masterTableview.tableFooterView = nil;

    }
}
#pragma mark 网络层通知
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    [self hideProgressHUD];
    
    if (but_select == -1)
    {
        canYZBool = NO;
        waitServiceBool = NO;
        serviceRecordBool = NO;
    }
    else if (but_select == 0)
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

    
    int objectNumber = [[[_notification object] objectForKey:@"number"] intValue];
    if (objectNumber <=2)
    {
        freshNewNotificationBool = NO;
        _isRefreshing = NO;
        [_refreshLoadView._netMind stopAnimating];
        
        [_refreshView performSelector:@selector(endRefresh)
                           withObject:nil afterDelay:0.1
                              inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
        
        if (objectNumber == 0)
        {
            if (-1 == but_select)
            {
                [self.masterTableview reloadData];
            }
            else
            {
                [self.workerTableview reloadData];
            }
        }
        else if(objectNumber == 1)
        {
            if (but_select == -1)
            {
                if ([netWorkBusine.xuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.view message:@"无查询信息"];
                }
            }
            else if(but_select == 0)
            {
                if ([netWorkBusine.canYZxuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.view message:@"无待应征的订单"];
                }
            }
            else if (but_select == 1)
            {
                if ([netWorkBusine.waitServiceXuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.view message:@"无待服务的订单"];
                }
            }
            else
            {
                if ([netWorkBusine.serviceRecordXuQiuInfoArray count] == 0)
                {
                    [self showMessageInView:self.view message:@"无查询信息"];
                }
            }
            _refreshLoadView._messageLabel.text = @"已加载全部";
        }
        else
        {
            [self showToastMakeToast:@"网络请求失败,请重试" duration:1 position:@"center"];

            _refreshLoadView._messageLabel.text = @"网络请求失败，向上拉重新加载...";
            if (but_select == -1)
            {
                if ([netWorkBusine.xuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.view];
                }
            }
            else if(but_select == 0)
            {
                if ([netWorkBusine.canYZxuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.view];
                }
            }
            else if (but_select == 1)
            {
                if ([netWorkBusine.waitServiceXuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.view];
                }
            }
            else
            {
                if ([netWorkBusine.serviceRecordXuQiuInfoArray count] == 0)
                {
                    [self showNetMessageInView:self.view];
                }

            }
            
        }
        [self loadTableViewFootView];
    }
    else if(objectNumber <=4)
    {
        if (objectNumber == 3)
        {
            freshNewNotificationBool = YES;
            //请求新的数据
            [netWorkBusine freshPage];
            [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
        }
        else
        {
            [self showToastMakeToast:@"关闭失败" duration:1 position:@"center"];
        }
        
    }
    else if(objectNumber == 100)
    {//标明fail
        _isRefreshing = NO;
        [_refreshLoadView._netMind stopAnimating];
        freshNewNotificationBool = NO;
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
}

#pragma mark 筛选的按钮点击
-(void)filterButtonPressed:(UIButton *)but
{
    _refreshLoadView._messageLabel.text = @"正在加载...";
    switch (but.tag)
    {
        case 2400:
        {
            //待应征
            but_select = 0;
            [netWorkBusine freshPage];
            [netWorkBusine freshArrayWithButtonTag:but_select];
            if (!canYZBool)
            {
                canYZBool = YES;
                [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
            }
            
            [self.workerTableview reloadData];
            
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

            if (!waitServiceBool)
            {
                waitServiceBool = YES;
                [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
            }
            [self.workerTableview reloadData];

            
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

            if (!serviceRecordBool)
            {
                serviceRecordBool = YES;
                [netWorkBusine publishAndOrderNotificationWithButtonTag:but_select];
            }
            
            [self.workerTableview reloadData];

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

#pragma mark -- 登录跳转
- (void)loginWhenNotLogin
{
    My_LoginViewController *loginViewController = [[My_LoginViewController alloc]init];
    [self.naviGationController pushViewController:loginViewController animated:YES];
    
    loginViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
