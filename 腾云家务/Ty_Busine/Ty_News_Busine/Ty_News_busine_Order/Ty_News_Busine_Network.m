//
//  Ty_News_Busine_Network.m
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_News_Busine_Network.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_Model_ServiceObject.h"
#import "MessageVC.h"//消息的VC
#import "MyImageHandle.h"

@implementation Ty_News_Busine_Network
@synthesize xuQiuInfoArray;
@synthesize serviceObjectArray;
@synthesize YZServiceObject;
@synthesize canYZxuQiuInfoArray;
@synthesize waitServiceXuQiuInfoArray;
@synthesize serviceRecordXuQiuInfoArray;

#pragma mark 关闭需求的网络请求和回调
-(void)notificationCloseRequiremengAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork] formRequest:_closeRequirementURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(notificationCloseRequiremengNetCallBackWithStatus:dic:)];
}
-(void)notificationCloseRequiremengNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    int code = [[_dic objectForKey:@"code"]intValue];
    if (code == 200)
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"3" forKey:@"number"];
        PostNetDelegate(objectDic, @"Ty_OrderVC_PublishAndOrderController");
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"4" forKey:@"number"];
        PostNetDelegate(objectDic, @"Ty_OrderVC_PublishAndOrderController");
    }
}

-(void)masterOrderCloseRequiremengAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork] formRequest:_closeRequirementURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(masterOrderCloseRequiremengNetCallBackWithStatus:dic:)];
}
-(void)masterOrderCloseRequiremengNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        int code = [[_dic objectForKey:@"code"]intValue];
        if (code == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"3" forKey:@"number"];
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"4" forKey:@"number"];
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
 
    }
}
-(void)masterPublishCloseRequiremengAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork] formRequest:_closeRequirementURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(masterPublishCloseRequiremengNetCallBackWithStatus:dic:)];
}
-(void)masterPublishCloseRequiremengNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        int code = [[_dic objectForKey:@"code"]intValue];
        if (code == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"3" forKey:@"number"];
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"4" forKey:@"number"];
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
    }
    
}

#pragma mark 雇主查看需求详情接口以及网络回调
-(void)masterOrderCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    NSString * updateTime = [NSString stringWithFormat:@"%@",[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:_requirementGuid]];
    
    [sendMessage setObject:updateTime forKey:@"requirementUpdateTime"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:_masterDirectlyInfoURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(masterOrderCheckRequirementDetailNetCallBackWithStatus:dic:)];
}
//上面网络请求的回调
-(void)masterOrderCheckRequirementDetailNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"需求的详细信息%@",_dic);
        
        NSMutableDictionary * orderInfo = [[NSMutableDictionary alloc]init];
        int code = [[_dic objectForKey:@"code"]intValue];
        if (code == 200)
        {
            if ([[_dic objectForKey:@"total"]intValue]>=1)
            {
                
                orderInfo =[NSMutableDictionary dictionaryWithDictionary:[[_dic objectForKey:@"rows"] objectAtIndex:0]];
                
                if ([[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:[orderInfo objectForKey:@"requirementGuid"]] isEqualToString:@"2000-01-01 00:00:00"])
                {//之前没有这条需求
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveRequirementDetail:orderInfo andUserType:@"0"];
                    
                    //判断是否使用优惠券
                    if ([[orderInfo objectForKey:@"requirementCoupon"] count] > 0)
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderCoupon:[[orderInfo objectForKey:@"requirementCoupon"] objectAtIndex:0] withRequiremnetGuid:[orderInfo objectForKey:@"requirementGuid"]];
                    }
                }
                else
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateRequirementDetailAndGuid:[orderInfo objectForKey:@"requirementGuid"] ankDic:orderInfo];
                }

//                [self prepareToSaveRequirementDetailWithDic:orderInfo andUserType:0];
                
                NSArray * tempEvaluateArr = [[NSArray alloc]initWithArray:[orderInfo objectForKey:@"requirementEvaluate"]];
                
                if ([tempEvaluateArr count] != 0)
                {
                    if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitEvaluateWithGuid:[orderInfo objectForKey:@"requirementGuid"]])
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateEvaluateAndGuid:[orderInfo objectForKey:@"requirementGuid"] andDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                    else
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveEvaluateAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andEvaluateDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                }
                
                
                NSDictionary * hireOrderPersonInfo = [[NSDictionary alloc]initWithDictionary:[[orderInfo objectForKey:@"requirementOrderPost"] objectAtIndex:0]];
                
                Ty_Model_ServiceObject * tempObject = [[Ty_Model_ServiceObject alloc]init];
                
                tempObject.serviceNumber = [hireOrderPersonInfo objectForKey:@"count"];//次数
                tempObject.YZTime =[hireOrderPersonInfo objectForKey:@"candidateTime"];//时间
                tempObject.companiesGuid = [hireOrderPersonInfo objectForKey:@"userGuid"];//中介名字
                tempObject.companyUserName = [hireOrderPersonInfo objectForKey:@"userName"];//中介userName
                tempObject.companyUserAnnear = [hireOrderPersonInfo objectForKey:@"userAnnear"];//中介的锤炼号
                tempObject.respectiveCompanies = [hireOrderPersonInfo objectForKey:@"userRealName"];//中介真实姓名
                tempObject.companyPhoto = [hireOrderPersonInfo objectForKey:@"userPhoto"];//中介头像
                tempObject.YZQuote = [hireOrderPersonInfo objectForKey:@"candidatePrice"];//应征报价
                tempObject.companyPhoneNumber = [hireOrderPersonInfo objectForKey:@"userPhone"];
                
                if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 0)
                {//由于现在直接预约的是中介或者中结下的短工
                    NSArray * tempArray = [[NSArray alloc]initWithArray: [orderInfo objectForKey:@"requirementOrderList"]];
                    if ([tempArray count] == 0)
                    {
                        tempObject.userGuid = @"";
                        tempObject.userName = @"";
                        tempObject.userRealName = @"";
                        tempObject.userType = @"0";
                        tempObject.sex = @"1";
                        tempObject.headPhoto = @"";
                        tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                        tempObject.phoneNumber = @"";
                    }
                    else
                    {//暂时是一个人
                        tempObject.userGuid =[[tempArray objectAtIndex:0] objectForKey:@"userGuid"];
                        tempObject.userName =[[tempArray objectAtIndex:0] objectForKey:@"userName"];
                        tempObject.userRealName = [[tempArray objectAtIndex:0] objectForKey:@"userRealName"];
                        tempObject.userType = @"1";
                        tempObject.sex = [[tempArray objectAtIndex:0] objectForKey:@"userSex"];
                        tempObject.headPhoto = [[tempArray objectAtIndex:0] objectForKey:@"userPhoto"];
                        tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                        tempObject.phoneNumber = [[tempArray objectAtIndex:0] objectForKey:@"userPhone"];
                    }
                    
                }
                else if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 1)
                {
                    NSLog(@"现在应该不走这个");
                }
                else
                {
                    NSLog(@"现在应该不走这个");
                }

                if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]])
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andServiceObject:tempObject];
                }
                else
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andOrderUserGuid:tempObject.userGuid andServiceObject:tempObject];
                }
                
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"0" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
            }
        }
        else if(code == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"2" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_MasterOrder");
    }
}
-(void)masterPublishCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    NSString * updateTime = [NSString stringWithFormat:@"%@",[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:_requirementGuid]];
    
    [sendMessage setObject:updateTime forKey:@"requirementUpdateTime"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:_masterDirectlyInfoURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(masterPublishCheckRequirementDetailNetCallBackWithStatus:dic:)];
}
//上面网络请求的回调
-(void)masterPublishCheckRequirementDetailNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"需求的详细信息%@",_dic);
        
        NSMutableDictionary * orderInfo = [[NSMutableDictionary alloc]init];
        int code = [[_dic objectForKey:@"code"]intValue];
        if (code == 200)
        {
            if ([[_dic objectForKey:@"total"]intValue]>=1)
            {
                
                orderInfo =[NSMutableDictionary dictionaryWithDictionary:[[_dic objectForKey:@"rows"] objectAtIndex:0]];
                
                if ([[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:[orderInfo objectForKey:@"requirementGuid"]] isEqualToString:@"2000-01-01 00:00:00"])
                {//之前没有这条需求
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveRequirementDetail:orderInfo andUserType:@"0"];
                    
                    //判断是否使用优惠券
                    if ([[orderInfo objectForKey:@"requirementCoupon"] count] > 0)
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderCoupon:[[orderInfo objectForKey:@"requirementCoupon"] objectAtIndex:0] withRequiremnetGuid:[orderInfo objectForKey:@"requirementGuid"]];
                    }

                }
                else
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateRequirementDetailAndGuid:[orderInfo objectForKey:@"requirementGuid"] ankDic:orderInfo];
                }

