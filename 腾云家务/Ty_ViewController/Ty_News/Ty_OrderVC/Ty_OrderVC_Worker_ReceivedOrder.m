//
//  Ty_OrderVC_Worker_ReceivedOrder.m
//  腾云家务
//
//  Created by lgs on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Worker_ReceivedOrder.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_Order_Master_OrderCell.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_Order_EvaluateCell.h"
#import "Ty_OrderVC_Evaluate_Master_Controller.h"
#import "Ty_OrderVC_SendEmployee_Controller.h"

@interface Ty_OrderVC_Worker_ReceivedOrder ()

@end

@implementation Ty_OrderVC_Worker_ReceivedOrder
@synthesize xuQiuInfo;
@synthesize workerOrder_TableView;
@synthesize worker_Order_Network_Busine;
@synthesize requirementGuid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_Worker_ReceivedOrder"];
    }
    return self;
}
/*
 实例化底部的按钮
 */
-(void)loadFootViewButton
{
    receivedOrderButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [receivedOrderButton setFrame:CGRectMake(64, 10, 83, 30)];
    receivedOrderButton.layer.cornerRadius =10;
    receivedOrderButton.layer.masksToBounds = YES;
    [receivedOrderButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
    [receivedOrderButton addTarget:self action:@selector(receivedButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    receivedOrderButton.exclusiveTouch = YES;
    
    receivedOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 83, 15)];
    [receivedOrderLabel setBackgroundColor:[UIColor clearColor]];
    receivedOrderLabel.text = @"接单并派工";
    receivedOrderLabel.textAlignment = NSTextAlignmentCenter;
    [receivedOrderLabel setFont:FONT14_BOLDSYSTEM];
    receivedOrderLabel.textColor = [UIColor whiteColor];
    [receivedOrderButton addSubview:receivedOrderLabel];
    
    refusedOrderButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [refusedOrderButton setFrame:CGRectMake(175, 10, 83, 30)];
    refusedOrderButton.layer.cornerRadius =3;
    refusedOrderButton.layer.masksToBounds = YES;
    [refusedOrderButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok"] forState:UIControlStateNormal];
    [refusedOrderButton addTarget:self action:@selector(refusedButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    refusedOrderButton.exclusiveTouch = YES;
    
    refusedOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 83, 15)];
    [refusedOrderLabel setBackgroundColor:[UIColor clearColor]];
    refusedOrderLabel.text = @"拒接接单";
    refusedOrderLabel.textAlignment = NSTextAlignmentCenter;
    [refusedOrderLabel setFont:FONT14_BOLDSYSTEM];
    refusedOrderLabel.textColor = [UIColor redColor];
    [refusedOrderButton addSubview:refusedOrderLabel];

    centerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [centerButton setFrame:CGRectMake(110, 10, 100, 30)];
    centerButton.layer.cornerRadius =3;
    centerButton.layer.masksToBounds = YES;
    [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok"] forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(centerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    centerButton.exclusiveTouch = YES;
    
    centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [centerLabel setBackgroundColor:[UIColor clearColor]];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    [centerLabel setFont:FONT14_BOLDSYSTEM];
    centerLabel.textColor = [UIColor whiteColor];
    [centerButton addSubview:centerLabel];
    
    privateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateButton setFrame:CGRectMake(270, 0, 50, 49)];
    [privateButton setImage:[UIImage imageNamed:@"home_message_red"] forState:UIControlStateNormal];
    
    [privateButton addTarget:self action:@selector(workerReceivedOrderPrivateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageView_background addSubview:privateButton];
    
    if ([xuQiuInfo.requirement_Stage intValue] == 1)
    {
        [self.imageView_background addSubview:receivedOrderButton];
        [self.imageView_background addSubview:refusedOrderButton];
    }
    else if([xuQiuInfo.requirement_Stage intValue] == 7)
    {
        centerLabel.text = @"接单并派工";
        [self.imageView_background addSubview:centerButton];
    }
    else if([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
    {//已派工或者已完成
        if ([xuQiuInfo.evaluateStage intValue] == 1 || [xuQiuInfo.evaluateStage intValue] == 0)
        {
            centerLabel.text = @"评价";
            centerLabel.textColor = [UIColor redColor];
            [self.imageView_background addSubview:centerButton];
        }
        else
            centerButton.hidden = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我收到的预约";
    
    worker_Order_Network_Busine =[[Ty_News_Busine_Network alloc]init];
    worker_Order_Network_Busine.delegate = self;
    
    [worker_Order_Network_Busine freshData];
    
    if (!xuQiuInfo)
    {
        xuQiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
    }

    semgentButtonTag = 1;
    ifDataLoad = NO;
    
    self.workerOrder_TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 49) style:UITableViewStylePlain];
    [self.workerOrder_TableView setBackgroundColor:view_BackGroudColor];
    
    workerOrder_TableView.showsVerticalScrollIndicator = NO;//不显示滚动条
    workerOrder_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
    
    workerOrder_TableView.dataSource = self;
    workerOrder_TableView.delegate = self;
    
    [self.view addSubview:workerOrder_TableView];
    
    [worker_Order_Network_Busine workerOrderCheckRequirementDetailAndRequirementGuid:requirementGuid];
    
    [self showLoadingInView:self.view];
}
#pragma mark semgentButton headerview三个按钮的点击代理
-(void)SemGentButtonAction:(id)sender
{
    if (semgentButtonTag != ((UIButton *)sender).tag)
    {
        semgentButtonTag =((UIButton *)sender).tag;
        [self.workerOrder_TableView reloadData];
    }
}

#pragma mark 底部一些按钮点击触发的方法
-(void)receivedButtonPressed
{//接单派工按钮
    Ty_OrderVC_SendEmployee_Controller * sendEmployeeVC = [[Ty_OrderVC_SendEmployee_Controller alloc]init];
    
    if ([[xuQiuInfo.serverObject userType] intValue] == 0)
    {
        sendEmployeeVC.ifHaveWishPerson = NO;//没有意向员工
    }
    else
    {
        sendEmployeeVC.ifHaveWishPerson = YES;//有意向员工
        sendEmployeeVC.masterWisePersonObject = xuQiuInfo.serverObject;
    }
    sendEmployeeVC.requirementString = xuQiuInfo.requirementGuid;
    sendEmployeeVC._workGuid = xuQiuInfo.workGuid;
    sendEmployeeVC._workName = xuQiuInfo.workName;
    
    [self.naviGationController pushViewController:sendEmployeeVC animated:YES];
}
-(void)refusedButtonPressed
{
    refusedOrderAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要拒绝接单么,一旦拒绝将无法达成交易" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [refusedOrderAlertView show];
}
-(void)centerButtonPressed
{
    if ([centerLabel.text isEqualToString:@"评价"])
    {
        Ty_OrderVC_Evaluate_Master_Controller * evaluate_MasterVC = [[Ty_OrderVC_Evaluate_Master_Controller alloc]init];
        evaluate_MasterVC.requirementGuidStr = xuQiuInfo.requirementGuid;
        Ty_Model_ServiceObject * masterObject = [[Ty_Model_ServiceObject alloc]init];
        masterObject.userGuid = xuQiuInfo.publishUserGuid;
        masterObject.headPhoto = xuQiuInfo.publishUserPhoto;
        masterObject.sex = xuQiuInfo.publishUserSex;
        masterObject.userType = xuQiuInfo.publishUserType;
        masterObject.userRealName = xuQiuInfo.publishUsrRealName;
        masterObject.evaluate = xuQiuInfo.publishUserEvaluate;
        
        evaluate_MasterVC.masterObject = masterObject;
        
        [self.naviGationController pushViewController:evaluate_MasterVC animated:YES];
    }
}
#pragma mark alertView 提示框的代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == refusedOrderAlertView)
    {
        switch (buttonIndex)
        {
            case 0:
                break;
            case 1:
                [self showProgressHUD:@"正在拒绝"];
                [worker_Order_Network_Busine workerRespondToRequirementWithRequiremnetGuid:requirementGuid withRespondString:@"1"];
                break;
            default:
                break;
        }
    }
}

#pragma mark tableview 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (semgentButtonTag == 1)
    {
        if (ifDataLoad)
        {
            return 1;
        }
        else
            return 0;
    }
    else
        return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ifDataLoad == YES)
    {
        if (semgentButtonTag == 1)
        {
            NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
            
            Ty_Order_Master_OrderCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (customCell == nil)
            {
                customCell = [[Ty_Order_Master_OrderCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
                if ([[xuQiuInfo.serverObject userType] intValue] == 0)
                {//直接预约中介
                    NSString * tempHeaderImage = [NSString stringWithFormat:@"%@",[xuQiuInfo.serverObject companyPhoto]];
                    if ([tempHeaderImage isEqualToString:@""])
                    {
                        [customCell.headImageView setImage:[UIImage imageNamed:@"Contact_image2"]];
                    }
                    else
                    {
                        [customCell.headImageView setImageWithURL:[NSURL URLWithString:tempHeaderImage] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
                    }
                    customCell.workerNameLabel.text = [xuQiuInfo.serverObject respectiveCompanies];
                    customCell.workerTypeLabel.text = @"商户";
                }
                else if([[xuQiuInfo.serverObject userType] intValue] == 1)
                {
                    NSString * tempHeaderImage = [NSString stringWithFormat:@"%@",[xuQiuInfo.serverObject headPhoto]];
                    if ([tempHeaderImage isEqualToString:@""])
                    {
                        [customCell.headImageView setImage:[UIImage imageNamed:@"Contact_image"]];
                    }
                    else
                    {
                        [customCell.headImageView setImageWithURL:[NSURL URLWithString:tempHeaderImage] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
                    }
                    customCell.workerNameLabel.text = [xuQiuInfo.serverObject userRealName];
                    customCell.workerTypeLabel.text = [xuQiuInfo.serverObject respectiveCompanies];
                }
                else
                {//不对
                    
                }
                NSString * tempStr = [NSString stringWithFormat:@"%@",[xuQiuInfo priceUnit]];
                if (ISNULLSTR(tempStr) || [tempStr isEqualToString:@"0"])
                {
                    tempStr = @"待定";
                    customCell.priceLabel.text = [NSString stringWithFormat:@"%@",tempStr];
                }
                else
                {
                    customCell.priceLabel.text = [NSString stringWithFormat:@"￥%@",tempStr];
                }
                
                Ty_News_Busine_HandlePlist * tempPlistBusine = [[Ty_News_Busine_HandlePlist alloc]init];
                
                NSString * unitString = [NSString stringWithFormat:@"/%@",[tempPlistBusine findWorkUnitAndWorkName:xuQiuInfo.workName]];
                customCell.unitLabel.text = unitString;
                tempPlistBusine = nil;
                
                [customCell.customStar setCustomStarNumber:[xuQiuInfo.serverObject.evaluate intValue]];
                customCell.serviceTimeLabel.text = [NSString stringWithFormat:@"%@人预约",[xuQiuInfo.serverObject serviceNumber]];
                
                if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue]== 3)
                {
                    if ([xuQiuInfo.evaluateStage intValue] == 0 || [xuQiuInfo.evaluateStage intValue] == 2)
                    {
                        customCell.evaluateButton.hidden = YES;
                    }
                    else
                    {
                        customCell.evaluateButton.hidden = YES;
                        customCell.userInteractionEnabled = NO;
                        customCell.buttonTitleLabel.text = @"已评价";
                        [customCell.evaluateButton setBackgroundImage:[UIImage imageNamed:@"canNotPressed"] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    customCell.evaluateButton.hidden = YES;
                }
                customCell.reminderLabel1.text= @"您已经被雇主直接预约,请尽快联系雇主。";
                customCell.reminderLabel2.text = @"雇主的联系方式请您查看“订单详细”。";
                customCell.reminderLabel2.textColor = [UIColor redColor];
                customCell.servicePhoneButton.hidden = YES;
            }
            [customCell setHight];
            
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            customCell.accessoryType = UITableViewCellAccessoryNone;
            
            return customCell;
        }
        else if(semgentButtonTag == 2)
        {
            NSString *CellIdentifier2 = [NSString stringWithFormat:@"OrderDdetaliCell2%d%d", [indexPath section], [indexPath row]];
            Ty_Order_DetailCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (customCell == nil)
            {
                customCell = [[Ty_Order_DetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2];
            }
            customCell.detailXuQiu = xuQiuInfo;
            customCell.requirementGuid = xuQiuInfo.requirementGuid;
            customCell.phoneCall = self;
            
            [customCell loadUI];
            [customCell loadValues];
            [customCell setHeight];
            customCell.accessoryType = UITableViewCellAccessoryNone;
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return customCell;
        }
        else
        {
            NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
            Ty_Order_EvaluateCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (customCell == nil)
            {
                customCell = [[Ty_Order_EvaluateCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                
                
                customCell.evaluateInformationDic =[[Ty_News_busine_Order_DataBase share_Busine_DataBase]getEvaluateAndGuid:xuQiuInfo.requirementGuid];
                
                customCell.evaluateStage = [xuQiuInfo.evaluateStage intValue];
                customCell.userType = @"1";
                [customCell loadValue];
            }
            customCell.accessoryType = UITableViewCellAccessoryNone;
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return customCell;
        }
    }
    else
    {
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
        UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
        
    }
}
#pragma mark tableView 的代理
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (semgentButtonTag == 1)
    {
        return 140;
    }
    else if (semgentButtonTag == 2)
    {
        UITableViewCell* cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
    else
    {
        UITableViewCell* cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
}
#pragma mark loading重新加载
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    [worker_Order_Network_Busine workerOrderCheckRequirementDetailAndRequirementGuid:requirementGuid];
}
#pragma mark 基类中网络通知的回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    [self hideProgressHUD];

    int number = [[[_notification object] objectForKey:@"number"]intValue];
    
    if (number <= 2)
    {
        if (number == 0)
        {
            if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementDetailWithGuid:requirementGuid])
            {
                xuQiuInfo = [Ty_News_busine_Order_DataBase share_Busine_DataBase].dataBaseXuQiu;

                ifDataLoad = YES;
                
                [self refreshHeaderView];
                [self loadFootViewButton];
                [self.workerOrder_TableView reloadData];
            }
            else
            {
                [self showNetMessageInView:self.view];
            }

        }
        else if(number == 1)
        {
            if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementDetailWithGuid:requirementGuid])
            {
                xuQiuInfo = [Ty_News_busine_Order_DataBase share_Busine_DataBase].dataBaseXuQiu;

                ifDataLoad = YES;
                
                //网络请求当前应征的人
                [worker_Order_Network_Busine freshPage];
                [worker_Order_Network_Busine checkYZPeopleWithRequirementGuid:requirementGuid];
                
                [self refreshHeaderView];
                [self loadFootViewButton];
                [self.workerOrder_TableView reloadData];
            }
            else
            {
                [self showToastMakeToast:@"加载失败,请重新加载" duration:1 position:@"center"];
            }
            
        }
        else
        {
            [self showNetMessageInView:self.view];
        }
    }
    else if(number <= 4)
    {//拒绝接单等
        if (number == 3)
        {
            [self performSelector:@selector(popToLastViewController) withObject:nil afterDelay:1.0];
            xuQiuInfo.requirement_Stage = @"4";
            [self showToastMakeToast:@"拒绝成功" duration:1 position:@"center"];
        }
        else
        {
            [self showToastMakeToast:@"拒绝失败,请稍后再试" duration:1 position:@"center"];
        }
    }
    else if(number == 100)
    {//标明fail
//        [self showToastMakeToast:@"网络请求失败,请重试" duration:1 position:@"center"];
        [self showNetMessageInView:self.view];
    }

}

#pragma mark tableview 的headerview
-(void)refreshHeaderView
{
    _requirementTopView = [[Ty_UserView_OrderView_RequirementDetail_TopView alloc]init];
    _requirementTopView.masterOrWorker = 1;
    
    _requirementTopView.topViewXuQiu =xuQiuInfo;
    
    [_requirementTopView loadCustomView];
    [_requirementTopView loadValues];
    _requirementTopView.semgentButton.delegate = self;
    
    
    int stageCode = [xuQiuInfo.requirement_Stage intValue];
    if (stageCode == 2 || stageCode == 3)
    {
        _requirementTopView.semgentButton.firstButton.hidden = NO;
        [_requirementTopView.semgentButton.firstButton setTitle:@"派遣员工信息" forState:UIControlStateNormal];
    }
    else
    {
        _requirementTopView.semgentButton.firstButton.hidden = NO;
        [_requirementTopView.semgentButton.firstButton setTitle:@"预约服务商" forState:UIControlStateNormal];
    }
    _requirementTopView.semgentButton.secondButton.hidden = NO;
    [_requirementTopView.semgentButton.secondButton setTitle:@"订单详细" forState:UIControlStateNormal];

    int evaluateState =[xuQiuInfo.evaluateStage intValue];
    
    
    if (2 == stageCode || 3 == stageCode)
    {
        if (evaluateState == 0||evaluateState == 1)//证明我没有评价
        {
        }
        else
        {
            _requirementTopView.semgentButton.thridButton.hidden = NO;
            [_requirementTopView.semgentButton.thridButton setTitle:@"订单评价" forState:UIControlStateNormal];
        }
    }
    self.workerOrder_TableView.tableHeaderView = _requirementTopView;
}

#pragma mark 打电话代理
-(void)phoneCallPressed
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",xuQiuInfo.contactPhone]];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
#pragma mark 私信按钮点击
-(void)workerReceivedOrderPrivateButtonPressed
{
    [self.naviGationController pushViewController:[worker_Order_Network_Busine privateButtonPressedandXuQiu:xuQiuInfo] animated:YES];
}
#pragma mark 返回上一个VC
-(void)popToLastViewController
{
    [self.naviGationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
