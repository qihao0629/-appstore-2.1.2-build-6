//
//  Ty_OrderVC_MasterPublish.m
//  腾云家务
//
//  Created by lgs on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_MasterPublish.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_Order_EvaluateCell.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_Order_NoBodyYZCell.h"
#import "Ty_Order_Master_OrderCell.h"
#import "Ty_OrderVC_Evaluate_Worker_Controller.h"
#import "Ty_UPPayVC.h"//支付界面
#import "MessageVC.h"//私信界面
#import "Ty_Home_UserDetailVC.h"
#import "Ty_Order_MasterLook_DetailCell.h"


@interface Ty_OrderVC_MasterPublish ()

@end

@implementation Ty_OrderVC_MasterPublish
@synthesize xuQiuInfo;
@synthesize requirementGuid;
@synthesize master_Order_Network_Busine;
@synthesize masterPublish_TableView;
//@synthesize payStage;
@synthesize _isRefreshing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_MasterPublish"];
    }
    return self;
}
/*
 实例化底部的按钮
 */
- (void)loadFootViewButton
{
    centerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [centerButton setFrame:CGRectMake(110, 10, 100, 30)];
    centerButton.layer.cornerRadius =5;
    centerButton.layer.masksToBounds = YES;
    [centerButton addTarget:self action:@selector(publishCenterButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    centerButton.exclusiveTouch = YES;
    
    centerButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [centerButtonLabel setBackgroundColor:[UIColor clearColor]];
    centerButtonLabel.textAlignment = NSTextAlignmentCenter;
    [centerButtonLabel setFont:FONT14_BOLDSYSTEM];
    [centerButton addSubview:centerButtonLabel];
    
    privateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateButton setFrame:CGRectMake(270, 0, 50, 49)];
    [privateButton setImage:[UIImage imageNamed:@"home_message_red"] forState:UIControlStateNormal];
    
    [privateButton addTarget:self action:@selector(masterPublishPrivateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
    if ([xuQiuInfo.requirement_Stage intValue] == 0 || [xuQiuInfo.requirement_Stage intValue] == 6)
    {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok"] forState:UIControlStateNormal];
        centerButtonLabel.text = @"取消需求";
        centerButtonLabel.textColor = [UIColor redColor];

        [self.imageView_background addSubview:centerButton];
    }
    else if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
    {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
        
        if ([xuQiuInfo.isApply intValue] == 3)
        {//未支付
            centerButton.hidden = NO;
            centerButtonLabel.textColor = [UIColor whiteColor];
            centerButtonLabel.text = @"支付";
            [self.imageView_background addSubview:centerButton];
        }
        else
            centerButton.hidden = YES;
        
        [self.imageView_background addSubview:privateButton];
    }
    else if ([xuQiuInfo.requirement_Stage intValue] == 7)
    {
        [self.imageView_background addSubview:privateButton];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"抢单详细";
    
    semgentButtonTag = 1;
    ifDataLoad = NO;
    _isRefreshing = YES;
    surePersonTag = -1;
    
    master_Order_Network_Busine = [[Ty_News_Busine_Network alloc]init];
    master_Order_Network_Busine.delegate = self;
    
    [master_Order_Network_Busine freshData];
    
    if (!xuQiuInfo)
    {
        xuQiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
    }
    hirePersonObject = [[Ty_Model_ServiceObject alloc]init];
    
    self.masterPublish_TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 49) style:UITableViewStylePlain];
    [self.masterPublish_TableView setBackgroundColor:view_BackGroudColor];
    masterPublish_TableView.showsVerticalScrollIndicator = NO;//不显示滚动条
    masterPublish_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
    
    masterPublish_TableView.dataSource = self;
    masterPublish_TableView.delegate = self;
    
    [self.view addSubview:masterPublish_TableView];
    
    [master_Order_Network_Busine masterPublishCheckRequirementDetailAndRequirementGuid:requirementGuid];
    
//    [self loadBackButton];
    [self showLoadingInView:self.view];
    //定义上拉刷新
    if (_refreshLoadView == nil)
    {
        _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        _refreshLoadView._messageLabel.text = @"正在加载...";
    }

}

#pragma mark 加载返回按钮

-(void)loadBackButton
{
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:JWImageName(@"back") forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 45)];
//    [self.naviGationController.leftBarButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(masterPublishBackToIndex) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
}
#pragma mark 返回上一个界面
-(void)masterPublishBackToIndex
{
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark semgentButton 代理
-(void)SemGentButtonAction:(id)sender
{
    if (semgentButtonTag != ((UIButton *)sender).tag)
    {
        semgentButtonTag =((UIButton *)sender).tag;
        [self.masterPublish_TableView reloadData];
    }
}

#pragma mark 中间按钮点击
-(void)publishCenterButtonPressed
{
    if ([centerButtonLabel.text isEqualToString:@"取消需求"])
    {
        quitPublishAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要取消您发布的需求么,一旦取消将无法达成交易" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [quitPublishAlertView show];
    }
    else if ([centerButtonLabel.text isEqualToString:@"支付"])
    {
        Ty_UPPayVC * uppayVC = [[Ty_UPPayVC alloc]init];
        uppayVC.xuqiuInfo = xuQiuInfo;
        
        [self.naviGationController pushViewController:uppayVC animated:YES];
    }
}

#pragma mark alertView 提示框的代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == quitPublishAlertView)
    {
        switch (buttonIndex)
        {
            case 0:
                break;
            case 1:
                [self showProgressHUD:@"正在取消"];
                [master_Order_Network_Busine masterPublishCloseRequiremengAndRequirementGuid:requirementGuid];
            default:
                break;
        }
    }
    else if (alertView == surePersonAlertView)
    {
        switch (buttonIndex)
        {
            case 0:
                break;
            case 1:
                [self showProgressHUD:@"正在确定人选"];
                [master_Order_Network_Busine masterPublishSurePersonWithRequirementGuid:requirementGuid andSurePersonGuid:[[master_Order_Network_Busine.serviceObjectArray objectAtIndex:surePersonTag] companiesGuid]];
            default:
                break;
        }
    }
}

