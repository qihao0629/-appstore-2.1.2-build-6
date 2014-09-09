//
//  Ty_Home_UserDetail_selectUsersBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_UserDetail_selectUsersBusine.h"
#import "Ty_Model_WorkListInfo.h"
#import "Ty_Home_UserDetailVC.h"
#import "Ty_AppointmentVC.h"
@implementation Ty_Home_UserDetail_selectUsersBusine
@synthesize _selectWorkGuid,_selectWorkName,userService,currentPage,_isRefreshing,xuqiuInfo;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectWorkGuid = @"";
        _selectWorkName = @"";
        userService = [[Ty_Model_ServiceObject alloc]init];
        xuqiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
        currentPage = 1;
        
    }
    return self;
}
#pragma mark ----根据工种获取中介下员工
-(void)loadUsers{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userService.companiesGuid,@"userGuid",_selectWorkGuid,@"workGuid",pageSize_Req,@"pageSize",[NSString stringWithFormat:@"%d",currentPage],@"currentPage",nil];
    [[Ty_NetRequestService shareNetWork] formRequest:Ty_UserDetail_UserUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveUsers:dic:)];
}
#pragma mark ----根据工种获取中介下员工 网络回调
-(void)ReceiveUsers:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            currentPage++;
            NSMutableArray* array = [_dic objectForKey:@"rows"];
            for (int i = 0;i<array.count; i++) {
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
            PostNetDelegate(d,@"Ty_Home_UserDetail_selectUsersBusine");
        }else if([[_dic objectForKey:
                @"code"]intValue] == 203){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",@"员工信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetail_selectUsersBusine");
        }else if([[_dic objectForKey:@"code"]intValue] == 202){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"202",@"code",@"员工信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetail_selectUsersBusine");
        }else if([[_dic objectForKey:@"code"]intValue] == 404){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"404",@"code",@"员工信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetail_selectUsersBusine");
        }
    }else{
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"员工信息",@"type",nil];
        PostNetDelegate(d,@"Ty_Home_UserDetail_selectUsersBusine");
    }
}
-(void)selectUser:(int)sender
{
    [xuqiuInfo.selectUserArray addObject:[userService.UserArray objectAtIndex:sender]];
    if ([[[userService.UserArray objectAtIndex:sender] workTypeArray] count] > 0) {
        xuqiuInfo.priceUnit = [[[[userService.UserArray objectAtIndex:sender] workTypeArray] objectAtIndex:0] postSalary];
    }
}
-(UIViewController*)appointMentUsersAction:(int)sender
{
    Ty_AppointmentVC* appointMentVC = [[Ty_AppointmentVC alloc]init];
    appointMentVC.appointMentBusine.xuqiuInfo.workName = self._selectWorkName;
    appointMentVC.appointMentBusine.xuqiuInfo.workGuid = self._selectWorkGuid;
    appointMentVC.appointMentBusine.userService = [userService copy];
    [appointMentVC.appointMentBusine.xuqiuInfo.selectUserArray addObject:[userService.UserArray objectAtIndex:sender]];
    if ([[[userService.UserArray objectAtIndex:sender] workTypeArray] count] > 0) {
        appointMentVC.appointMentBusine.xuqiuInfo.priceUnit = [[[[userService.UserArray objectAtIndex:sender] workTypeArray] objectAtIndex:0] postSalary];
    }
    appointMentVC.title = @"预约下单";
    return appointMentVC;
}
-(UIViewController*)usersDetail:(int)sender home_DetailType:(enum Ty_Home_UserDetailType)_Ty_Home_UserDetailType
{
    Ty_Home_UserDetailVC* userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
    [userDetailVC Home_UserDetail:_Ty_Home_UserDetailType];
    userDetailVC.userDetailBusine.userService = [userService.UserArray objectAtIndex:sender];
    userDetailVC.userDetailBusine._selectWorkGuid = _selectWorkGuid;
    userDetailVC.userDetailBusine._selectWorkName = _selectWorkName;
    if (_Ty_Home_UserDetailType == Ty_Home_UserDetailTypeSelect) {
        userDetailVC.userDetailBusine.xuqiuInfo = xuqiuInfo;
    }
    return userDetailVC;
}
@end