//                [self prepareToSaveRequirementDetailWithDic:orderInfo andUserType:0];
                
                NSArray * tempEvaluateArr = [[NSArray alloc]initWithArray:[orderInfo objectForKey:@"requirementEvaluate"]];
                
                if ([tempEvaluateArr count] != 0)
                {
                    if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitEvaluateWithGuid:[orderInfo objectForKey:@"requirementGuid"]])
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateEvaluateAndGuid:[orderInfo objectForKey:@"requirementGuid"] andDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                    else
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveEvaluateAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andEvaluateDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                }
                
                int stageCode = [[orderInfo objectForKey:@"requirementStage"]intValue];
                if (stageCode == 2 || stageCode == 3 || stageCode == 7)
                {
                    NSDictionary * hireOrderPersonInfo = [[NSDictionary alloc]initWithDictionary:[[orderInfo objectForKey:@"requirementOrderPost"] objectAtIndex:0]];
                    
                    Ty_Model_ServiceObject * tempObject = [[Ty_Model_ServiceObject alloc]init];
                    
                    tempObject.serviceNumber = [hireOrderPersonInfo objectForKey:@"count"];//次数
                    tempObject.YZTime =[hireOrderPersonInfo objectForKey:@"candidateTime"];//时间
                    tempObject.companiesGuid = [hireOrderPersonInfo objectForKey:@"userGuid"];//中介名字
                    tempObject.companyUserName = [hireOrderPersonInfo objectForKey:@"userName"];//中介userName
                    tempObject.companyUserAnnear = [hireOrderPersonInfo objectForKey:@"userAnnear"];//中介的锤炼号
                    tempObject.respectiveCompanies = [hireOrderPersonInfo objectForKey:@"userRealName"];//中介真实姓名
                    tempObject.companyPhoto = [hireOrderPersonInfo objectForKey:@"userPhoto"];//中介头像
                    tempObject.YZQuote = [hireOrderPersonInfo objectForKey:@"candidatePrice"];//应征报价
                    tempObject.companyPhoneNumber = [hireOrderPersonInfo objectForKey:@"userPhone"];
                    
                    if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 0)
                    {//由于现在直接预约的是中介或者中结下的短工
                        NSArray * tempArray = [[NSArray alloc]initWithArray: [orderInfo objectForKey:@"requirementOrderList"]];
                        if ([tempArray count] == 0)
                        {
                            tempObject.userGuid = @"";
                            tempObject.userName = @"";
                            tempObject.userRealName = @"";
                            tempObject.userType = @"0";
                            tempObject.sex = @"1";
                            tempObject.headPhoto = @"";
                            tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                            tempObject.phoneNumber = @"";
                        }
                        else
                        {//暂时是一个人
                            tempObject.userGuid =[[tempArray objectAtIndex:0] objectForKey:@"userGuid"];
                            tempObject.userName =[[tempArray objectAtIndex:0] objectForKey:@"userName"];
                            tempObject.userRealName = [[tempArray objectAtIndex:0] objectForKey:@"userRealName"];
                            tempObject.userType = @"1";
                            tempObject.sex = [[tempArray objectAtIndex:0] objectForKey:@"userSex"];
                            tempObject.headPhoto = [[tempArray objectAtIndex:0] objectForKey:@"userPhoto"];
                            tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                            tempObject.phoneNumber = [[tempArray objectAtIndex:0] objectForKey:@"userPhone"];
                        }
                        
                    }
                    else if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 1)
                    {
                        NSLog(@"现在应该不走这个");
                    }
                    else
                    {
                        NSLog(@"现在应该不走这个");
                    }
                    if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]])
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andServiceObject:tempObject];
                    }
                    else
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andOrderUserGuid:tempObject.userGuid andServiceObject:tempObject];
                    }
                    
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
                }
                else if (stageCode == 6)
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
                    [self freshPage];
                    [self checkYZPeopleWithRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]];
                }
                else
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
                }
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
            }
        }
        else if (code == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"2" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");

    }
}

#pragma mark 查看应征人
-(void)checkYZPeopleWithRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessageDic = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:[NSNumber numberWithInt:5] forKey:@"pageSize"];
    [sendMessageDic setObject:[NSNumber numberWithInt:hirePersonPage] forKey:@"currentPage"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_requirementHirePeopleInfoURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(checkYZPeopleNetCallBackWithStatus:dic:)];
}
-(void)checkYZPeopleNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"应征的人%@",_dic);
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            if (hirePersonPage == 1)
            {//如果是下拉刷新，那么清空数组
                [serviceObjectArray removeAllObjects];
            }
            lastHirePersonPage = hirePersonPage;
            hirePersonPage ++;
            if ([self saveDataToServiceObjectArray:[_dic objectForKey:@"rows"]])
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"5" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
            }
            else
            {
                currentPage = lastPage;
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"7" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
            }
            
        }
        else if ([[_dic objectForKey:@"code"] intValue] == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"6" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
        else
        {
            currentPage = lastPage;
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"7" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
    }
    else
    {
        currentPage = lastPage;
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
    }
}

#pragma mark 雇主确定人选
-(void)masterPublishSurePersonWithRequirementGuid:(NSString *)_requirementGuid andSurePersonGuid:(NSString *)_surePersonGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessage setObject:_surePersonGuid forKey:@"requirementOrderUserGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:_masterOrderHirePersonURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(masterPublishSurePersonNetCallBackWithStatus:dic:)];
}
//回调
-(void)masterPublishSurePersonNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"8" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"9" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_MasterPublish");

    }
}

#pragma mark 雇主评价雇工
-(void)masterEvaluateWorkerWithRequirementGuid:(NSString *)_requirementGuid andUserGuid:(NSString *)_userGuid andXuQiu:(Ty_Model_XuQiuInfo *)_xuQiu
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:_userGuid forKey:@"userGuid"];
    
    [sendMessage setObject:_xuQiu.totalPJ_For_Employee forKey:@"evaluateServeTotal"];
    [sendMessage setObject:_xuQiu.detailPJ_For_Employee forKey:@"evaluateForEmployeeOther"];
    [sendMessage setObject:_xuQiu.servicePJ_For_Employee forKey:@"evaluateServeQuality"];
    [sendMessage setObject:_xuQiu.speedPJ_For_Employee forKey:@"evaluateServeSpeed"];
    [sendMessage setObject:_xuQiu.attitudePJ_For_Employee forKey:@"evaluateServeAttitude"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:_masterEvaluateWorkerURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(masterEvaluateWorkerNetCallBackWithStatus:dic:)];
}
//回调
-(void)masterEvaluateWorkerNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"0" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Evaluate_Worker_Controller");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Evaluate_Worker_Controller");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Evaluate_Worker_Controller");
    }
}
#pragma mark 雇工查看需求详情
/*
 雇工收到预约的网络业务层处理
 */
-(void)workerOrderCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    NSString * updateTime = [NSString stringWithFormat:@"%@",[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:_requirementGuid]];
    
    [sendMessage setObject:updateTime forKey:@"requirementUpdateTime"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:_workerDirectlyAndSystemInfoURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(workerOrderCheckRequirementDetailNetCallBackWithStatus:dic:)];
}
-(void)workerOrderCheckRequirementDetailNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSMutableDictionary * orderInfo = [[NSMutableDictionary alloc]init];
        int code = [[_dic objectForKey:@"code"]intValue];
        if (code == 200)
        {
            if ([[_dic objectForKey:@"total"]intValue]>=1)
            {
                orderInfo =[NSMutableDictionary dictionaryWithDictionary:[[_dic objectForKey:@"rows"] objectAtIndex:0]];
                [orderInfo setObject:@"1" forKey:@"requirementUserType"];
                
                if ([[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:[orderInfo objectForKey:@"requirementGuid"]] isEqualToString:@"2000-01-01 00:00:00"])
                {//之前没有这条需求
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveRequirementDetail:orderInfo andUserType:@"1"];
                    
                    //判断是否使用优惠券
                    if ([[orderInfo objectForKey:@"requirementCoupon"] count] > 0)
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderCoupon:[[orderInfo objectForKey:@"requirementCoupon"] objectAtIndex:0] withRequiremnetGuid:[orderInfo objectForKey:@"requirementGuid"]];
                    }

                }
                else
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateRequirementDetailAndGuid:[orderInfo objectForKey:@"requirementGuid"] ankDic:orderInfo];
                }