#pragma mark tableview 的数据源代理
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
            if ([xuQiuInfo.requirement_Stage intValue] == 6)
            {
                return [master_Order_Network_Busine.serviceObjectArray count];
            }
            else
                return 1;
        }
        else
            return 0;
    }
    else
    {
        if (ifDataLoad)
        {
            return 1;
        }
        else
            return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ifDataLoad == YES)
    {
        if (semgentButtonTag == 1)
        {
            if([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3 || [xuQiuInfo.requirement_Stage intValue] == 7)
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
                            customCell.evaluateButton.hidden = NO;
                            customCell.evaluateButton.userInteractionEnabled = YES;
                            [customCell.evaluateButton setImage:[UIImage imageNamed:@"determine"] forState:UIControlStateNormal];
                            customCell.buttonTitleLabel.text = @"我要评价";
                            [customCell.evaluateButton addTarget:self action:@selector(evaluateWorkerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            customCell.evaluateButton.hidden = YES;
                            [customCell.evaluateButton setImage:[UIImage imageNamed:@"canNotPressed"] forState:UIControlStateNormal];
                            customCell.buttonTitleLabel.text = @"已评价";
                            customCell.evaluateButton.userInteractionEnabled = NO;
                        }
                    }
                    else
                    {
                        customCell.evaluateButton.hidden = YES;
                    }
                    
                }
                if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
                {//显示员工的电话号码
                    if ([xuQiuInfo.serverObject.phoneNumber isEqualToString:@""])
                    {
                        customCell.employeePhoneNumberLabel.text = [NSString stringWithFormat:@"商户联系电话:%@",xuQiuInfo.serverObject.companyPhoneNumber];
                    }
                    else
                    {
                        customCell.employeePhoneNumberLabel.text = [NSString stringWithFormat:@"服务人员电话:%@",xuQiuInfo.serverObject.phoneNumber];
                    }
                    
                    [customCell addSubview:customCell.employeePhoneButton];
                    [customCell.employeePhoneButton addTarget:self action:@selector(employeePhoneButtonPress) forControlEvents:UIControlEventTouchUpInside];
                    [customCell.reminderLabel1 removeFromSuperview];
                }
                else if([xuQiuInfo.requirement_Stage intValue] == 7)
                {
                    customCell.employeePhoneNumberLabel.text = [NSString stringWithFormat:@"商户联系电话:%@",xuQiuInfo.serverObject.companyPhoneNumber];
                    [customCell addSubview:customCell.employeePhoneButton];
                    [customCell.employeePhoneButton addTarget:self action:@selector(employeePhoneButtonPress) forControlEvents:UIControlEventTouchUpInside];
                    
                    [customCell.reminderLabel1 removeFromSuperview];
                }
                
                [customCell setHight];
                //                [customCell.reminderLabel1 removeFromSuperview];
                [customCell.reminderLabel2 removeFromSuperview];
                [customCell.servicePhoneButton setFrame:CGRectMake(15, 13, 192, 26)];
                
                [customCell.servicePhoneButton addTarget:self action:@selector(servieceButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                customCell.selectionStyle = UITableViewCellSelectionStyleGray;
                customCell.accessoryType = UITableViewCellAccessoryNone;
                
                return customCell;
            }
            else
            {
                if ([master_Order_Network_Busine.serviceObjectArray count] == 0)
                {//0个人应征
                    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell2%d%d", [indexPath section], [indexPath row]];
                    Ty_Order_NoBodyYZCell * nobodyCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (nobodyCell == nil)
                    {
                        nobodyCell = [[Ty_Order_NoBodyYZCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
                    }
                    if ([xuQiuInfo.requirement_Stage intValue] != 0)
                    {//过期或者取消等
                        nobodyCell.firstRemindLabel.text = @"您发布的需求已经交易关闭";
                        nobodyCell.firstRemindLabel.textColor = [UIColor redColor];
                    }
                    nobodyCell.accessoryType =UITableViewCellAccessoryNone;
                    nobodyCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return nobodyCell;
                }
                else
                {
                    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell1%d%d", [indexPath section], [indexPath row]];
                    MasterLookYZPeopleCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (customCell == nil)
                    {
                        customCell = [[MasterLookYZPeopleCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
                        customCell.serviceObject = [master_Order_Network_Busine.serviceObjectArray objectAtIndex:indexPath.row];
                        
                        [customCell loadCustom];
                        
                        customCell.privateLetterButton.tag = 1000+indexPath.row;
                        customCell.determineButton.tag = 2000+indexPath.row;
                        
                        [customCell loadValues];
                        Ty_News_Busine_HandlePlist * tempPlistBusine = [[Ty_News_Busine_HandlePlist alloc]init];
                        
                        NSString * unitString = [NSString stringWithFormat:@"/%@",[tempPlistBusine findWorkUnitAndWorkName:xuQiuInfo.workName]];
                        tempPlistBusine = nil;
                        
                        customCell.unitLabel.text = unitString;
                        
                    }
                    [customCell.privateLetterButton addTarget:self action:@selector(masterLookYZPrivateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    
                    customCell.masterDeterminePersonButton = self;
                    [customCell setHight];
                    
                    customCell.accessoryType = UITableViewCellAccessoryNone;
                    customCell.selectionStyle = UITableViewCellSelectionStyleGray;
                    return customCell;
                }
            }
        }
        else if(semgentButtonTag == 2)
        {
            NSString *CellIdentifier2 = [NSString stringWithFormat:@"OrderDdetaliCell2%d%d", [indexPath section], [indexPath row]];
            Ty_Order_MasterLook_DetailCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (customCell == nil)
            {
                customCell = [[Ty_Order_MasterLook_DetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2];
                customCell.masterLookDetailXuQiu = xuQiuInfo;
            }
            [customCell loadUI];
            [customCell loadValues];
            
            [customCell setHight];
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
                customCell.userType = @"0";
                [customCell loadValue];
            }
            customCell.accessoryType = UITableViewCellAccessoryNone;
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return customCell;
        }

    }
    else
        return nil;
}

#pragma mark tableview 的代理 点击
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (semgentButtonTag == 1)
    {
        if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3 || [xuQiuInfo.requirement_Stage intValue] == 7)
        {//确定某个员工或者某个公司
            return 148;
        }
        else if([xuQiuInfo.requirement_Stage intValue] == 6)
        {//有人应征
            if ([master_Order_Network_Busine.serviceObjectArray count] != 0)
            {
                return 95;
            }
            else
                return 186 - 72;
        }
        else
        {
            return 186 - 72;
        }
    }
    else if(semgentButtonTag == 2)
    {
        UITableViewCell* cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"cell的高度,%f",cell.frame.size.height);
        return cell.frame.size.height;

    }
    else
    {
        UITableViewCell* cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (semgentButtonTag == 1)
    {
        if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3 || [xuQiuInfo.requirement_Stage intValue] == 7)
        {
            Ty_Home_UserDetailVC * userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
            [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeRequirement];
            
            userDetailVC.userDetailBusine.userService = xuQiuInfo.serverObject;
            userDetailVC.userDetailBusine._selectWorkGuid = xuQiuInfo.workGuid;
            userDetailVC.userDetailBusine._selectWorkName = xuQiuInfo.workName;
            
            [self.naviGationController pushViewController:userDetailVC animated:YES];
        }
        else if([xuQiuInfo.requirement_Stage intValue] == 6)
        {
            Ty_Home_UserDetailVC * userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
            [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeRequirement];
            
            userDetailVC.userDetailBusine.userService = [master_Order_Network_Busine.serviceObjectArray objectAtIndex:indexPath.row];
            userDetailVC.userDetailBusine._selectWorkGuid = xuQiuInfo.workGuid;
            userDetailVC.userDetailBusine._selectWorkName = xuQiuInfo.workName;
            
            [self.naviGationController pushViewController:userDetailVC animated:YES];
        }
    }

}
#pragma mark 上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([xuQiuInfo.requirement_Stage intValue] == 6 && semgentButtonTag == 1)
    {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView != nil)
        {
            NSLog(@" -- 我是上拉刷新");
            if (!_isRefreshing )
            {
                [_refreshLoadView._netMind startAnimating];
                _refreshLoadView._messageLabel.text = @"正在加载...";
                _isRefreshing = YES;
                
                [master_Order_Network_Busine checkYZPeopleWithRequirementGuid:requirementGuid];
            }
        }
    }
}


#pragma mark 刷新tableview 的headView
-(void)refreshHeaderView
{
    _requirementTopView = [[Ty_UserView_OrderView_RequirementDetail_TopView alloc]init];
    _requirementTopView.masterOrWorker = 0;
    
    _requirementTopView.topViewXuQiu =xuQiuInfo;
    
    [_requirementTopView loadCustomView];
    [_requirementTopView loadValues];
    _requirementTopView.semgentButton.delegate = self;
    

    int stageCode = [xuQiuInfo.requirement_Stage intValue];
    if (stageCode == 2 || stageCode == 3)
    {
        _requirementTopView.semgentButton.firstButton.hidden = NO;
        [_requirementTopView.semgentButton.firstButton setTitle:@"服务员工信息" forState:UIControlStateNormal];
    }
    else if(stageCode == 7)
    {
        _requirementTopView.semgentButton.firstButton.hidden = NO;
        [_requirementTopView.semgentButton.firstButton setTitle:@"服务商信息" forState:UIControlStateNormal];
    }
    else
    {
        _requirementTopView.semgentButton.firstButton.hidden = NO;
        [_requirementTopView.semgentButton.firstButton setTitle:@"候选服务商" forState:UIControlStateNormal];
    }
    
    _requirementTopView.semgentButton.secondButton.hidden = NO;
    [_requirementTopView.semgentButton.secondButton setTitle:@"订单详细" forState:UIControlStateNormal];

    
    self.masterPublish_TableView.tableHeaderView = _requirementTopView;

    int evaluateState =[xuQiuInfo.evaluateStage intValue];
    
    
    if (2 == stageCode || 3 == stageCode)
    {
        if (evaluateState == 0||evaluateState == 2)//证明我没有评价
        {
        }
        else if(evaluateState == 1)
        {
            _requirementTopView.semgentButton.thridButton.hidden = NO;
            [_requirementTopView.semgentButton.thridButton setTitle:@"订单评价" forState:UIControlStateNormal];
        }
        else
        {
            _requirementTopView.semgentButton.thridButton.hidden = NO;
            [_requirementTopView.semgentButton.thridButton setTitle:@"订单评价" forState:UIControlStateNormal];
        }
    }
}


#pragma mark 重新加载的代理
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    [master_Order_Network_Busine masterPublishCheckRequirementDetailAndRequirementGuid:requirementGuid];
}
#pragma mark 应征的人的私信按钮点击
-(void)masterLookYZPrivateButtonPressed:(id)sender
{
    int buttonTag = ((UIButton *)sender).tag- 1000;
    
    MessageVC * messageVC = [[MessageVC alloc]init];
    Ty_Model_ServiceObject * messageToServiceObject = [[Ty_Model_ServiceObject alloc]init];
    messageToServiceObject = [master_Order_Network_Busine.serviceObjectArray objectAtIndex:buttonTag];
    
    if ([messageToServiceObject.userType intValue] == 0 || [messageToServiceObject.userType intValue] == 1)
    {
        messageVC.contactGuid=messageToServiceObject.companiesGuid;
        messageVC.contactName=messageToServiceObject.companyUserName;
        messageVC.contactAnnear = messageToServiceObject.companyUserAnnear;
        messageVC.contactRealName=messageToServiceObject.respectiveCompanies;
        messageVC.contactType=0;
        messageVC.contactSex= 1;
    }
    else
    {
        messageVC.contactGuid=messageToServiceObject.userGuid;
        messageVC.contactName=messageToServiceObject.userName;
        NSLog(@"应征的人是一个个人!!!!!!!!!!!!");
        messageVC.contactAnnear = messageToServiceObject.numTemper;
        messageVC.contactRealName=messageToServiceObject.userRealName;
        messageVC.contactType=1;
        messageVC.contactSex=[messageToServiceObject.sex intValue];
    }
    [self.naviGationController pushViewController:messageVC animated:YES];
}
#pragma mark 确定人的按钮的对勾
-(void)masterDeterminePersonButtonPressed:(id)sender
{
    surePersonTag = ((UIButton *)sender).tag -2000;
    surePersonAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定让他来给你服务么，一旦达成交易，不可取消。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [surePersonAlertView show];
}
#pragma mark 评价按钮点击
-(void)evaluateWorkerButtonPressed
{
    Ty_OrderVC_Evaluate_Worker_Controller * evaluateWorkerVC = [[Ty_OrderVC_Evaluate_Worker_Controller alloc]init];
    evaluateWorkerVC.requirementGuidStr = xuQiuInfo.requirementGuid;
    evaluateWorkerVC.workerObject = xuQiuInfo.serverObject;
    [self.naviGationController pushViewController:evaluateWorkerVC animated:YES];
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
#pragma mark 员工电话按钮或者中介电话按钮点击
-(void)employeePhoneButtonPress
{
    NSURL *phoneURL;
    if ([xuQiuInfo.serverObject.phoneNumber isEqualToString:@""])
    {
        phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",xuQiuInfo.serverObject.companyPhoneNumber]];
    }
    else
    {
        phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",xuQiuInfo.serverObject.phoneNumber]];
    }
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}
#pragma mark 客服电话按钮的点击
-(void)servieceButtonPressed
{
    NSURL *phoneURL = [NSURL URLWithString:@"tel:400-004-9121"];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
#pragma mark 私信按钮点击
-(void)masterPublishPrivateButtonPressed
{
    [self.naviGationController pushViewController:[master_Order_Network_Busine privateButtonPressedandXuQiu:xuQiuInfo] animated:YES];
}
#pragma mark 基类中通知的回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    [self hideProgressHUD];
    int number = [[[_notification object] objectForKey:@"number"] intValue];
    if (number <=2)
    {
        if (number == 0)
        {
            if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementDetailWithGuid:requirementGuid])
            {
                xuQiuInfo = [Ty_News_busine_Order_DataBase share_Busine_DataBase].dataBaseXuQiu;
                
                ifDataLoad = YES;
                
                [self refreshHeaderView];
                [self loadFootViewButton];
                [self.masterPublish_TableView reloadData];
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
                
                if ([xuQiuInfo.requirement_Stage intValue] == 6)
                {
                    //网络请求当前应征的人
                    [master_Order_Network_Busine freshPage];
                    [master_Order_Network_Busine checkYZPeopleWithRequirementGuid:requirementGuid];
                }
                [self refreshHeaderView];
                [self loadFootViewButton];
                [self.masterPublish_TableView reloadData];
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
    {
        if (number == 3)
        {
            [self showToastMakeToast:@"关闭成功" duration:1 position:@"center"];
            xuQiuInfo.requirement_Stage = @"4";
            [self performSelector:@selector(masterPublishBackToIndex) withObject:nil afterDelay:1.0];
        }
        else
        {
            [self showToastMakeToast:@"关闭失败" duration:1 position:@"center"];
        }
    }
    else if(number <= 7)
    {
        _isRefreshing = NO;
        
        if (number == 5)
        {
            [self.masterPublish_TableView reloadData];
        }
        else if (number == 6)
        {
            [self.masterPublish_TableView reloadData];
        }
        else
        {
            [self showToastMakeToast:@"网络加载失败" duration:1 position:@"center"];
        }
    }
    else if (number <= 9)
    {
        if (number == 8)
        {
            [self showToastMakeToast:@"确定成功,等待对方派工" duration:1 position:@"center"];
            xuQiuInfo.requirement_Stage = @"7";
            [self performSelector:@selector(masterPublishBackToIndex) withObject:nil afterDelay:1.0];
        }
        else
        {
            [self showToastMakeToast:@"确定人选失败" duration:1 position:@"center"];
        }
    }
    else if(number == 100)
    {//标明fail
        [self showNetMessageInView:self.view];
//        [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
