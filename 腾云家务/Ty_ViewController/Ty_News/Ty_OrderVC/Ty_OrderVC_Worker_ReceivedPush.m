//
//  Ty_OrderVC_Worker_ReceivedPush.m
//  腾云家务
//
//  Created by lgs on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Worker_ReceivedPush.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_Order_Master_OrderCell.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_Order_EvaluateCell.h"
#import "Ty_OrderVC_MyYZDataCell.h"
#import "Ty_OrderVC_YZController.h"
#import "Ty_OrderVC_SendEmployee_Controller.h"
#import "Ty_OrderVC_Evaluate_Master_Controller.h"
#import "Ty_OrderVC_MasterOrder.h"

#define grayWordColor [UIColor colorWithRed:119/255.0 green:119/255.0  blue:119/255.0  alpha:1]

@interface Ty_OrderVC_Worker_ReceivedPush ()

@end

@implementation Ty_OrderVC_Worker_ReceivedPush
@synthesize xuQiuInfo;
@synthesize workerReceivedPush_TableView;
@synthesize worker_ReceivedPush_Network_Busine;
@synthesize requirementGuid;
//@synthesize payStage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_Worker_ReceivedPush"];
    }
    return self;
}
/*
 实例化底部按钮
 */
-(void)loadFootViewButton
{
    centerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [centerButton setFrame:CGRectMake(110, 10, 100, 30)];
    centerButton.layer.cornerRadius =3;
    centerButton.layer.masksToBounds = YES;
    [centerButton addTarget:self action:@selector(receivedPushCenterButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    centerButton.exclusiveTouch = YES;
    
    centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [centerLabel setBackgroundColor:[UIColor clearColor]];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    [centerLabel setFont:FONT14_BOLDSYSTEM];
    [centerButton addSubview:centerLabel];
    
    [self.imageView_background addSubview:centerButton];
    
    privateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [privateButton setFrame:CGRectMake(270, 0, 50, 49)];
    [privateButton setImage:[UIImage imageNamed:@"home_message_red"] forState:UIControlStateNormal];
    
    [privateButton addTarget:self action:@selector(workReceivedPushPrivateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageView_background addSubview:privateButton];

    if ([xuQiuInfo.requirement_Stage intValue] == 0 || [xuQiuInfo.requirement_Stage intValue] == 6)
    {
        if ([xuQiuInfo.candidateStatus intValue] == 0)
        {
            centerButton.hidden = NO;
            [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
            centerLabel.text = @"我要应征";
            centerLabel.textColor = [UIColor whiteColor];
        }
        else
        {
            centerButton.hidden = NO;

            [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok"] forState:UIControlStateNormal];
            centerLabel.textColor = [UIColor redColor];
            centerLabel.text = @"取消应征";
        }
    }
    else if([xuQiuInfo.requirement_Stage intValue] == 7)
    {
        if (![xuQiuInfo.serverObject.companiesGuid isEqualToString:@""])
        {
            centerButton.hidden = NO;
            
            centerLabel.text = @"派工";
            centerLabel.textColor = [UIColor whiteColor];
            [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
            [self.imageView_background addSubview:centerButton];
        }
        else
        {
            centerButton.hidden = YES;
        }
    }
    else if([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
    {//已派工或者已完成
        if (![xuQiuInfo.serverObject.companiesGuid isEqualToString:@""])
        {
            if ([xuQiuInfo.evaluateStage intValue] == 1 || [xuQiuInfo.evaluateStage intValue] == 0)
            {
                centerButton.hidden = NO;
                
                centerLabel.text = @"评价";
                centerLabel.textColor = [UIColor redColor];
                [centerButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok"] forState:UIControlStateNormal];
                [self.imageView_background addSubview:centerButton];
            }
            else
                centerButton.hidden = YES;
        }
        else
        {
            centerButton.hidden = YES;
        }
        
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"抢单详情";
    
    worker_ReceivedPush_Network_Busine = [[Ty_News_Busine_Network alloc]init];
    worker_ReceivedPush_Network_Busine.delegate = self;
    
    [worker_ReceivedPush_Network_Busine freshData];
    if (!xuQiuInfo)
    {
        xuQiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
    }
    myYZDataServiceObject = [[Ty_Model_ServiceObject alloc]init];
    
    myYZDataLoad = NO;
    semgentButtonTag = 1;
    ifDataLoad = NO;
    
    self.workerReceivedPush_TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 49) style:UITableViewStylePlain];
    [self.workerReceivedPush_TableView setBackgroundColor:view_BackGroudColor];
    
    workerReceivedPush_TableView.showsVerticalScrollIndicator = NO;//不显示滚动条
    workerReceivedPush_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//无分割线
    
    workerReceivedPush_TableView.dataSource = self;
    workerReceivedPush_TableView.delegate = self;
    
    [self.view addSubview:workerReceivedPush_TableView];
    
    [worker_ReceivedPush_Network_Busine workerPublishCheckRequirementDetailAndRequirementGuid:requirementGuid];
    
    [self showLoadingInView:self.view];

}

#pragma mark semgentButton headerView 三个按钮点击代理
-(void)SemGentButtonAction:(id)sender
{
    if (semgentButtonTag != ((UIButton *)sender).tag)
    {
        semgentButtonTag =((UIButton *)sender).tag;
        [self.workerReceivedPush_TableView reloadData];
    }
}

#pragma mark 底部按钮点击触发方法
-(void)receivedPushCenterButtonPressed
{
    if ([centerLabel.text isEqualToString:@"我要应征"])
    {
        Ty_OrderVC_YZController * YZVC = [[Ty_OrderVC_YZController alloc]init];
        YZVC.YZxuQiu = xuQiuInfo;
        
        YZVC.requirementGuidStr = xuQiuInfo.requirementGuid;
        YZVC.workName = xuQiuInfo.workName;
        
        [self.naviGationController pushViewController:YZVC animated:YES];
    }
    else if([centerLabel.text isEqualToString:@"取消应征"])
    {
        cancleYZAlertView =  [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要取消应征么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [cancleYZAlertView show];
    }
    else if ([centerLabel.text isEqualToString:@"派工"])
    {
        Ty_OrderVC_SendEmployee_Controller * senderEmployeeVC = [[Ty_OrderVC_SendEmployee_Controller alloc]init];
        senderEmployeeVC.ifHaveWishPerson = NO;
        senderEmployeeVC._workGuid = xuQiuInfo.workGuid;
        senderEmployeeVC._workName = xuQiuInfo.workName;
        
        senderEmployeeVC.requirementString = xuQiuInfo.requirementGuid;
        
        [self.naviGationController pushViewController:senderEmployeeVC animated:YES];
    }
    else
    {//评价
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

#pragma mark alertView 提示框代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == cancleYZAlertView)
    {
        switch (buttonIndex)
        {
            case 0:
                break;
            case 1:
                [self showProgressHUD:@"正在取消"];
                [worker_ReceivedPush_Network_Busine workerQuitYZRequirementWithRequirementGuid:requirementGuid];
                break;
            default:
                break;
        }

    }
}
#pragma mark tableview数据代理

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
            if ([xuQiuInfo.candidateStatus intValue] == 0)
            {
                return 1;
            }
            else
            {
                if ([xuQiuInfo.requirement_Stage intValue] == 7 || [xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
                {
                    return 1;
                }
                else
                {
                    if (myYZDataLoad == YES)
                    {//我应征的信息回来了
                        return 1;
                    }
                    else
                        return 0;
                }
            }
            
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
            if ([xuQiuInfo.candidateStatus intValue] == 0)
            {//没有应征的话，只显示订单详细
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
                if ([xuQiuInfo.requirement_Stage intValue] == 7 || [xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
                {
                    if ([xuQiuInfo.serverObject.companiesGuid isEqualToString:@""])
                    {
                        NSString *CellIdentifier2 = [NSString stringWithFormat:@"OrderDdetaliCell1%d%d", [indexPath section], [indexPath row]];
                        Ty_OrderVC_MyYZDataCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
                        if (customCell == nil)
                        {
                            customCell = [[Ty_OrderVC_MyYZDataCell alloc]init];
                            [customCell.headImageView setImageWithURL:[NSURL URLWithString:myYZDataServiceObject.companyPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
                            customCell.workerNameLabel.text = myYZDataServiceObject.respectiveCompanies;
                            [customCell.customStar setCustomStarNumber:[myYZDataServiceObject.evaluate intValue]];
                            customCell.serviceTimeLabel.text =[NSString stringWithFormat:@"%@人预约",myYZDataServiceObject.serviceNumber];
                            customCell.YZRemarkLabel.text = [NSString stringWithFormat:@"备注:%@",myYZDataServiceObject.YZRemark];
                            customCell.YZtimeLabel.text = [NSString stringWithFormat:@"应征时间:%@",myYZDataServiceObject.YZTime];
                            
                            [customCell.reminderLabel1 initWithStratString:@"雇主确定了其他服务商,请您再接再厉!" startColor:grayWordColor startFont:FONT13_SYSTEM centerString:@"" centerColor:grayWordColor centerFont:FONT13_SYSTEM endString:@"" endColor:grayWordColor endFont:FONT13_SYSTEM];
                            
                            customCell.priceLabel.text = [NSString stringWithFormat:@"￥%@",myYZDataServiceObject.YZQuote];
                            
                            //评价按钮处理
                            if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
                            {
                                if ([xuQiuInfo.evaluateStage intValue] == 1 || [xuQiuInfo.evaluateStage intValue] == 3)
                                {//没有评价
                                    customCell.evaluateButton.hidden = YES;
                                    
                                    [customCell.evaluateButton setBackgroundImage:[UIImage imageNamed:@"canNotPressed"] forState:UIControlStateNormal];
                                    customCell.evaluateButton.userInteractionEnabled = NO;
                                    
                                    customCell.evaluateLabel.text = @"已评";
                                }
                                else
                                {
                                    customCell.evaluateButton.hidden = YES;
                                }
                            }
                            else
                            {
                                customCell.evaluateButton.hidden = YES;
                            }
                            
                            Ty_News_Busine_HandlePlist * tempPlistBusine = [[Ty_News_Busine_HandlePlist alloc]init];
                            
                            NSString * unitString = [NSString stringWithFormat:@"/%@",[tempPlistBusine findWorkUnitAndWorkName:xuQiuInfo.workName]];
                            customCell.unitLabel.text = unitString;
                            tempPlistBusine = nil;
                        }
                        customCell.accessoryType = UITableViewCellAccessoryNone;
                        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        return customCell;
                    }
                    else
                    {
                        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell1%d%d", [indexPath section], [indexPath row]];
                        
                        Ty_Order_Master_OrderCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (customCell == nil)
                        {
                            customCell = [[Ty_Order_Master_OrderCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
                            
                            if ([xuQiuInfo.requirement_Stage intValue] == 7)
                            {
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
                            else
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
                            
                            customCell.evaluateButton.hidden = YES;
                            customCell.reminderLabel1.text= @"贵公司已经被雇主确定,请尽快联系雇主。";
                            customCell.reminderLabel2.text = @"雇主的联系方式请您查看“订单详细”。";
                            customCell.reminderLabel2.textColor = [UIColor redColor];
                            
                            customCell.servicePhoneButton.hidden = YES;
                            
                        }
                        [customCell setHight];
                        
                        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        customCell.accessoryType = UITableViewCellAccessoryNone;
                        
                        return customCell;
                    }
                }
                else
                {
                    if (myYZDataLoad)
                    {
                        NSString *CellIdentifier2 = [NSString stringWithFormat:@"OrderDdetaliCell1%d%d", [indexPath section], [indexPath row]];
                        Ty_OrderVC_MyYZDataCell * customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
                        if (customCell == nil)
                        {
                            customCell = [[Ty_OrderVC_MyYZDataCell alloc]init];
                            [customCell.headImageView setImageWithURL:[NSURL URLWithString:myYZDataServiceObject.companyPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
                            customCell.workerNameLabel.text = myYZDataServiceObject.respectiveCompanies;
                            [customCell.customStar setCustomStarNumber:[myYZDataServiceObject.evaluate intValue]];
                            customCell.serviceTimeLabel.text =[NSString stringWithFormat:@"%@人预约",myYZDataServiceObject.serviceNumber];
                            customCell.YZRemarkLabel.text = [NSString stringWithFormat:@"备注:%@",myYZDataServiceObject.YZRemark];
                            customCell.YZtimeLabel.text = [NSString stringWithFormat:@"应征时间:%@",myYZDataServiceObject.YZTime];
                            
                            if ([xuQiuInfo.requirement_Stage intValue] == 4)
                            {
                                [customCell.reminderLabel1 initWithStratString:@"该需求已经关闭!" startColor:[UIColor redColor] startFont:FONT13_SYSTEM centerString:@"" centerColor:grayWordColor centerFont:FONT13_SYSTEM endString:@"" endColor:grayWordColor endFont:FONT13_SYSTEM];
                            }
                            else
                            {
                                [customCell.reminderLabel1 initWithStratString:@"目前已有" startColor:grayWordColor startFont:FONT13_SYSTEM centerString:xuQiuInfo.employeeCount centerColor:[UIColor orangeColor] centerFont:FONT13_SYSTEM endString:@"人应征，您需要等待雇主的最后选择!" endColor:grayWordColor endFont:FONT13_SYSTEM];

                            }
                            
                            customCell.priceLabel.text = [NSString stringWithFormat:@"￥%@",myYZDataServiceObject.YZQuote];
                            
                            //评价按钮处理
                            if ([xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
                            {
                                if ([xuQiuInfo.evaluateStage intValue] == 1 || [xuQiuInfo.evaluateStage intValue] == 3)
                                {//没有评价
                                    customCell.evaluateButton.hidden = YES;
                                    
                                    [customCell.evaluateButton setBackgroundImage:[UIImage imageNamed:@"canNotPressed"] forState:UIControlStateNormal];
                                    customCell.evaluateButton.userInteractionEnabled = NO;
                                    
                                    customCell.evaluateLabel.text = @"已评";
                                }
                                else
                                {
                                    customCell.evaluateButton.hidden = YES;
                                }
                            }
                            else
                            {
                                customCell.evaluateButton.hidden = YES;
                            }
                            
                            Ty_News_Busine_HandlePlist * tempPlistBusine = [[Ty_News_Busine_HandlePlist alloc]init];
                            
                            NSString * unitString = [NSString stringWithFormat:@"/%@",[tempPlistBusine findWorkUnitAndWorkName:xuQiuInfo.workName]];
                            customCell.unitLabel.text = unitString;
                            tempPlistBusine = nil;
                        }
                        customCell.accessoryType = UITableViewCellAccessoryNone;
                        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        return customCell;
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
            }
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
#pragma mark tableview 数据源
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor whiteColor]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ifDataLoad == YES)
    {
        if (semgentButtonTag == 1)
        {
            if ([xuQiuInfo.candidateStatus intValue] == 0)
            {
                UITableViewCell * tempCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
                return tempCell.frame.size.height;
            }
            else
            {
                return 140;
            }
        }
        else
        {
            UITableViewCell * tempCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return tempCell.frame.size.height;
        }
    }
    else
        return 0;
}

#pragma mark 网络回调代理
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
                [self.workerReceivedPush_TableView reloadData];
            }
            else
            {
                [self showNetMessageInView:self.view];
            }
        }
        else if (number == 1)
        {
            if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementDetailWithGuid:requirementGuid])
            {
                xuQiuInfo = [Ty_News_busine_Order_DataBase share_Busine_DataBase].dataBaseXuQiu;
                ifDataLoad = YES;
                
                
                if ([xuQiuInfo.candidateStatus intValue] == 1)
                {
                    if ([xuQiuInfo.requirement_Stage intValue] == 6 || [xuQiuInfo.requirement_Stage intValue] == 4)
                    {
                        [worker_ReceivedPush_Network_Busine workerCheckSelfYZDataWithRequirementGuid:requirementGuid];
                    }
                    else if ([xuQiuInfo.requirement_Stage intValue] == 7 || [xuQiuInfo.requirement_Stage intValue] == 2 || [xuQiuInfo.requirement_Stage intValue] == 3)
                    {
                        if ([xuQiuInfo.serverObject.companiesGuid isEqualToString:@""])
                        {
                            [worker_ReceivedPush_Network_Busine workerCheckSelfYZDataWithRequirementGuid:requirementGuid];
                        }
                    }
                }
                                
                [self refreshHeaderView];
                [self loadFootViewButton];
                [self.workerReceivedPush_TableView reloadData];
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
    else if (number <=4)
    {
        if (number == 3)
        {
            myYZDataLoad = YES;
            
            xuQiuInfo.employeeCount = [[_notification object] objectForKey:@"YZCount"];
            myYZDataServiceObject = worker_ReceivedPush_Network_Busine.YZServiceObject;
            [self refreshHeaderView];
            [self loadFootViewButton];
            [self.workerReceivedPush_TableView reloadData];
        }
        else
        {
            [self showToastMakeToast:@"查询应征信息失败" duration:1 position:@"center"];
        }
    }
    else if(number <= 6)
    {
        if (number == 5)
        {            
            [self performSelector:@selector(poptoLastViewController) withObject:nil afterDelay:1.0];
            xuQiuInfo.candidateStatus = @"0";
            
            NSMutableArray * keys = [[NSMutableArray alloc]initWithObjects:REQUIREMENT_CANDIDATE_STATUS, nil];
            NSMutableArray * values = [[NSMutableArray alloc]initWithObjects:@"0", nil];
            
            [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateRequirementDetailAndGuid:xuQiuInfo.requirementGuid andKeys:keys andValues:values];
            
            [self showToastMakeToast:@"取消成功" duration:1 position:@"center"];
        }
        else
        {
            [self showToastMakeToast:@"订单状态可能发生变化,请刷新后再试" duration:1 position:@"center"];
        }
    }
    else if(number == 100)
    {//标明fail
        [self showNetMessageInView:self.view];
//        [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];
    }

}

#pragma mark 刷新headerView
-(void)refreshHeaderView
{
    _requirementTopView = [[Ty_UserView_OrderView_RequirementDetail_TopView alloc]init];
    _requirementTopView.masterOrWorker = 1;
    
    _requirementTopView.topViewXuQiu =xuQiuInfo;
    
    [_requirementTopView loadCustomView];
    [_requirementTopView loadValues];
    _requirementTopView.semgentButton.delegate = self;
    
    if ([xuQiuInfo.candidateStatus intValue] == 0)
    {
        _requirementTopView.semgentButton.firstButton.hidden = NO;
        [_requirementTopView.semgentButton.firstButton setTitle:@"订单详细" forState:UIControlStateNormal];
    }
    else
    {
        int stageCode = [xuQiuInfo.requirement_Stage intValue];
        if (stageCode == 7)
        {
            if ([xuQiuInfo.serverObject.companiesGuid isEqualToString:@""])
            {//表明确定的不是我
                [self showToastMakeToast:@"雇主确定了其他服务商,请再接再厉!" duration:1.0 position:@"center"];
                
                _requirementTopView.semgentButton.firstButton.hidden = NO;
                [_requirementTopView.semgentButton.firstButton setTitle:@"我的应征信息" forState:UIControlStateNormal];
            }
            else
            {
                _requirementTopView.semgentButton.firstButton.hidden = NO;
                [_requirementTopView.semgentButton.firstButton setTitle:@"预约服务商" forState:UIControlStateNormal];
            }
        }
        else if(stageCode == 2 || stageCode == 3)
        {
            if ([xuQiuInfo.serverObject.companiesGuid isEqualToString:@""])
            {//表明确定的不是我
                [self showToastMakeToast:@"雇主确定了其他服务商,请再接再厉!" duration:1.0 position:@"center"];
                
                _requirementTopView.semgentButton.firstButton.hidden = NO;
                [_requirementTopView.semgentButton.firstButton setTitle:@"我的应征信息" forState:UIControlStateNormal];
            }
            else
            {
                _requirementTopView.semgentButton.firstButton.hidden = NO;
                [_requirementTopView.semgentButton.firstButton setTitle:@"派遣员工信息" forState:UIControlStateNormal];
                int evaluateState =[xuQiuInfo.evaluateStage intValue];
                
                if (2 == stageCode || stageCode == 3)
                {
                    if (evaluateState == 2||evaluateState == 3)
                    {
                        _requirementTopView.semgentButton.thridButton.hidden = NO;
                        [_requirementTopView.semgentButton.thridButton setTitle:@"订单评价" forState:UIControlStateNormal];
                    }
                }

            }
        }
        else
        {
            _requirementTopView.semgentButton.firstButton.hidden = NO;
            [_requirementTopView.semgentButton.firstButton setTitle:@"我的应征信息" forState:UIControlStateNormal];
        }
        _requirementTopView.semgentButton.secondButton.hidden = NO;
        [_requirementTopView.semgentButton.secondButton setTitle:@"订单详细" forState:UIControlStateNormal];
    }
    self.workerReceivedPush_TableView.tableHeaderView = _requirementTopView;
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
-(void)workReceivedPushPrivateButtonPressed
{
    [self.naviGationController pushViewController:[worker_ReceivedPush_Network_Busine privateButtonPressedandXuQiu:xuQiuInfo] animated:YES];
}
#pragma mark 返回上一个VC
-(void)poptoLastViewController
{
    [self.naviGationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