//                [self prepareToSaveRequirementDetailWithDic:orderInfo andUserType:1];
                NSArray * tempEvaluateArr = [[NSArray alloc]initWithArray:[orderInfo objectForKey:@"requirementEvaluate"]];
                
                if ([tempEvaluateArr count] != 0)
                {
                    if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitEvaluateWithGuid:[orderInfo objectForKey:@"requirementGuid"]])
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateEvaluateAndGuid:[orderInfo objectForKey:@"requirementGuid"] andDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                    else
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveEvaluateAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andEvaluateDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                }
                
                
                NSDictionary * hireOrderPersonInfo = [[NSDictionary alloc]initWithDictionary:[[orderInfo objectForKey:@"requirementOrderPost"] objectAtIndex:0]];
                
                Ty_Model_ServiceObject * tempObject = [[Ty_Model_ServiceObject alloc]init];
                
                tempObject.serviceNumber = [hireOrderPersonInfo objectForKey:@"count"];//次数
                tempObject.YZTime =[hireOrderPersonInfo objectForKey:@"candidateTime"];//时间
                tempObject.companiesGuid = [hireOrderPersonInfo objectForKey:@"userGuid"];//中介名字
                tempObject.companyUserName = [hireOrderPersonInfo objectForKey:@"userName"];//中介userName
                tempObject.companyUserAnnear = [hireOrderPersonInfo objectForKey:@"userAnnear"];//中介的锤炼号
                tempObject.respectiveCompanies = [hireOrderPersonInfo objectForKey:@"userRealName"];//中介真实姓名
                tempObject.companyPhoto = [hireOrderPersonInfo objectForKey:@"userPhoto"];//中介头像
                tempObject.YZQuote = [hireOrderPersonInfo objectForKey:@"candidatePrice"];//应征报价
                tempObject.companyPhoneNumber = [hireOrderPersonInfo objectForKey:@"userPhone"];
                
                if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 0)
                {//由于现在直接预约的是中介或者中结下的短工
                    NSArray * tempArray = [[NSArray alloc]initWithArray: [orderInfo objectForKey:@"requirementOrderList"]];
                    if ([tempArray count] == 0)
                    {
                        tempObject.userGuid = @"";
                        tempObject.userName = @"";
                        tempObject.userRealName = @"";
                        tempObject.userType = @"0";
                        tempObject.sex = @"1";
                        tempObject.headPhoto = @"";
                        tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                        tempObject.phoneNumber = @"";
                    }
                    else
                    {//暂时是一个人
                        tempObject.userGuid =[[tempArray objectAtIndex:0] objectForKey:@"userGuid"];
                        tempObject.userName =[[tempArray objectAtIndex:0] objectForKey:@"userName"];
                        tempObject.userRealName = [[tempArray objectAtIndex:0] objectForKey:@"userRealName"];
                        tempObject.userType = @"1";
                        tempObject.sex = [[tempArray objectAtIndex:0] objectForKey:@"userSex"];
                        tempObject.headPhoto = [[tempArray objectAtIndex:0] objectForKey:@"userPhoto"];
                        tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                        tempObject.phoneNumber = [[tempArray objectAtIndex:0] objectForKey:@"userPhone"];
                    }
                    
                }
                else if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 1)
                {
                    NSLog(@"现在应该不走这个");
                }
                else
                {
                    NSLog(@"现在应该不走这个");
                }
                if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]])
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andServiceObject:tempObject];
                }
                else
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andOrderUserGuid:tempObject.userGuid andServiceObject:tempObject];
                }
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"0" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
            }
        }
        else if (code == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"2" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
    }
}
/*
 雇工收到推送业务层处理
 */
-(void)workerPublishCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    NSString * updateTime = [NSString stringWithFormat:@"%@",[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:_requirementGuid]];
    
    [sendMessage setObject:updateTime forKey:@"requirementUpdateTime"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:_workerDirectlyAndSystemInfoURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(workerPublishCheckRequirementDetailNetCallBackWithStatus:dic:)];
}
-(void)workerPublishCheckRequirementDetailNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSMutableDictionary * orderInfo = [[NSMutableDictionary alloc]init];
        int code = [[_dic objectForKey:@"code"]intValue];
        if (code == 200)
        {
            if ([[_dic objectForKey:@"total"]intValue]>=1)
            {
                
                orderInfo =[NSMutableDictionary dictionaryWithDictionary:[[_dic objectForKey:@"rows"] objectAtIndex:0]];
                [orderInfo setObject:@"1" forKey:@"requirementUserType"];

                if ([[[Ty_News_busine_Order_DataBase share_Busine_DataBase] getRequirementUpdateTime:[orderInfo objectForKey:@"requirementGuid"]] isEqualToString:@"2000-01-01 00:00:00"])
                {//之前没有这条需求
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveRequirementDetail:orderInfo andUserType:@"1"];
                    
                    //判断是否使用优惠券
                    if ([[orderInfo objectForKey:@"requirementCoupon"] count] > 0)
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderCoupon:[[orderInfo objectForKey:@"requirementCoupon"] objectAtIndex:0] withRequiremnetGuid:[orderInfo objectForKey:@"requirementGuid"]];
                    }
                }
                else
                {
                    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateRequirementDetailAndGuid:[orderInfo objectForKey:@"requirementGuid"] ankDic:orderInfo];
                }
                
                NSArray * tempEvaluateArr = [[NSArray alloc]initWithArray:[orderInfo objectForKey:@"requirementEvaluate"]];
                
                if ([tempEvaluateArr count] != 0)
                {
                    if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitEvaluateWithGuid:[orderInfo objectForKey:@"requirementGuid"]])
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateEvaluateAndGuid:[orderInfo objectForKey:@"requirementGuid"] andDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                    else
                    {
                        [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveEvaluateAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andEvaluateDic:[tempEvaluateArr objectAtIndex:0]];
                    }
                }

                int stageCode = [[orderInfo objectForKey:@"requirementStage"]intValue];
                if (stageCode == 0)
                {
                    
                }
                else if (stageCode == 6)
                {
                    if ([[orderInfo objectForKey:@"requirementCandidateStatus"]intValue] == 1)
                    {
                        [self workerCheckSelfYZDataWithRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]];
                    }
                }
                else if (stageCode == 2 || stageCode == 3 || stageCode == 7)
                {//交易中，已完成
                    NSDictionary * hireOrderPersonInfo = [[NSDictionary alloc]initWithDictionary:[[orderInfo objectForKey:@"requirementOrderPost"] objectAtIndex:0]];
                    
                    if ([[hireOrderPersonInfo objectForKey:@"userGuid"] isEqualToString:MyLoginUserGuid])//不对，应该是宏定义
                    {
                        Ty_Model_ServiceObject * tempObject = [[Ty_Model_ServiceObject alloc]init];
                        
                        tempObject.serviceNumber = [hireOrderPersonInfo objectForKey:@"count"];//次数
                        tempObject.YZTime =[hireOrderPersonInfo objectForKey:@"candidateTime"];//时间
                        tempObject.companiesGuid = [hireOrderPersonInfo objectForKey:@"userGuid"];//中介名字
                        tempObject.companyUserName = [hireOrderPersonInfo objectForKey:@"userName"];//中介userName
                        tempObject.companyUserAnnear = [hireOrderPersonInfo objectForKey:@"userAnnear"];//中介的锤炼号
                        tempObject.respectiveCompanies = [hireOrderPersonInfo objectForKey:@"userRealName"];//中介真实姓名
                        tempObject.companyPhoto = [hireOrderPersonInfo objectForKey:@"userPhoto"];//中介头像
                        tempObject.YZQuote = [hireOrderPersonInfo objectForKey:@"candidatePrice"];//应征报价
                        tempObject.companyPhoneNumber = [hireOrderPersonInfo objectForKey:@"userPhone"];
                        
                        if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 0)
                        {//由于现在直接预约的是中介或者中结下的短工
                            NSArray * tempArray = [[NSArray alloc]initWithArray: [orderInfo objectForKey:@"requirementOrderList"]];
                            if ([tempArray count] == 0)
                            {
                                tempObject.userGuid = @"";
                                tempObject.userName = @"";
                                tempObject.userRealName = @"";
                                tempObject.userType = @"0";
                                tempObject.sex = @"1";
                                tempObject.headPhoto = @"";
                                tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                                tempObject.phoneNumber = @"";
                            }
                            else
                            {//暂时是一个人
                                tempObject.userGuid =[[tempArray objectAtIndex:0] objectForKey:@"userGuid"];
                                tempObject.userName =[[tempArray objectAtIndex:0] objectForKey:@"userName"];
                                tempObject.userRealName = [[tempArray objectAtIndex:0] objectForKey:@"userRealName"];
                                tempObject.userType = @"1";
                                tempObject.sex = [[tempArray objectAtIndex:0] objectForKey:@"userSex"];
                                tempObject.headPhoto = [[tempArray objectAtIndex:0] objectForKey:@"userPhoto"];
                                tempObject.evaluate = [hireOrderPersonInfo objectForKey:@"userEvaluate"];
                                tempObject.phoneNumber = [[tempArray objectAtIndex:0] objectForKey:@"userPhone"];
                            }
                        }
                        else if ([[hireOrderPersonInfo objectForKey:@"userType"]intValue] == 1)
                        {
                            NSLog(@"现在应该不走这个");
                        }
                        else
                        {
                            NSLog(@"现在应该不走这个");
                        }
                        if ([[Ty_News_busine_Order_DataBase share_Busine_DataBase] judgeIfExitOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]])
                        {
                            [[Ty_News_busine_Order_DataBase share_Busine_DataBase] updateOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andServiceObject:tempObject];
                        }
                        else
                        {
                            [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveOrderPersonAndRequirementGuid:[orderInfo objectForKey:@"requirementGuid"] andOrderUserGuid:tempObject.userGuid andServiceObject:tempObject];
                        }

                    }
                    else
                    {
                        if ([[orderInfo objectForKey:@"requirementCandidateStatus"]intValue] == 1)
                        {
                            [self workerCheckSelfYZDataWithRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]];
                        }
                    }
                }
                else
                {//非正常关闭
                    if ([[orderInfo objectForKey:@"requirementCandidateStatus"]intValue] == 1)
                    {
                        [self workerCheckSelfYZDataWithRequirementGuid:[orderInfo objectForKey:@"requirementGuid"]];
                    }
                }
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"0" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
            }
        }
        else if (code == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"2" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"2" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
    }
}

