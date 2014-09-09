//
//  Ty_Pub_RequirementsBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_RequirementsBusine.h"

@implementation Ty_Pub_RequirementsBusine
@synthesize xuqiuInfo;
- (instancetype)init
{
    self = [super init];
    if (self) {
        xuqiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
        xuqiuInfo.contact = MyLoginUserRealName;
        xuqiuInfo.contactPhone = MyLoginUserPhone;
        if (Req_WorkGuid!=nil) {
            xuqiuInfo.workGuid=Req_WorkGuid;
        }
        if (Req_WorkName!=nil) {
            xuqiuInfo.workName=Req_WorkName;
        }
        if (Req_WorkAmount!=nil) {
            xuqiuInfo.workAmount=Req_WorkAmount;
        }
        xuqiuInfo.requirement_Type = @"0";
    }
    return self;
}
-(void)pub_Requirements
{
    if ([xuqiuInfo.workName isEqualToString:@""]) {
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请选择服务类型",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if ([xuqiuInfo.area isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请选择所在区域",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if ([xuqiuInfo.addressDetail isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写详细地址",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if(xuqiuInfo.addressDetail.length<5){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"详细地址不能少于5字",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if([xuqiuInfo.startTime isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请选择服务时间",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if([xuqiuInfo.workAmount isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写工作量",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if([xuqiuInfo.contact isEqualToString:@""]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写联系人",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if(xuqiuInfo.contactPhone.length!= 11){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"请填写正确的手机号",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
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
        
        [[Ty_NetRequestService shareNetWork] formRequest:AddRequirementUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveHomeInfo:dic:)];
    }
}
-(void)ReceiveHomeInfo:(NSString* )_isSuccess dic:(NSMutableDictionary*)_dic
{
    if ([_isSuccess isEqualToString:REQUESTFAIL]) {
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"网络错误",@"message",nil];
        PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
    }else if([_isSuccess isEqualToString:REQUESTSUCCESS]){
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            
            SETUSERAREA(xuqiuInfo.area);
            SETUSERADDRESSDETAIL(xuqiuInfo.addressDetail);
            SetReq_WorkGuid(xuqiuInfo.workGuid);
            SetReq_WorkName(xuqiuInfo.workName);
            SetReq_WorkAmount(xuqiuInfo.workAmount);
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTSUCCESS,@"code",@"发布成功",@"message",nil];
            PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
        }else{
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"发布失败",@"message",nil];
            PostNetDelegate(d,@"Ty_Pub_RequirementsVC");
        }
    }
}
@end
