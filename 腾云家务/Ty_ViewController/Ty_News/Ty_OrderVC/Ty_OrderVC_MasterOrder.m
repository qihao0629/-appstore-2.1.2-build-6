//
//  Ty_OrderVC_MasterOrder.m
//  腾云家务
//
//  Created by lgs on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_MasterOrder.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_Order_Master_OrderCell.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_Order_EvaluateCell.h"
#import "Ty_Home_UserDetailVC.h"
#import "Ty_UPPayVC.h"
#import "Ty_OrderVC_Evaluate_Worker_Controller.h"
#import "Ty_Order_MasterLook_DetailCell.h"

@interface Ty_OrderVC_MasterOrder ()

@end

@implementation Ty_OrderVC_MasterOrder
@synthesize xuQiuInfo;
@synthesize masterOrder_TableView;
@synthesize requirementGuid;
@synthesize master_Order_Network_Busine;
//@synthesize payStage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_MasterOrder"];
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
    [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(footCenterButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    centerButton.exclusiveTouch = YES;
    
    centerButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [centerButtonLabel setBackgroundColor:[UIColor clearColor]];
    centerButtonLabel.textAlignment = NSTextAlignmentCenter;
    [centerButtonLabel setFont:FONT14_BOLDSYSTEM];
    [centerButton addSubview:centerButtonLabel];
    
    privateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateButton setFrame:CGRectMake(270, 0, 50, 49)];
    [privateButton setImage:[UIImage imageNamed:@"home_message_red"] forState:UIControlStateNormal];

    [privateButton addTarget:self action:@selector(masterOrderPrivateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    if ([xuQiuInfo.requirement_Stage intValue] == 1)
    {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok"] forState:UIControlStateNormal];
        centerButtonLabel.textColor = [UIColor redColor];
        centerButtonLabel.text = @"取消需求";
        [self.imageView_background addSubview:centerButton];
    }
    else if([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
    {
        if ([xuQiuInfo.isApply intValue] == 3)
        {//未支付
            centerButton.hidden = NO;
            centerButtonLabel.textColor = [UIColor whiteColor];
            centerButtonLabel.text = @"支付";
            [self.imageView_background addSubview:centerButton];
        }
        else
            centerButton.hidden = YES;
    }
    else
    {
        centerButton.hidden = YES;
    }
    
    [self.imageView_background addSubview:privateButton];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我发起的预约";
    
    master_Order_Network_Busine = [[Ty_News_Busine_Network alloc]init];
    master_Order_Network_Busine.delegate = self;
    
    [master_Order_Network_Busine freshData];
    
    if (!xuQiuInfo)
    {
        xuQiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
    }

    semgentButtonTag = 1;
    ifDataLoad = NO;
    
    self.masterOrder_TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 49) style:UITableViewStylePlain];
    [self.view setBackgroundColor:view_BackGroudColor];
    
    masterOrder_TableView.showsVerticalScrollIndicator = NO;//不显示滚动条
    masterOrder_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
    
    masterOrder_TableView.dataSource = self;
    masterOrder_TableView.delegate = self;
    
    [self.view addSubview:masterOrder_TableView];
    
    [master_Order_Network_Busine masterOrderCheckRequirementDetailAndRequirementGuid:requirementGuid];

    [self showLoadingInView:self.view];
}
#pragma mark semgentButton 即上面三个按钮的点击的代理
-(void)SemGentButtonAction:(id)sender
{
    if (semgentButtonTag != ((UIButton *)sender).tag)
    {
        semgentButtonTag =((UIButton *)sender).tag;
        [self.masterOrder_TableView reloadData];
    }
}

#pragma mark 中间按钮点击方法
-(void)footCenterButtonPressed
{
    if ([centerButtonLabel.text isEqualToString:@"取消需求"])
    {
        quitOrderAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要取消预约么,一旦取消将无法达成交易" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [quitOrderAlertView show];
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
    if (alertView == quitOrderAlertView)
    {
        switch (buttonIndex)
        {
            case 0:
                break;
            case 1:
                [self showProgressHUD:@"正在取消"];
                [master_Order_Network_Busine masterOrderCloseRequiremengAndRequirementGuid:requirementGuid];
                break;
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
    {//预约的服务商
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
        if(semgentButtonTag == 1)
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
                
                [customCell.priceLabel removeFromSuperview];
                [customCell.unitLabel removeFromSuperview];
                
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
                [customCell.employeePhoneButton addTarget:self action:@selector(employeePhoneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                [customCell.reminderLabel1 removeFromSuperview];
            }
            else if([xuQiuInfo.requirement_Stage intValue] == 7)
            {
                customCell.employeePhoneNumberLabel.text = [NSString stringWithFormat:@"商户联系电话:%@",xuQiuInfo.serverObject.companyPhoneNumber];
                [customCell addSubview:customCell.employeePhoneButton];
                [customCell.employeePhoneButton addTarget:self action:@selector(employeePhoneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                [customCell.reminderLabel1 removeFromSuperview];

//                customCell.reminderLabel1.text = @"请您耐心等待服务商派工,如有需要请拨打";
            }
            [customCell setHight];
            [customCell.reminderLabel2 removeFromSuperview];
            [customCell.servicePhoneButton setFrame:CGRectMake(15, 13, 192, 26)];
            [customCell.servicePhoneButton addTarget:self action:@selector(servieceButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            customCell.selectionStyle = UITableViewCellSelectionStyleGray;
            customCell.accessoryType = UITableViewCellAccessoryNone;
            
            return customCell;
        }
        else if(semgentButtonTag == 2)
        {
            NSLog(@"~~~~~~~~~~~~");
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
        return 148;

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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (semgentButtonTag == 1)
    {
        Ty_Home_UserDetailVC * userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
        [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeRequirement];
        
        userDetailVC.userDetailBusine.userService = xuQiuInfo.serverObject;
        userDetailVC.userDetailBusine._selectWorkGuid = xuQiuInfo.workGuid;
        userDetailVC.userDetailBusine._selectWorkName = xuQiuInfo.workName;
        
        [self.naviGationController pushViewController:userDetailVC animated:YES];
    }
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
                [self.masterOrder_TableView reloadData];
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
                /*
                //网络请求当前应征的人
                [master_Order_Network_Busine freshPage];
                [master_Order_Network_Busine checkYZPeopleWithRequirementGuid:requirementGuid];
                */
                
                [self refreshHeaderView];
                [self loadFootViewButton];
                [self.masterOrder_TableView reloadData];
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
            
            [self performSelector:@selector(masterOrderPopToLastViewController) withObject:nil afterDelay:1.0];

        }
        else
        {
            [self showToastMakeToast:@"关闭失败" duration:1 position:@"center"];
        }
    }
    else if(number == 100)
    {//标明fail
        [self showNetMessageInView:self.view];

//        [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];
    }

}
#pragma mark 重新加载loading
-(void)loading
{
    [self hideNetMessageView];
    [self showLoadingInView:self.view];
    [master_Order_Network_Busine masterOrderCheckRequirementDetailAndRequirementGuid:requirementGuid];
}

#pragma mark 刷新tableView 的headerView
-(void)refreshHeaderView
{
    _requirementTopView = [[Ty_UserView_OrderView_RequirementDetail_TopView alloc]init];
    _requirementTopView.masterOrWorker = 0;
    
    _requirementTopView.topViewXuQiu =xuQiuInfo;
    
    [_requirementTopView loadCustomView];
    [_requirementTopView loadValues];
    _requirementTopView.semgentButton.delegate = self;
    
    _requirementTopView.semgentButton.firstButton.hidden = NO;
    [_requirementTopView.semgentButton.firstButton setTitle:@"预约服务商" forState:UIControlStateNormal];
    _requirementTopView.semgentButton.secondButton.hidden = NO;
    [_requirementTopView.semgentButton.secondButton setTitle:@"订单详细" forState:UIControlStateNormal];
    
    self.masterOrder_TableView.tableHeaderView = _requirementTopView;
    
    int stageCode = [xuQiuInfo.requirement_Stage intValue];
    int evaluateState =[xuQiuInfo.evaluateStage intValue];
    
    
    if (2 == stageCode || stageCode == 3)
    {
        if (evaluateState == 0||evaluateState == 2)//证明我没有评价
        {
        }
        else
        {
            _requirementTopView.semgentButton.thridButton.hidden = NO;
            [_requirementTopView.semgentButton.thridButton setTitle:@"订单评价" forState:UIControlStateNormal];
        }
    }
}
#pragma mark 评价按钮点击
-(void)evaluateWorkerButtonPressed
{
    Ty_OrderVC_Evaluate_Worker_Controller * evaluateWorkerVC = [[Ty_OrderVC_Evaluate_Worker_Controller alloc]init];
    evaluateWorkerVC.requirementGuidStr = xuQiuInfo.requirementGuid;
    evaluateWorkerVC.workerObject = xuQiuInfo.serverObject;
    [self.naviGationController pushViewController:evaluateWorkerVC animated:YES];
}
#pragma mark 员工电话按钮或者中介电话按钮点击
-(void)employeePhoneButtonPressed
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
-(void)masterOrderPrivateButtonPressed
{
    [self.naviGationController pushViewController:[master_Order_Network_Busine privateButtonPressedandXuQiu:xuQiuInfo] animated:YES];
}
#pragma mark 返回上一个VC
-(void)masterOrderPopToLastViewController
{
    [self.naviGationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