#pragma mark 应征和取消应征
//应征
-(void)workerYZRequirementWithRequirementGuid:(NSString *)_requirementGuid andRemark:(NSString *)_remark andPrice:(NSString *)_price
{
    NSMutableDictionary * sendMessageDic = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessageDic setObject:_remark forKey:@"candidateRemark"];
    [sendMessageDic setObject:_price forKey:@"candidatePrice"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_workApplyRequirementURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerYZRequirementNetCallBackWithStatus:dic:)];
}
//回调
-(void)workerYZRequirementNetCallBackWithStatus:(NSString*)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"我应征某条需求的回调%@",_dic);
        if ([[_dic objectForKey:@"code"]intValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"0" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_YZController");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_YZController");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_YZController");
    }
}
//取消应征
-(void)workerQuitYZRequirementWithRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessageDic = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_quitYZOrderURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerQuitYZNetCallBackWithStatus:dic:)];
}
-(void)workerQuitYZNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"取消应征结果%@",_dic);
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"5" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"6" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
    }
}
#pragma mark 雇工对预约做出回应
-(void)workerRespondToRequirementWithRequiremnetGuid:(NSString *)_requirementGuid withRespondString:(NSString *)_respond
{
    NSMutableDictionary * sendMessageDic = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessageDic setObject:_respond forKey:@"requirementOrderTrue"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_workerReplyDirectlyOrderURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerRespondToRequirementNetCallBackWithStatus:dic:)];
}
-(void)workerRespondToRequirementNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"雇工回应预约%@",_dic);
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"3" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"4" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"4" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedOrder");
    }
}

#pragma mark 雇工查看自己应征的相关信息
-(void)workerCheckSelfYZDataWithRequirementGuid:(NSString *)_requirementGuid
{
    NSMutableDictionary * sendMessageDic = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_requirementYZNumberAndOtherURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerCheckSelfYZDataNetCallBackWithStatus:dic:)];
}
//回调
-(void)workerCheckSelfYZDataNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"我应征的信息%@",_dic);
        if ([[_dic objectForKey:@"code"]intValue] == 200)
        {
            NSDictionary * myYZObjectDic = [[NSDictionary alloc]initWithDictionary:[[_dic objectForKey:@"rows"] objectAtIndex:0]];
            YZServiceObject.companyPhoto = [myYZObjectDic objectForKey:@"userPhoto"];
            YZServiceObject.companiesGuid = MyLoginUserGuid;
            YZServiceObject.respectiveCompanies = [myYZObjectDic objectForKey:@"userRealName"];
            YZServiceObject.companyUserName = [myYZObjectDic objectForKey:@"userName"];
            YZServiceObject.userType = @"0";
            YZServiceObject.sex = @"0";
            YZServiceObject.evaluate = [myYZObjectDic objectForKey:@"userEvaluate"];
            YZServiceObject.serviceNumber = [myYZObjectDic objectForKey:@"orderCount"];
            YZServiceObject.YZQuote = [myYZObjectDic objectForKey:@"candidatePrice"];
            YZServiceObject.YZRemark = [myYZObjectDic objectForKey:@"candidateRemark"];
            YZServiceObject.YZTime = [myYZObjectDic objectForKey:@"candidateTime"];
            
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"3" forKey:@"number"];
            [objectDic setObject:[_dic objectForKey:@"count"] forKey:@"YZCount"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"4" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Worker_ReceivedPush");
    }
}

#pragma mark 商户查看手下
-(void)workerLookEmployeesWithWorkGuid:(NSString *)_workGuid
{
    NSMutableDictionary * sendMessageDic = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessageDic setObject:_workGuid forKey:@"workGuid"];
//    [sendMessageDic setObject:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    [sendMessageDic setObject:[NSNumber numberWithInt:currentPage] forKey:@"currentPage"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:Ty_UserDetail_UserUrl andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerLookEmployeesNetCallBackWithStatus:dic:)];
}
//回调
-(void)workerLookEmployeesNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"中介查看手下的员工%@",_dic);
        int code = [[_dic objectForKey:@"code"]intValue];
        
        if (code == 200)
        {
            if (currentPage == 1)
            {
                [serviceObjectArray removeAllObjects];
            }
            lastPage = currentPage;
            currentPage ++;
            if ([self saveEmployeesToServieceObjectArray:[_dic objectForKey:@"rows"]])
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"0" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
            }
        }
        else if (code == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"2" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
    }
}


