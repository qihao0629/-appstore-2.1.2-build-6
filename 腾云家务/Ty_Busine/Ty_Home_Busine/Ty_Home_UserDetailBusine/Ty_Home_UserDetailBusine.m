//
//  Ty_Home_UserDetailBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_UserDetailBusine.h"
#import "Ty_Model_WorkListInfo.h"
#import "Ty_Home_UserDetail_selectUsersVC.h"
#import "Ty_Home_UserDetail_moreEvaluationVC.h"
#import "Ty_AppointmentVC.h"
#import "Ty_Home_UserDetailVC.h"
#import "MessageVC.h"

#import "Ty_MapHomeUserDetailVC.h"
#import "Ty_MapGlobalSingleton.h"
@implementation Ty_Home_UserDetailBusine
@synthesize userService,xuqiuInfo,_selectWorkGuid,_selectWorkName,coupon;
- (instancetype)init
{
    self = [super init];
    if (self) {
        userService = [[Ty_Model_ServiceObject alloc] init];
        xuqiuInfo = [[Ty_Model_XuQiuInfo alloc] init];
        coupon = [[My_CouponDetailedModel alloc] init];
        _selectWorkName = @"";
        _selectWorkGuid = @"";
    }
    return self;
}
#pragma mark ----获取个人信息
-(void)loadDatatarget
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[userService.userGuid isEqualToString:@""]?userService.companiesGuid:userService.userGuid,@"userGuid",MyLoginUserGuid,@"myUserGuid",nil];
    [[Ty_NetRequestService shareNetWork] formRequest:EmployeeDetailUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveUserDetailInfo: dic:)];
}
#pragma mark ---- 个人信息网络回调
-(void)ReceiveUserDetailInfo:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            [userService.workTypeArray removeAllObjects];
            NSDictionary* rowDic = [[_dic objectForKey:@"rows"] objectAtIndex:0];
            userService.userType = [rowDic objectForKey:@"userType"];
            if ([userService.userType isEqualToString:@"0"]) {
                userService.respectiveCompanies = [rowDic objectForKey:@"intermediaryName"];
                userService.companyUserName = [rowDic objectForKey:@"userName"];
                userService.serviceNumber = [rowDic objectForKey:@"userServeSize"];
                userService.evaluate = [rowDic objectForKey:@"userEvaluateEmployee"];
                userService.intermediaryBusinessTime = [rowDic objectForKey:@"intermediaryBusinessTime"];
                userService.intermediaryResponsiblePerson = [rowDic objectForKey:@"intermediaryResponsiblePerson"];
                userService.intermediary_Area = [rowDic objectForKey:@"intermediaryArea"];
                userService.intermediary_AddressDetail = [rowDic objectForKey:@"intermediaryAddress"];
                userService.intermediaryResponsiblePersonPhone = [rowDic objectForKey:@"intermediaryPhone"];
                userService.keep = [[rowDic objectForKey:@"contactStatus"] boolValue];
                userService.companyUserAnnear=[rowDic objectForKey:@"userAnnear"];
                userService.latitude = [rowDic objectForKey:@"lat"];
                userService.longitude = [rowDic objectForKey:@"lng"];
                userService.introductionString = [rowDic objectForKey:@"intermediaryOtherInfo"];
                userService.headPhoto = [rowDic objectForKey:@"userPhoto"];
                
                userService.headPhotoGaoQing = [rowDic objectForKey:@"userBigPhoto"];
                userService.companiesGuid = [rowDic objectForKey:@"userGuid"];
                
                for (int i = 0; i<[[rowDic objectForKey:@"userServe"]count]; i++) {
                    Ty_Model_WorkListInfo* worktype = [[Ty_Model_WorkListInfo alloc]init];
                    worktype.workGuid = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workGuid"];
                    worktype.workName = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workName"];
                    worktype.postSalary = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"postSalary"];
                    worktype.specialty = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"specialty"];
                    worktype.experience = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"workE"];
                    [userService.workTypeArray addObject:worktype];
                }
                if (![userService.userType isEqualToString:@"0"]) {
                    if ([_selectWorkName isEqualToString:@""]) {
                        if (userService.workTypeArray.count>0) {
                            _selectWorkName = [[userService.workTypeArray objectAtIndex:0] workName];
                            _selectWorkGuid = [[userService.workTypeArray objectAtIndex:0] workGuid];
                        }
                    }

                }
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"个人信息",@"type",userService.userType,@"userType",nil];
                NSLog(@"%@",self.delegate);
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
                
                [self loadUser];
                [self loadEvaluationData:userService.companiesGuid];
                
            }else if([userService.userType isEqualToString:@"1"]){
                userService.respectiveCompanies = [rowDic objectForKey:@"userCompany"];
                userService.serviceNumber = [rowDic objectForKey:@"userServeSize"];
                userService.evaluate = [rowDic objectForKey:@"userEvaluateEmployee"];
                userService.userGuid = [rowDic objectForKey:@"userGuid"];
                userService.headPhoto = [rowDic objectForKey:@"userPhoto"];
                userService.companyUserAnnear=[rowDic objectForKey:@"userAnnear"];
                NSRange range;
                range.location = 0;
                range.length = 10;
                
                NSRange range2;
                range2.location = 14;
                range2.length = 4;
                
                NSRange range3;
                range3.location = 0;
                range3.length = 8;
                
                NSRange range4;
                range4.location = 12;
                range4.length = 3;
                
                if ([[rowDic objectForKey:@"detailIdcard"]length] == 18) {
                    userService.idCard = [NSString stringWithFormat:@"%@xxxx%@",[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range],[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range2]];
                }
                if ([[rowDic objectForKey:@"detailIdcard"] length] == 15) {
                    userService.idCard = [NSString stringWithFormat:@"%@xxxx%@",[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range3],[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range4]];
                }
                
                userService.companiesGuid = [rowDic objectForKey:@"userCompanyGuid"];
                userService.sex = [rowDic objectForKey:@"userSex"];
                userService.age = [rowDic objectForKey:@"userAge"];
                userService.hometown = [rowDic objectForKey:@"detailCensus"];
                userService.keep = [[rowDic objectForKey:@"contactStatus"] boolValue];
                userService.latitude = [rowDic objectForKey:@"lat"];
                userService.longitude = [rowDic objectForKey:@"lng"];
                userService.userRealName = [rowDic objectForKey:@"userRealName"];
                userService.companyUserName = [rowDic objectForKey:@"userCompanyUserName"];
                
                userService.education = [rowDic objectForKey:@""];
                userService.addressDetail = [rowDic objectForKey:@"userAddressDetail"];
                
                userService.headPhotoGaoQing = [rowDic objectForKey:@"userBigPhoto"];
                
                userService.detailOtherInfo = [rowDic objectForKey:@"detailOtherInfo"];
                
                for (int i = 0; i<[[rowDic objectForKey:@"userServe"]count]; i++) {
                    Ty_Model_WorkListInfo* worktype = [[Ty_Model_WorkListInfo alloc]init];
                    worktype.workGuid = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workGuid"];
                    worktype.workName = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workName"];
                    worktype.postSalary = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"postSalary"];
                    worktype.specialty = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"specialty"];
                    worktype.experience = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"workE"];
                    [userService.workTypeArray addObject:worktype];
                }
                if ([_selectWorkName isEqualToString:@""]) {
                    if (userService.workTypeArray.count>0) {
                        _selectWorkName = [[userService.workTypeArray objectAtIndex:0] workName];
                        _selectWorkGuid = [[userService.workTypeArray objectAtIndex:0] workGuid];
                    }
                }
                
                
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"个人信息",@"type",userService.userType,@"userType",nil];
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
                
                [self loadEvaluationData:userService.userGuid];

            }else{
                userService.serviceNumber = [rowDic objectForKey:@"userServeSize"];
                userService.evaluate = [rowDic objectForKey:@"userEvaluateEmployee"];
                userService.userGuid = [rowDic objectForKey:@"userGuid"];
                userService.numTemper=[rowDic objectForKey:@"userAnnear"];
                userService.userName = [rowDic objectForKey:@"userName"];
                userService.headPhoto = [rowDic objectForKey:@"userPhoto"];
                NSRange range;
                range.location = 0;
                range.length = 10;
                
                NSRange range2;
                range2.location = 14;
                range2.length = 4;
                
                NSRange range3;
                range3.location = 0;
                range3.length = 8;
                
                NSRange range4;
                range4.location = 12;
                range4.length = 3;
                if ([[rowDic objectForKey:@"detailIdcard"]length] == 18) {
                    userService.idCard = [NSString stringWithFormat:@"%@xxxx%@",[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range],[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range2]];
                }
                if ([[rowDic objectForKey:@"detailIdcard"] length] == 15) {
                    userService.idCard = [NSString stringWithFormat:@"%@xxxx%@",[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range3],[[rowDic objectForKey:@"detailIdcard"] substringWithRange:range4]];
                }
                
                userService.sex = [rowDic objectForKey:@"userSex"];
                userService.age = [rowDic objectForKey:@"userAge"];
                userService.hometown = [rowDic objectForKey:@"detailCensus"];
                userService.keep = [[rowDic objectForKey:@"contactStatus"] boolValue];
                userService.latitude = [rowDic objectForKey:@"lat"];
                userService.longitude = [rowDic objectForKey:@"lng"];
                userService.userRealName = [rowDic objectForKey:@"userRealName"];
                
                userService.education = [rowDic objectForKey:@""];
                userService.addressDetail = [rowDic objectForKey:@"userAddressDetail"];
                
                userService.headPhotoGaoQing = [rowDic objectForKey:@"userBigPhoto"];
                userService.phoneNumber = [rowDic objectForKey:@"userPhone"];
                userService.detailOtherInfo = [rowDic objectForKey:@"detailOtherInfo"];
                
                for (int i = 0; i<[[rowDic objectForKey:@"userServe"]count]; i++) {
                    Ty_Model_WorkListInfo* worktype = [[Ty_Model_WorkListInfo alloc]init];
                    worktype.workGuid = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workGuid"];
                    worktype.workName = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workName"];
                    worktype.postSalary = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"postSalary"];
                    worktype.specialty = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"specialty"];
                    worktype.experience = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"workE"];
                    [userService.workTypeArray addObject:worktype];
                }
                if ([_selectWorkName isEqualToString:@""]) {
                    if (userService.workTypeArray.count>0) {
                        _selectWorkName = [[userService.workTypeArray objectAtIndex:0] workName];
                        _selectWorkGuid = [[userService.workTypeArray objectAtIndex:0] workGuid];
                    }
                }
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"个人信息",@"type",userService.userType,@"userType",nil];
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
                [self loadEvaluationData:userService.userGuid];
            }
            
            
        }else if ([[_dic objectForKey:@"code"] intValue] == 203){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",@"个人信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 202){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"202",@"code",@"个人信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 404){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"404",@"code",@"个人信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 201){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"201",@"code",@"个人信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }
    }else{
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"个人信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
    }
}
#pragma mark ----根据工种获取中介下员工
-(void)loadUser{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userService.companiesGuid,@"userGuid",_selectWorkGuid,@"workGuid",@"5",@"pageSize",@"1",@"currentPage",nil];
    [[Ty_NetRequestService shareNetWork] formRequest:Ty_UserDetail_UserUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveUsers:dic:)];
}
#pragma mark ----根据工种获取中介下员工 网络回调
-(void)ReceiveUsers:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            [userService.UserArray removeAllObjects];
            NSMutableArray* array = [_dic objectForKey:@"rows"];
            for (int i = 0;i<array.count  ; i++) {
                NSMutableDictionary* dic = [array objectAtIndex:i];
                Ty_Model_ServiceObject* service = [[Ty_Model_ServiceObject alloc]init];
                service.userGuid = [dic objectForKey:@"userGuid"];
                service.userRealName = [dic objectForKey:@"userRealName"];
                service.headPhoto = [dic objectForKey:@"userPhoto"];
                service.evaluate = [dic objectForKey:@"userEvaluateEmployee"];
                service.userType = @"1";
                service.sex = [dic objectForKey:@"userSex"];
                
                for (int i = 0; i<[[dic objectForKey:@"userPost"] count]; i++) {
                    Ty_Model_WorkListInfo* worktype = [[Ty_Model_WorkListInfo alloc]init];
                    worktype.workGuid = [[[dic objectForKey:@"userPost"] objectAtIndex:i] objectForKey:@"workGuid"];
                    worktype.workName = [[[dic objectForKey:@"userPost"] objectAtIndex:i] objectForKey:@"workName"];
                    worktype.postSalary = [[[dic objectForKey:@"userPost"] objectAtIndex:i] objectForKey:@"postSalary"];
                    worktype.specialty = [[[dic objectForKey:@"userPost"] objectAtIndex:i] objectForKey:@"specialty"];
                    worktype.experience = [[[dic objectForKey:@"userPost"] objectAtIndex:i] objectForKey:@"workE"];
                    [service.workTypeArray addObject:worktype];
                }
                [userService.UserArray addObject:service];
            }
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"员工信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"]intValue] == 203) {
            [userService.UserArray removeAllObjects];
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",@"员工信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }
    }
}
#pragma mark ----历史评价信息联网获取
-(void)loadEvaluationData:(NSString*)_userGuid
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_userGuid,@"userGuid",@"5",@"pageSize",@"1",@"currentPage",nil];
    
    [[Ty_NetRequestService shareNetWork] formRequest:Ty_UserDetail_EvaluateUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveEvaluations:dic:)];
}
#pragma mark ----历史评价信息联网获取回调
-(void)ReceiveEvaluations:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            [userService.evaluationArray removeAllObjects];
            for (int i = 0; i<[[_dic objectForKey:@"rows"] count]; i++) {
                NSDictionary* dic = [[NSDictionary alloc]init];
                dic = [[_dic objectForKey:@"rows"] objectAtIndex:i];
                
                Ty_Model_ServiceObject* evaluate = [[Ty_Model_ServiceObject alloc]init];
                evaluate.headPhoto = [dic objectForKey:@"userPhoto"];
                evaluate.evaluate = [dic objectForKey:@"userEvaluateMaster"];
                evaluate.quality = [dic objectForKey:@"evaluateServeQuality"];
                evaluate.attitude = [dic objectForKey:@"evaluateServeAttitude"];
                evaluate.speedStr = [dic objectForKey:@"evaluateServeSpeed"];
                evaluate.pingjiaString = [dic objectForKey:@"evaluateForEmployeeOther"];
                [userService.evaluationArray addObject:evaluate];
            }
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"评价信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"]intValue] == 203){
            [userService.evaluationArray removeAllObjects];
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",@"评价信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }
    }
}
#pragma mark ----//预约下单
-(UIViewController*)appointMentAction:(enum Ty_Home_UserDetailType)_ty_home_UserDetailType
{
    if (_ty_home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        [xuqiuInfo.selectUserArray addObject:userService];
        for (int i = 0; i<[userService.workTypeArray count]; i++) {
            if ([_selectWorkName isEqualToString:[[userService.workTypeArray objectAtIndex:i] workName]]) {
                xuqiuInfo.priceUnit = [[userService.workTypeArray objectAtIndex:i] postSalary];
            }
        }
        return nil;
    }else{
        Ty_AppointmentVC* appointMentVC = [[Ty_AppointmentVC alloc]init];
        appointMentVC.appointMentBusine.xuqiuInfo.workName = self._selectWorkName;
        appointMentVC.appointMentBusine.xuqiuInfo.workGuid = self._selectWorkGuid;
        
        if (_ty_home_UserDetailType == Ty_Home_UserDetailTypeCoupon) {
            appointMentVC.appointMentBusine.home_userDetailType = _ty_home_UserDetailType;
            appointMentVC.appointMentBusine.xuqiuInfo.usedCouponInfo = [self.coupon copy];
        }
        if ([userService.userType isEqualToString:@"1"]) {
            appointMentVC.appointMentBusine.userService.companiesGuid = userService.companiesGuid;
            appointMentVC.appointMentBusine.userService.userType = @"0";
            appointMentVC.appointMentBusine.userService.respectiveCompanies = userService.respectiveCompanies;
            appointMentVC.appointMentBusine.userService.workTypeArray = userService.workTypeArray;
            [appointMentVC.appointMentBusine.xuqiuInfo.selectUserArray addObject:userService];
        }else{
            appointMentVC.appointMentBusine.userService = [userService copy];

        }
        for (int i = 0; i<[userService.workTypeArray count]; i++) {
            if ([_selectWorkName isEqualToString:[[userService.workTypeArray objectAtIndex:i] workName]]) {
                appointMentVC.appointMentBusine.xuqiuInfo.priceUnit = [[userService.workTypeArray objectAtIndex:i] postSalary];
            }
        }
        appointMentVC.title = @"预约下单";
        return appointMentVC;
    }
}
-(UIViewController*)appointMentUsersAction:(int)sender
{
    Ty_AppointmentVC* appointMentVC = [[Ty_AppointmentVC alloc]init];
    appointMentVC.appointMentBusine.xuqiuInfo.workName = self._selectWorkName;
    appointMentVC.appointMentBusine.xuqiuInfo.workGuid = self._selectWorkGuid;
    appointMentVC.appointMentBusine.userService = [userService copy];
    [appointMentVC.appointMentBusine.xuqiuInfo.selectUserArray addObject:[[userService.UserArray objectAtIndex:sender] copy]];
    appointMentVC.title = @"预约下单";
    for (int i = 0; i<[[[userService.UserArray objectAtIndex:sender] workTypeArray] count]; i++) {
        if ([_selectWorkName isEqualToString:[[[[userService.UserArray objectAtIndex:sender] workTypeArray] objectAtIndex:i] workName]]) {
            appointMentVC.appointMentBusine.xuqiuInfo.priceUnit = [[[[userService.UserArray objectAtIndex:sender] workTypeArray] objectAtIndex:i]postSalary];
        }
    }
    return appointMentVC;
}
#pragma mark ----//更多员工
-(UIViewController*)moreUsersAction:(enum Ty_Home_UserDetailType)_home_userDetailType
{
    Ty_Home_UserDetail_selectUsersVC* selectVc = [[Ty_Home_UserDetail_selectUsersVC alloc] init];
    [selectVc Home_UserDetail:_home_userDetailType];
    selectVc.title = @"签约员工";
    
    selectVc.selectUsersBusine._selectWorkName = _selectWorkName;
    selectVc.selectUsersBusine._selectWorkGuid = _selectWorkGuid;
    selectVc.selectUsersBusine.userService = [userService copy];
    
    return selectVc;
}
#pragma mark ----//更多评价
-(UIViewController*)moreEvaluation
{
    Ty_Home_UserDetail_moreEvaluationVC* moreEvaluationVC = [[Ty_Home_UserDetail_moreEvaluationVC alloc]init];
    moreEvaluationVC.moreEvaluationBusine.userService = [userService copy];
    return moreEvaluationVC;
}
#pragma mark ----//点击某一服务（工种）
-(void)clickWorkType:(NSInteger)_index
{
    self._selectWorkGuid = [[userService.workTypeArray objectAtIndex:_index] workGuid];
    self._selectWorkName = [[userService.workTypeArray objectAtIndex:_index] workName];
    [self loadDatatarget];
}
#pragma mark ----//点击某位员工
-(UIViewController*)clickUsers:(NSInteger)_index Home_UserDetailType:(enum Ty_Home_UserDetailType)_home_UserDetailType
{
    Ty_Home_UserDetailVC* userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
    [userDetailVC Home_UserDetail:_home_UserDetailType];
    userDetailVC.userDetailBusine._selectWorkName = [self._selectWorkName copy];
    userDetailVC.userDetailBusine._selectWorkGuid = [self._selectWorkGuid copy];
    userDetailVC.userDetailBusine.userService = [[userService.UserArray objectAtIndex:_index] copy];
    return userDetailVC;
}
#pragma mark ----//地图
-(UIViewController*)addressForMap
{
//    Ty_MapBasicViewController * mapView = [[Ty_MapBasicViewController alloc]init];
//    mapView.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
//    mapView.fromClass = @"Ty_Home_UserDetailBusine";
//    mapView.strTitle = @"地图";
//    mapView.userService=[self.userService copy];
    
    Ty_MapHomeUserDetailVC * mapHome = [[Ty_MapHomeUserDetailVC alloc]init];
    mapHome.title = @"地图";
    mapHome.userService = self.userService;
    mapHome._mapView = [[Ty_MapGlobalSingleton sharedInstance] mapView];
    
    return mapHome;
}
#pragma mark ----//消息
-(UIViewController*)clickMessage
{
    MessageVC* messageVC = [[MessageVC alloc]init];
    if ([userService.userType isEqualToString:@"2"]) {
        messageVC.contactGuid = userService.userGuid;
        messageVC.contactAnnear=userService.numTemper;
        messageVC.contactName = userService.userName;
        
        messageVC.contactRealName = userService.userRealName;
        messageVC.contactType = 1;
        messageVC.contactSex = [userService.sex intValue];
        return messageVC;
    }else if([userService.userType isEqualToString:@"1"]){
        messageVC.contactGuid = userService.companiesGuid;
        messageVC.contactName = userService.companyUserName;
        messageVC.contactRealName = userService.respectiveCompanies;
        messageVC.contactType = 0;
        messageVC.contactAnnear=userService.companyUserAnnear;
        messageVC.contactSex = [userService.sex intValue];
        return messageVC;
    }else{
        messageVC.contactGuid = userService.companiesGuid;
        messageVC.contactName = userService.companyUserName;
        messageVC.contactAnnear=userService.companyUserAnnear;
        messageVC.contactRealName = userService.respectiveCompanies;
        messageVC.contactType = 0;
        messageVC.contactSex = [userService.sex intValue];
        return messageVC;
    }
}

