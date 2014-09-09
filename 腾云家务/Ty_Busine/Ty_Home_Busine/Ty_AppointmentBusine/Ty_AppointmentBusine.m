//
//  Ty_AppointmentBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_AppointmentBusine.h"
#import "Ty_Model_WorkListInfo.h"
@implementation Ty_AppointmentBusine
//@synthesize selectworkGuid,selectworkName;
@synthesize userService,xuqiuInfo;
@synthesize home_userDetailType;
- (instancetype)init
{
    self = [super init];
    if (self) {
        userService = [[Ty_Model_ServiceObject alloc]init];
        xuqiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
        home_userDetailType = Ty_Home_UserDetailTypeDefault;
        xuqiuInfo.contact = MyLoginUserRealName;
        xuqiuInfo.contactPhone = MyLoginUserPhone;
        xuqiuInfo.requirement_Type = @"1";
    }
    return self;
}
#pragma mark ----获取个人信息
-(void)loadDatatarget
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[xuqiuInfo.selectUserArray[0] userGuid],@"userGuid",MyLoginUserGuid,@"myUserGuid",nil];
    [[Ty_NetRequestService shareNetWork] formRequest:EmployeeDetailUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveUserDetailInfo: dic:)];
}
#pragma mark ---- 个人信息网络回调
-(void)ReceiveUserDetailInfo:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            [[xuqiuInfo.selectUserArray[0] workTypeArray] removeAllObjects];
            NSDictionary* rowDic = [[_dic objectForKey:@"rows"] objectAtIndex:0];
                
                for (int i = 0; i<[[rowDic objectForKey:@"userServe"]count]; i++) {
                    Ty_Model_WorkListInfo* worktype = [[Ty_Model_WorkListInfo alloc]init];
                    worktype.workGuid = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workGuid"];
                    worktype.workName = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"workName"];
                    worktype.postSalary = [[[rowDic objectForKey:@"userServe"] objectAtIndex:i] objectForKey:@"postSalary"];
                    worktype.specialty = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"specialty"];
                    worktype.experience = [[[rowDic objectForKey:@"userServe"]objectAtIndex:i] objectForKey:@"workE"];
                    [[xuqiuInfo.selectUserArray[0] workTypeArray] addObject:worktype];
                }
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"个人信息",@"message",nil];
            PostNetDelegate(d,@"Ty_AppointmentVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 203){
//            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",@"个人信息",@"type",nil];
//            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 202){
//            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"202",@"code",@"个人信息",@"type",nil];
//            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 404){
//            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"404",@"code",@"个人信息",@"type",nil];
//            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 201){
//            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"201",@"code",@"个人信息",@"type",nil];
//            PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        }
    }else{
//        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"个人信息",@"type",nil];
//        PostNetDelegate(d,@"Ty_Home_UserDetailVC");
        [self loadDatatarget];
    }
}

-(void)pub_Appointment
{
    if ([xuqiuInfo.workName isEqualToString:@""]) {
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请选择服务类型",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if ([xuqiuInfo.area isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请选择所在区域",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if ([xuqiuInfo.addressDetail isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写详细地址",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if(xuqiuInfo.addressDetail.length<5){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"详细地址不能少于5字",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if([xuqiuInfo.startTime isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请选择服务时间",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if([xuqiuInfo.workAmount isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写工作量",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if([xuqiuInfo.contact isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写联系人",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if(xuqiuInfo.contactPhone.length!= 11){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写正确的手机号",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else{
        Guid *guid = [[Guid alloc]init];
        xuqiuInfo.requirementGuid = [guid getGuid];
        NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
        [dic setObject:MyLoginUserGuid forKey:@"userGuid"];
        [dic setObject:xuqiuInfo.workGuid forKey:@"workGuid"];
        if (![xuqiuInfo.usedCouponInfo.couponGuid isEqualToString:@""]) {
            [dic setObject:xuqiuInfo.usedCouponInfo.couponGuid forKey:@"requirementCouponGuid"];
        }
        [dic setObject:xuqiuInfo.ask_Other forKey:@"askOther"];
        [dic setObject:xuqiuInfo.contact forKey:@"requirementContactName"];
        [dic setObject:xuqiuInfo.contactPhone forKey:@"requirementContactPhone"];
        [dic setObject:[NSString stringWithFormat:@"%@:00",xuqiuInfo.startTime] forKey:@"requirementStartTime"];
        [dic setObject:xuqiuInfo.workAmount forKey:@"requirementTimeStage"];
        [dic setObject:[NSString stringWithFormat:@"%@  %@  %@  %@",xuqiuInfo.province,xuqiuInfo.city,xuqiuInfo.area,xuqiuInfo.addressDetail] forKey:@"requirementAddress"];
        [dic setObject:xuqiuInfo.requirement_Type forKey:@"requirementType"];
        [dic setObject:xuqiuInfo.requirementGuid forKey:@"requirementGuid"];
        
        if (xuqiuInfo.selectUserArray.count>0) {
            [dic setObject:[[xuqiuInfo.selectUserArray objectAtIndex:0] userGuid] forKey:@"orderUserGuidBuffer"];
        }
        
        [dic setObject:@"1" forKey:@"requirementType"];
        if ([userService.userType isEqualToString:@"2"]) {
            [dic setObject:userService.userGuid forKey:@"requirementOrderUserGuid"];
        }else{
            [dic setObject:userService.companiesGuid forKey:@"requirementOrderUserGuid"];
        }
        [dic setObject:xuqiuInfo.requirementGuid forKey:@"requirementGuid"];
        
        [[Ty_NetRequestService shareNetWork] formRequest:AddRequirementUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveHomeInfo:dic:)];
    }
}
-(void)ReceiveHomeInfo:(NSString* )_isSuccess dic:(NSMutableDictionary*)_dic
{
    if ([_isSuccess isEqualToString:REQUESTFAIL]) {
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"网络错误",@"message",nil];
        PostNetDelegate(d,@"Ty_AppointmentVC");
    }else if([_isSuccess isEqualToString:REQUESTSUCCESS]){
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            
            SETUSERAREA(xuqiuInfo.area);
            SETUSERADDRESSDETAIL(xuqiuInfo.addressDetail);
            
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTSUCCESS,@"code",@"发布成功",@"message",nil];
            PostNetDelegate(d,@"Ty_AppointmentVC");
        }else{
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"发布失败",@"message",nil];
            PostNetDelegate(d,@"Ty_AppointmentVC");
        }
    }
}

@end