/**插入需求详情表   需要的dic*/
-(void)prepareToSaveRequirementDetailWithDic:(NSMutableDictionary *)orderInfo andUserType:(int)_userType
{//0是雇主，1是雇工
    NSMutableDictionary * saveDataBaseDic = [[NSMutableDictionary alloc]init];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementGuid"] forKey:@"requirementGuid"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementNumber"] forKey:@"requirementNumber"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementStage"] forKey:@"requirementStage"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementType"] forKey:@"requirementType"];
    [saveDataBaseDic setObject:[NSString stringWithFormat:@"%d",_userType] forKey:@"requirementUserType"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementCandidateStatus"] forKey:@"requirementCandidateStatus"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"evaluateState"] forKey:@"evaluateState"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementWorkGuid"] forKey:@"requirementWorkGuid"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"workName"] forKey:@"workName"];
    [saveDataBaseDic setObject:MyLoginUserGuid forKey:@"userGuid"];//这里取得时本地Plist中登陆后存的信息
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"userName"] forKey:@"userName"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"userRealName"] forKey:@"userRealName"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"userSex"] forKey:@"userSex"];//需要和服务器统一
    [saveDataBaseDic setObject:@"2" forKey:@"userType"];//同上
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"userPhoto"] forKey:@"userPhoto"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAddress"] forKey:@"requirementAddress"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAddressDetail"] forKey:@"requirementAddressDetail"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementPublishTime"] forKey:@"requirementPublishTime"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementStartTime"] forKey:@"requirementStartTime"];
    [saveDataBaseDic setObject:@"" forKey:@"requirementEndTime"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementSalary"] forKey:@"requirementUnitPrice"];//服务器没有
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementSalary"] forKey:@"requirementTotalPrice"];//服务器没有
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementTimeStage"] forKey:@"workAmount"];//工作量
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementContactName"] forKey:@"requirementContactName"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementContactPhone"] forKey:@"requirementContactPhone"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementSalary"] forKey:@"requirementAskSalary"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskAge"] forKey:@"requirementAskAge"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskSex"] forKey:@"requirementAskSex"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskRecord"] forKey:@"requirementAskRecord"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskNation"] forKey:@"requirementAskNation"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskWork"] forKey:@"requirementAskWork"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskCensus"] forKey:@"requirementAskCensus"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementAskOther"] forKey:@"requirementAskOther"];
    [saveDataBaseDic setObject:[orderInfo objectForKey:@"requirementUpdateTime"] forKey:@"requirementUpdateTime"];
    
    [[Ty_News_busine_Order_DataBase share_Busine_DataBase] saveRequirementDetail:saveDataBaseDic andUserType:[NSString stringWithFormat:@"%d",_userType]];
}

#pragma mark 派遣员工
-(void)workerSendEmployeeWithRequirementGuid:(NSString *)_requirementGuid andEmployeeUserGuid:(NSString *)_employeeUserGuid
{
    NSMutableDictionary * sendMessageDic  = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:_employeeUserGuid forKey:@"userGuid"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_workerSendEmployeeURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerSendEmployeeNetCallBackWithStatus:dic:)];
}
//回调
-(void)workerSendEmployeeNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog( @"商户派遣员工返回%@",_dic);
        if ([[_dic objectForKey:@"code"]intValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"3" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"4" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_SendEmployee_Controller");
    }
}

#pragma mark 新建雇工
-(void)workerNewEmployeeWithWorkGuid:(NSString *)_workGuid andModel:(My_AddEmployeeModel *)_model andServiceModel:(Ty_Model_ServiceObject *)_serviceModel andPostSalary:(NSString *)_postSalary andWorkName:(NSString *)_workName;
{
    NSMutableDictionary * sendMessageDic  = [[NSMutableDictionary alloc]init];
    NSString * userGuidHead = [[Guid share] getGuid];

    [sendMessageDic setObject:MyLoginUserGuid forKey:@"myUserGuid"];
    [sendMessageDic setObject:userGuidHead forKey:@"userGuid"];
    [sendMessageDic setObject:_serviceModel.userRealName forKey:@"userRealName"];
    [sendMessageDic setObject:_serviceModel.sex forKey:@"userSex"];
    [sendMessageDic setObject:_serviceModel.phoneNumber forKey:@"detailPhone"];
    [sendMessageDic setObject:_serviceModel.idCard forKey:@"detailIdcard"];
    [sendMessageDic setObject:_workGuid forKey:@"workGuid"];
    
    NSMutableDictionary * _dicFile = [[NSMutableDictionary alloc]init];
    
    
    if (!ISNULL(_model.userPhoto) && !ISNULL(_model.userSmallPhoto)) {
        NSString * savePath = [MyImageHandle saveImage:[MyImageHandle imageWithImageSimple:_model.userPhoto scaledToSize:CGSizeMake(320, 320)] WithName:@".png" type:@"Head" userGuid:userGuidHead];
        
        [_dicFile setObject:savePath forKey:@"userPhoto"];
        _serviceModel.headPhotoGaoQing = savePath;
        
        NSString * saveSmallPath = [MyImageHandle saveSmallImage:[MyImageHandle imageWithImageSimple:_model.userSmallPhoto scaledToSize:CGSizeMake(65, 65)] WithName:@".png" type:@"Head" userGuid:userGuidHead];
        [_dicFile setObject:saveSmallPath forKey:@"userSmallPhoto"];
        _serviceModel.headPhoto = saveSmallPath;
    }

    if ([_workName isEqualToString:@"日常保洁"] || [_workName isEqualToString:@"空调清洗"])
    {
        [sendMessageDic setObject:_postSalary forKey:@"postRealSalary"];
    }
    else
    {
        [sendMessageDic setObject:_postSalary forKey:@"postSalary"];
    }
    _serviceModel.userGuid = userGuidHead;
    
    [[Ty_NetRequestService shareNetWork]formRequest:_userAddEmpURL andParameterDic:sendMessageDic andfileDic:_dicFile andTarget:self andSeletor:@selector(workerNewEmployeeNetCallBackWithStatus:dic:)];
}
//回调
-(void)workerNewEmployeeNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"新建员工返回的%@",_dic);
        
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:[_dic objectForKey:@"code"] forKey:@"number"];
        [objectDic setObject:[_dic objectForKey:@"msg"] forKey:@"msg"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_NewEmployeeController");
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"0" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_NewEmployeeController");
    }
}

#pragma mark 雇工评价雇主
-(void)workerEvaluateMasterWithRequirementGuid:(NSString *)_requirementGuid andtotalEvaluate:(int)_totalEvaluate andOtherEvaluate:(NSString *)_otherString
{
    NSMutableDictionary * sendMessageDic  = [[NSMutableDictionary alloc]init];
    [sendMessageDic setObject:_requirementGuid forKey:@"requirementGuid"];
    [sendMessageDic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessageDic setObject:[NSNumber numberWithInt:_totalEvaluate] forKey:@"evaluateServeTotal"];
    [sendMessageDic setObject:_otherString forKey:@"evaluateForMasterOther"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_workerEvaluateMasterURL andParameterDic:sendMessageDic andTarget:self andSeletor:@selector(workerEvaluateMasterNetCallBackWithStatus:dic:)];
}
//回调
-(void)workerEvaluateMasterNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"评价雇主返回的%@",_dic);
        if ([[_dic objectForKey:@"code"]integerValue] == 200)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"0" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Evaluate_Master_Controller");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_Evaluate_Master_Controller");
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];
        
        PostNetDelegate(objectDic, @"Ty_OrderVC_Evaluate_Master_Controller");
    }
}

