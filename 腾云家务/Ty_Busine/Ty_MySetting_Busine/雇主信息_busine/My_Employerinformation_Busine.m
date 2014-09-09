//
//  My_Employerinformation_Busine.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//雇主信息
#import "My_Employerinformation_Busine.h"

@implementation My_Employerinformation_Busine
@synthesize UserSexNew;
@synthesize UserNameNew;
#pragma mark - 修改信息 名字
-(void)My_Employerinformation_Req:(NSMutableDictionary *)_dic{
    
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    UserNameNew = [_dic objectForKey:@"userRealName"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_EmployerInForm_Req andParameterDic:_dic andTarget:self andSeletor:@selector(EmployerReqCode:reqDic:)];
    
}

-(void)EmployerReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSMutableDictionary * dicLogin = [[NSMutableDictionary alloc]init];
            [dicLogin setDictionary:MyLoginInformation];
            [dicLogin setObject:UserNameNew forKey:@"userRealName"];
            [[NSUserDefaults standardUserDefaults]setObject:dicLogin forKey:@"MyLogin"];
            
            PostNetDelegate(_dic,@"MyEmployerInform");
            
        }else{
            
            PostNetDelegate(_dic,@"MyEmployerInform");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyEmployerInform");
        
    }
    
}

#pragma mark - 修改信息 图片
-(void)My_EmployerImageHead_Req:(NSMutableDictionary *)_dic{
    
    NSMutableDictionary * _dicGuid = [[NSMutableDictionary alloc]init];
    [_dicGuid setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_EmployerInForm_Req andParameterDic:_dicGuid  andfileDic:_dic andTarget:self andSeletor:@selector(EmployerImageReqCode:reqDic:)];
    
}

-(void)EmployerImageReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSMutableDictionary * dic_head = [[NSMutableDictionary alloc]init];
            [dic_head setObject:@"Head" forKey:@"code"];
            
            PostNetDelegate(dic_head,@"MyEmployerInform");
            
        }else{
            
            PostNetDelegate(_dic,@"MyEmployerInform");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyEmployerInform");
        
    }
    
}



#pragma mark - 修改信息 性别
-(void)My_EmployerinformationUserSex_Req:(NSMutableDictionary *)_dic{
    
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    UserSexNew = [_dic objectForKey:@"userSex"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_EmployerInForm_Req andParameterDic:_dic andTarget:self andSeletor:@selector(EmployerUserSexReqCode:reqDic:)];
    
}

-(void)EmployerUserSexReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            
            NSMutableDictionary * dicLogin = [[NSMutableDictionary alloc]init];
            [dicLogin setDictionary:MyLoginInformation];
            [dicLogin setObject:UserSexNew forKey:@"userSex"];
            [[NSUserDefaults standardUserDefaults]setObject:dicLogin forKey:@"MyLogin"];
            PostNetDelegate(_dic,@"MyEmployerInform");
            
        }else{
            
            PostNetDelegate(_dic,@"MyEmployerInform");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyEmployerInform");
        
    }
    
}



#pragma mark - 修改信息 密码
-(void)My_EmployerinformationUserPwd_Req:(NSMutableDictionary *)_dic{
    
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_EmployerInForm_Req andParameterDic:_dic andTarget:self andSeletor:@selector(EmployerUserPwdReqCode:reqDic:)];
    
}

-(void)EmployerUserPwdReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
        
            PostNetDelegate(_dic,@"MyEmployerInformPwd");
            
        }else{
            
            PostNetDelegate(_dic,@"MyEmployerInformPwd");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyEmployerInformPwd");
        
    }
    
}

@end