#pragma mark ----关注与取消
-(void)setAddUser
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    if ([userService.userType isEqualToString:@"0"]) {
        [dic setObject:userService.companiesGuid forKey:@"userLinkGuid"];
    }else{
        [dic setObject:userService.userGuid forKey:@"userLinkGuid"];
    }
    [dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [dic setObject:[NSString stringWithFormat:@"%d",userService.keep] forKey:@"contactType"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:AddUserUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceivePayAttentionTo:dic:)];
}
#pragma mark ----关注与取消网络回调
-(void)ReceivePayAttentionTo:(NSString*)_isSuccess dic:(NSMutableDictionary*)_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            userService.keep = !userService.keep;
            if (userService.keep) {
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"关注成功",@"code",@"关注",@"type",nil];
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
            }else{
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"取消关注成功",@"code",@"关注",@"type",nil];
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
            }
            
        }else if([[_dic objectForKey:@"code"] intValue] == 3004){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"3004",@"code",@"关注",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if([[_dic objectForKey:@"code"] intValue] == 3005){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"3005",@"code",@"关注",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else{
            if(userService.keep){
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"取消关注失败",@"code",@"关注",@"type",nil];
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
            }else{
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"关注失败",@"code",@"关注",@"type",nil];
                PostNetDelegate(d,@"Ty_Home_UserDetailVC");
            }
        }
    }else{
        if (userService.keep) {
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"取消关注失败",@"code",@"关注",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");

        }else{
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"关注失败，请检查网络",@"code",@"关注",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }
    }
}
@end