#pragma mark 抢单和预约通知 ----的网络请求和回调
-(void)publishAndOrderNotificationWithButtonTag:(int)tag
{
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    if (IFLOGINYES)
    {
        [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    }
    else
    {
        [sendMessage setObject:@"" forKey:@"userGuid"];
    }
    [sendMessage setObject:@"10" forKey:@"pageSize"];
    filterButtonTag = tag;
    
    if (filterButtonTag == -1)
    {
        [sendMessage setObject:[NSNumber numberWithInt:currentPage] forKey:@"currentPage"];
    }
    else if(filterButtonTag == 0)
    {
        [sendMessage setObject:[NSNumber numberWithInt:canYZPage] forKey:@"currentPage"];
        [sendMessage setObject:[NSNumber numberWithInt:0] forKey:@"queryType"];
    }
    else if (filterButtonTag == 1)
    {
        [sendMessage setObject:[NSNumber numberWithInt:waitServicePage] forKey:@"currentPage"];
        [sendMessage setObject:[NSNumber numberWithInt:1] forKey:@"queryType"];
    }
    else
    {
        [sendMessage setObject:[NSNumber numberWithInt:serviceRecordPage] forKey:@"currentPage"];
        [sendMessage setObject:[NSNumber numberWithInt:2] forKey:@"queryType"];
    }
    
    [[Ty_NetRequestService shareNetWork] formRequest:_publishAndOrderNotificationURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(publishAndOrderNotificationNetCallBackWithStatus:dic:)];
}
-(void)publishAndOrderNotificationNetCallBackWithStatus:(NSString*)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"抢单和预约通知网络请求下来的数据%@",_dic);
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            //首先判断是哪一个按钮点击
            if (filterButtonTag == -1)
            {
                if (currentPage == 1)
                {//如果是下拉刷新，那么清空数组
                    [xuQiuInfoArray removeAllObjects];
                }
                lastPage = currentPage;
                currentPage ++;
            }
            else if (filterButtonTag == 0)
            {
                if (canYZPage == 1)
                {//如果是下拉刷新，那么清空数组
                    [canYZxuQiuInfoArray removeAllObjects];
                }
                canYZLastPage = canYZPage;
                canYZPage ++;
            }
            else if (filterButtonTag == 1)
            {
                if (waitServicePage == 1)
                {//如果是下拉刷新，那么清空数组
                    [waitServiceXuQiuInfoArray removeAllObjects];
                }
                waitServiceLastPage = waitServicePage;
                waitServicePage ++;
            }
            else
            {
                if (serviceRecordPage == 1)
                {//如果是下拉刷新，那么清空数组
                    [serviceRecordXuQiuInfoArray removeAllObjects];
                }
                serviceRecordLastPage = serviceRecordPage;
                serviceRecordPage ++;
            }
            if ([self handleNetWorkCallBack:_dic])
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"0" forKey:@"number"];
                
                if (filterButtonTag == -1)
                {
                    PostNetDelegate(objectDic, @"Ty_Order_Master_Controller");
                }
                else
                {
                    PostNetDelegate(objectDic, @"Ty_Order_Worker_Controller");
                }
            }
            else
            {
                if (filterButtonTag == -1)
                {
                    currentPage = lastPage;
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"2" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_Order_Master_Controller");
                }
                else
                {
                    if (filterButtonTag == 0)
                    {
                        canYZPage = canYZLastPage;
                    }
                    else if (filterButtonTag == 1)
                    {
                        waitServicePage = waitServiceLastPage;
                    }
                    else
                    {
                        serviceRecordPage = serviceRecordLastPage;
                    }
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"2" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_Order_Worker_Controller");
                }
            }
            
        }
        else if ([[_dic objectForKey:@"code"] intValue] == 203)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"1" forKey:@"number"];
            
            if (filterButtonTag == -1)
            {
                PostNetDelegate(objectDic, @"Ty_Order_Master_Controller");
            }
            else
            {
                PostNetDelegate(objectDic, @"Ty_Order_Worker_Controller");
            }
        }
        else
        {
            currentPage = lastPage;
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"2" forKey:@"number"];
            
            if (filterButtonTag == -1)
            {
                PostNetDelegate(objectDic, @"Ty_Order_Master_Controller");
            }
            else
            {
                PostNetDelegate(objectDic, @"Ty_Order_Worker_Controller");
            }
        }
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"100" forKey:@"number"];

        if (filterButtonTag == -1)
        {
            currentPage = lastPage;
            
            PostNetDelegate(objectDic, @"Ty_Order_Master_Controller");
        }
        else
        {
            if (filterButtonTag == 0)
            {
                canYZPage = canYZLastPage;
            }
            else if (filterButtonTag == 1)
            {
                waitServicePage = waitServiceLastPage;
            }
            else
            {
                serviceRecordPage = serviceRecordLastPage;
            }
            PostNetDelegate(objectDic, @"Ty_Order_Worker_Controller");
        }
    }
}

#pragma mark 我界面“已发抢单”“已发预约”等 ----的网络请求和回调
-(void)searchMyAllKindsOfRequirementWithType:(int)_type andUserType:(int)_userType
{
    userType = _userType;
    
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessage setObject:@"10" forKey:@"pageSize"];
    [sendMessage setObject:[NSNumber numberWithInt:_type] forKey:@"type"];
    [sendMessage setObject:[NSNumber numberWithInt:currentPage] forKey:@"currentPage"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_searchMyAllKindsOfRequirementURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(searchMyAllKindsOfRequirementNetCallBackWithStatus:dic:)];
}
-(void)searchMyAllKindsOfRequirementNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"我的各种订单网络请求下来的数据%@",_dic);
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            if (currentPage == 1)
            {//如果是下拉刷新，那么清空数组
                [xuQiuInfoArray removeAllObjects];
            }
            lastPage = currentPage;
            currentPage ++;
            if ([self handleNetWorkCallBack:_dic])
            {
                if (userType == 0 || userType == 1)
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
                }
                else
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
                }
            }
            else
            {
                currentPage = lastPage;
                if (userType == 0 || userType == 1)
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"2" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
                }
                else
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"2" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
                }
            }
        }
        else if ([[_dic objectForKey:@"code"] intValue] == 203)
        {
            if (userType == 0 || userType == 1)
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"1" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
            }
            else
            {
                
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"1" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
            }
        }
        else
        {
            currentPage = lastPage;
            if (userType == 0|| userType == 1)
            {
                
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
            }
            else
            {
                
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"1" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
                
            }
        }
    }
    else
    {
        currentPage = lastPage;
        if (userType == 0 || userType == 1)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"100" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
        }
        else
        {
            
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"100" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
        }

    }
}

#pragma mark 我的所有的订单----网络请求和回调
-(void)searchAllRequirementWithType:(int)_type
{
    buttonNumber = _type;
    NSMutableDictionary * sendMessage = [[NSMutableDictionary alloc]init];
    [sendMessage setObject:MyLoginUserGuid forKey:@"userGuid"];
    [sendMessage setObject:@"10" forKey:@"pageSize"];
    [sendMessage setObject:[NSNumber numberWithInt:currentPage] forKey:@"currentPage"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:_searchAllRequirementURL andParameterDic:sendMessage andTarget:self andSeletor:@selector(searchAllRequirementNetCallBackWithStatus:dic:)];
}
-(void)searchAllRequirementNetCallBackWithStatus:(NSString*)_status dic:(NSMutableDictionary *)_dic
{
    if ([_status isEqualToString:@"success"])
    {
        NSLog(@"我所有的订单网络请求下来的数据%@",_dic);
        if ([[_dic objectForKey:@"code"] intValue] == 200)
        {
            if (currentPage == 1)
            {//如果是下拉刷新，那么清空数组
                [xuQiuInfoArray removeAllObjects];
            }
            lastPage = currentPage;
            currentPage ++;
            
            //调用相似的网络回调
            if ([self handleNetWorkCallBack:_dic])
            {
                if (buttonNumber == 4)
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
                }
                else
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"0" forKey:@"number"];
                
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
                }
            }
            else
            {
                currentPage = lastPage;
                if (buttonNumber == 4)
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"2" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
                }
                else
                {
                    NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                    [objectDic setObject:@"2" forKey:@"number"];
                    
                    PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
                }
            }
            
        }
        else if ([[_dic objectForKey:@"code"] intValue] == 203)
        {
            if (buttonNumber == 4)
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"1" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"1" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
            }
        }
        else
        {
            currentPage = lastPage;
            if (buttonNumber == 4)
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
            }
            else
            {
                NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
                [objectDic setObject:@"2" forKey:@"number"];
                
                PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
            }
        }
    }
    else
    {
        currentPage = lastPage;
        if (buttonNumber == 4)
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"100" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Master");
        }
        else
        {
            NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
            [objectDic setObject:@"100" forKey:@"number"];
            
            PostNetDelegate(objectDic, @"Ty_OrderVC_MySetting_Worker");
        }

    }

}
#pragma mark 处理相似的网络回调
-(BOOL)handleNetWorkCallBack:(NSMutableDictionary *)_dic
{
    int count = [[_dic objectForKey:@"total"]intValue];
    for (int i = 0; i < count; i ++)
    {
        Ty_Model_XuQiuInfo * xuQiu = [[Ty_Model_XuQiuInfo alloc]init];
        NSDictionary * tempDic = [[NSDictionary alloc]initWithDictionary:[[_dic objectForKey:@"rows"] objectAtIndex:i]];
        
        NSMutableDictionary * reqDictionary = [[NSMutableDictionary alloc]initWithDictionary:[[tempDic objectForKey:@"req"] objectAtIndex:0]];
        
        if ([reqDictionary count]> 0)
        {
            if ([[reqDictionary objectForKey:@"rIsMorE"]intValue] == 0)
            {//这条需求此用户是雇主
                NSArray * empArray = [[NSArray alloc]initWithArray:[tempDic objectForKey:@"emp"]];
                if ([empArray count] != 0)
                {
                    NSDictionary * empDictionary = [[NSDictionary alloc]initWithDictionary:[[tempDic objectForKey:@"emp"] objectAtIndex:0]];
                    
                    if ([empDictionary count] > 0)
                    {
                        xuQiu.serverObject.userType = [empDictionary objectForKey:@"ouType"];
                        if ([xuQiu.serverObject.userType intValue] == 0)
                        {//直接预约的人是中介
                            xuQiu.serverObject.companiesGuid =[empDictionary objectForKey:@"ouGuid"];
                            xuQiu.serverObject.companyUserName = [empDictionary objectForKey:@"ouName"];
                            xuQiu.serverObject.companyPhoto = [empDictionary objectForKey:@"ouPhoto"];
                            xuQiu.serverObject.respectiveCompanies = [empDictionary objectForKey:@"ouRealName"];
                            xuQiu.serverObject.companyPhoneNumber = [empDictionary objectForKey:@"ouDPhone"];
                        }
                        else
                        {
                            xuQiu.serverObject.userGuid =[empDictionary objectForKey:@"ouGuid"];
                            xuQiu.serverObject.userName = [empDictionary objectForKey:@"ouName"];
                            xuQiu.serverObject.headPhoto = [empDictionary objectForKey:@"ouPhoto"];
                            xuQiu.serverObject.userRealName = [empDictionary objectForKey:@"ouRealName"];
                            xuQiu.serverObject.phoneNumber = [empDictionary objectForKey:@"ouDPhone"];
                            xuQiu.serverObject.sex = [empDictionary objectForKey:@"ouSex"];
                            if ([[empDictionary objectForKey:@"ouCompany"] count] != 0)
                            {//中介下的短工
                                xuQiu.serverObject.companiesGuid =[[[empDictionary objectForKey:@"ouCompany"] objectAtIndex:0] objectForKey:@"oucGuid"];
                                xuQiu.serverObject.companyUserName =[[[empDictionary objectForKey:@"ouCompany"] objectAtIndex:0] objectForKey:@"oucName"];
                                xuQiu.serverObject.companyPhoto = [[[empDictionary objectForKey:@"ouCompany"] objectAtIndex:0] objectForKey:@"oucPhoto"];
                                xuQiu.serverObject.respectiveCompanies = [[[empDictionary objectForKey:@"ouCompany"] objectAtIndex:0] objectForKey:@"oucRealName"];
                                xuQiu.serverObject.companyPhoneNumber = [[[empDictionary objectForKey:@"ouCompany"] objectAtIndex:0] objectForKey:@"oucDPhone"];
                            }
                        }
                        xuQiu.userTypeBaseOnRequirement = @"0";//雇主
                        empDictionary = nil;
                    }
                    else
                        return NO;
                }
                else
                    xuQiu.userTypeBaseOnRequirement = @"0";//雇主
            }
            else
            {//这条需求，此用户是雇工
                NSDictionary * masterDictionary = [[NSDictionary alloc]initWithDictionary:[[tempDic objectForKey:@"master"] objectAtIndex:0]];
                if ([masterDictionary count] > 0)
                {
                    xuQiu.publishUserGuid = [masterDictionary objectForKey:@"uGuid"];
                    xuQiu.publishUserName = [masterDictionary objectForKey:@"uName"];
                    xuQiu.publishUsrRealName = [masterDictionary objectForKey:@"uRealName"];
                    xuQiu.publishUserType = [masterDictionary objectForKey:@"uType"];
                    xuQiu.publishUserPhoto =[masterDictionary objectForKey:@"uPhoto"];
                    xuQiu.publishUserPhone = [masterDictionary objectForKey:@"uDPhone"];
                    xuQiu.publishUserSex = [masterDictionary objectForKey:@"uSex"];
                    xuQiu.userTypeBaseOnRequirement = @"1";//雇工
                    masterDictionary = nil;
                }
                else
                    return NO;
            }
        }
        else
        {
            UIAlertView * tempView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络请求出错了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tempView show];
            return NO;
        }
        
        NSArray * tempAddressArray = [[reqDictionary objectForKey:@"rAddress"]componentsSeparatedByString:@"  "];
        /*
        if ([tempAddressArray count] >=5)
        {
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                xuQiu.province = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                xuQiu.province = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
            {
                xuQiu.city = [tempAddressArray objectAtIndex:1];
            }
            else
            {
                xuQiu.city = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
            {
                xuQiu.area = [tempAddressArray objectAtIndex:2];
            }
            else
            {
                xuQiu.area = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
            {
                xuQiu.region = [tempAddressArray objectAtIndex:3];
            }
            else
            {
                xuQiu.region = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:4]]))
            {
                xuQiu.addressDetail = [tempAddressArray objectAtIndex:4];
            }
            else
            {
                xuQiu.addressDetail = @"";
            }
        }
        */
        if ([tempAddressArray count] == 5)
        {
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                xuQiu.province = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                xuQiu.province = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
            {
                xuQiu.city = [tempAddressArray objectAtIndex:1];
            }
            else
            {
                xuQiu.city = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
            {
                xuQiu.area = [tempAddressArray objectAtIndex:2];
            }
            else
            {
                xuQiu.area = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
            {
                xuQiu.region = [tempAddressArray objectAtIndex:3];
            }
            else
            {
                xuQiu.region = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:4]]))
            {
                xuQiu.addressDetail = [tempAddressArray objectAtIndex:4];
            }
            else
            {
                xuQiu.addressDetail = @"";
            }
        }
        else if ([tempAddressArray count] == 4)
        {//因为不要了区域
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                xuQiu.province = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                xuQiu.province = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
            {
                xuQiu.city = [tempAddressArray objectAtIndex:1];
            }
            else
            {
                xuQiu.city = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
            {
                xuQiu.area = [tempAddressArray objectAtIndex:2];
            }
            else
            {
                xuQiu.area = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
            {
                xuQiu.addressDetail = [tempAddressArray objectAtIndex:3];
            }
            else
            {
                xuQiu.addressDetail = @"";
            }
        }
        else if ([tempAddressArray count] == 1)
        {//活动预约现在的bug
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                xuQiu.addressDetail = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                xuQiu.addressDetail = @"";
            }
        }
        else
        {
            xuQiu.province = @"";
            xuQiu.city = @"";
            xuQiu.area = @"";
            xuQiu.region = @"";
            xuQiu.addressDetail = @"";
        }
        xuQiu.contact = [reqDictionary objectForKey:@"rContactName"];
        xuQiu.contactPhone = [reqDictionary objectForKey:@"rContactPhone"];
        xuQiu.requirementGuid = [reqDictionary objectForKey:@"rGuid"];
        xuQiu.candidateStatus =[reqDictionary objectForKey:@"rIsCandidate"];
        xuQiu.requirementNumber = [reqDictionary objectForKey:@"rNumber"];
        xuQiu.submitTime = [reqDictionary  objectForKey:@"rPublishTime"];
        xuQiu.requirement_Stage = [reqDictionary  objectForKey:@"rStage"];
        xuQiu.requirementStageText = [reqDictionary objectForKey:@"rStageText"];
        xuQiu.startTime = [reqDictionary objectForKey:@"rStartTime"];
        xuQiu.workAmount = [reqDictionary objectForKey:@"rTimeStage"];
        xuQiu.requirement_Type = [reqDictionary objectForKey:@"rType"];
        xuQiu.updateTime = [reqDictionary objectForKey:@"rUpdateTime"];
        xuQiu.workGuid = [reqDictionary objectForKey:@"rWGuid"];
        xuQiu.workName = [reqDictionary objectForKey:@"rWName"];
        xuQiu.workPhoto = [reqDictionary objectForKey:@"rWPhoto"];
        xuQiu.employeeCount =[reqDictionary objectForKey:@"rcSize"];
        xuQiu.isApply = [reqDictionary objectForKey:@"rIsPay"];
        xuQiu.priceUnit = [reqDictionary objectForKey:@"rMoney"];
        xuQiu.priceTotal = [reqDictionary objectForKey:@"rDealMoney"];
        
        if (filterButtonTag == -1)
        {
            [xuQiuInfoArray addObject:xuQiu];
        }
        else if (filterButtonTag == 0)
        {
            [canYZxuQiuInfoArray addObject:xuQiu];
        }
        else if (filterButtonTag == 1)
        {
            [waitServiceXuQiuInfoArray addObject:xuQiu];
        }
        else
        {
            [serviceRecordXuQiuInfoArray addObject:xuQiu];
        }

        xuQiu = nil;
    }
    return YES;
}

#pragma mark 应征的人加到数组中
-(BOOL)saveDataToServiceObjectArray:(NSMutableArray *)_array
{
    for (int i = 0; i < [_array count];  i++)
    {
        Ty_Model_ServiceObject * tempServiceObject = [[Ty_Model_ServiceObject alloc]init];
        if ([[[_array objectAtIndex:i] objectForKey:@"userType"] intValue] ==  0)
        {
            tempServiceObject.companiesGuid = [[_array objectAtIndex:i] objectForKey:@"userGuid"];
            tempServiceObject.companyUserName =[[_array objectAtIndex:i] objectForKey:@"userName"];
            tempServiceObject.companyUserAnnear = [[_array objectAtIndex:i]objectForKey:@"userAnnear"];
            tempServiceObject.respectiveCompanies = [[_array objectAtIndex:i] objectForKey:@"userRealName"];
            tempServiceObject.userType = [[_array objectAtIndex:i] objectForKey:@"userType"];
            tempServiceObject.YZQuote = [[_array objectAtIndex:i] objectForKey:@"candidatePrice"];
            tempServiceObject.YZRemark =[[_array objectAtIndex:i] objectForKey:@"candidateRemark"];
            tempServiceObject.YZTime = [[_array objectAtIndex:i] objectForKey:@"candidateTime"];
            tempServiceObject.serviceNumber = [[_array objectAtIndex:i] objectForKey:@"count"];
            tempServiceObject.evaluate = [[_array objectAtIndex:i] objectForKey:@"userEvaluate"];
            tempServiceObject.companyPhoto = [[_array objectAtIndex:i] objectForKey:@"userPhoto"];
            tempServiceObject.sex = [[_array objectAtIndex:i] objectForKey:@"userSex"];
            tempServiceObject.userType = [[_array objectAtIndex:i] objectForKey:@"userType"];
            
        }
        else if ([[[_array objectAtIndex:i] objectForKey:@"userType"] intValue] ==  1)
        {
            tempServiceObject.userGuid = [[_array objectAtIndex:i] objectForKey:@"userGuid"];
            tempServiceObject.userName =[[_array objectAtIndex:i] objectForKey:@"userName"];
            tempServiceObject.companyUserAnnear = [[_array objectAtIndex:i]objectForKey:@"userAnnear"];
            tempServiceObject.userRealName = [[_array objectAtIndex:i] objectForKey:@"userRealName"];
            tempServiceObject.userType = [[_array objectAtIndex:i] objectForKey:@"userType"];
            tempServiceObject.YZQuote = [[_array objectAtIndex:i] objectForKey:@"candidatePrice"];
            tempServiceObject.YZRemark =[[_array objectAtIndex:i] objectForKey:@"candidateRemark"];
            tempServiceObject.YZTime = [[_array objectAtIndex:i] objectForKey:@"candidateTime"];
            tempServiceObject.serviceNumber = [[_array objectAtIndex:i] objectForKey:@"count"];
            tempServiceObject.evaluate = [[_array objectAtIndex:i] objectForKey:@"userEvaluate"];
            tempServiceObject.companyPhoto = [[_array objectAtIndex:i] objectForKey:@"userPhoto"];
            tempServiceObject.sex = [[_array objectAtIndex:i] objectForKey:@"userSex"];
            tempServiceObject.userType = [[_array objectAtIndex:i] objectForKey:@"userType"];
        }
        
        [serviceObjectArray addObject:tempServiceObject];
    }
    return YES;
}

#pragma mark 将中结下的短工加入到array中
-(BOOL)saveEmployeesToServieceObjectArray:(NSMutableArray *)_array
{
    for (int i = 0; i < [_array count];  i++)
    {
        Ty_Model_ServiceObject * tempServiceObject = [[Ty_Model_ServiceObject alloc]init];
        tempServiceObject.userGuid = [[_array objectAtIndex:i] objectForKey:@"userGuid"];
        tempServiceObject.userName =[[_array objectAtIndex:i] objectForKey:@"userRealName"];
        tempServiceObject.sex = [[_array objectAtIndex:i] objectForKey:@"userSex"];
        tempServiceObject.userRealName = [[_array objectAtIndex:i] objectForKey:@"userRealName"];
        tempServiceObject.phoneNumber = [[_array objectAtIndex:i] objectForKey:@"userPhone"];
        tempServiceObject.headPhoto = [[_array objectAtIndex:i] objectForKey:@"userPhoto"];
        [serviceObjectArray addObject:tempServiceObject];
    }
    return YES;
}

#pragma mark //消息
-(UIViewController*)privateButtonPressedandXuQiu:(Ty_Model_XuQiuInfo *)_xuInfo;
{
    MessageVC* messageVC=[[MessageVC alloc]init];
    if ([_xuInfo.userTypeBaseOnRequirement intValue] == 0)
    {//雇主
        if ([_xuInfo.serverObject.userType intValue] == 0)
        {
            messageVC.contactGuid=_xuInfo.serverObject.companiesGuid;
            messageVC.contactName=_xuInfo.serverObject.companyUserName;
            messageVC.contactAnnear=_xuInfo.serverObject.companyUserAnnear;
            messageVC.contactRealName=_xuInfo.serverObject.respectiveCompanies;
            messageVC.contactType=0;
            messageVC.contactSex= 0;
            return messageVC;
        }
        else
        {
            messageVC.contactGuid=_xuInfo.serverObject.companiesGuid;
            messageVC.contactName=_xuInfo.serverObject.companyUserName;
            messageVC.contactAnnear=_xuInfo.serverObject.companyUserAnnear;
            messageVC.contactRealName=_xuInfo.serverObject.respectiveCompanies;
            messageVC.contactType=0;
            messageVC.contactSex=[_xuInfo.serverObject.sex intValue];
            return messageVC;
        }
    }
    else
    {
        messageVC.contactGuid=_xuInfo.publishUserGuid;
        messageVC.contactName=_xuInfo.publishUserName;
        messageVC.contactRealName=_xuInfo.publishUsrRealName;
        messageVC.contactAnnear = _xuInfo.publishUserAnnear;
        messageVC.contactType=1;
        messageVC.contactSex=[_xuInfo.publishUserSex intValue];
        return messageVC;
    }
}


/**实例化页码，以及数组*/
-(void)freshData
{
    hirePersonPage = 1;
    lastHirePersonPage = 1;
    currentPage = 1;
    lastPage = 1;
    filterButtonTag = -1;
    
    xuQiuInfoArray = [[NSMutableArray alloc]init];
    serviceObjectArray = [[NSMutableArray alloc]init];
    YZServiceObject = [[Ty_Model_ServiceObject alloc]init];
    
    
    canYZPage = 1;
    canYZLastPage = 1;
    canYZPage = 1;
    waitServiceLastPage = 1;
    serviceRecordPage = 1;
    serviceRecordLastPage = 1;
    
    canYZxuQiuInfoArray = [[NSMutableArray alloc]init];
    waitServiceXuQiuInfoArray = [[NSMutableArray alloc]init];
    serviceRecordXuQiuInfoArray = [[NSMutableArray alloc]init];
}
/**将当前页码置为空*/
-(void)freshPage
{
    currentPage = 1;
    hirePersonPage = 1;
    
    canYZPage = 1;
    waitServicePage = 1;
    serviceRecordPage = 1;
}
-(void)freshArrayWithButtonTag:(int)tag
{
    [xuQiuInfoArray removeAllObjects];
    [canYZxuQiuInfoArray removeAllObjects];
    [waitServiceXuQiuInfoArray removeAllObjects];
    [serviceRecordXuQiuInfoArray removeAllObjects];

}
@end
