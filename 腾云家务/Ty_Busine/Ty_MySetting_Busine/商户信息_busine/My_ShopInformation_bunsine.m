//
//  My_ShopInformation_bunsine.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/8.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopInformation_bunsine.h"

@implementation My_ShopInformation_bunsine
#pragma mark - 获取商户信息
-(void)My_Shopinformation_Req{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_ShopInForm_Req andParameterDic:_dic andTarget:self andSeletor:@selector(MyShopReqCode:reqDic:)];
}

-(void)MyShopReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[[_dic objectForKey:@"rows"] objectAtIndex:0]forKey:@"MyShopInformation"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[_dic objectForKey:@"rows"] objectAtIndex:0]forKey:@"MyShopInformationUpdate"];


            PostNetNotification(_dic,@"MyShopInFormation");
            
        }else{
            
            PostNetNotification(_dic,@"MyShopInFormation");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetNotification(reqCode,@"MyShopInFormation");
        
    }
    
}
//

#pragma mark - 修改商户信息
-(void)My_ShopinformationUpdate_Req:(NSMutableDictionary *) _dic{
    
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_ShopInFormUpdate_Req andParameterDic:_dic andTarget:self andSeletor:@selector(MyShopUpdateReqCode:reqDic:)];
}

-(void)MyShopUpdateReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSDictionary * dicUpdate = @{@"code":@"2434"};
            PostNetNotification(dicUpdate,@"MyShopInFormationUpadteReq");
            
        }else{
            
            PostNetNotification(_dic,@"MyShopInFormationUpadteReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetNotification(reqCode,@"MyShopInFormationUpadteReq");
        
    }
    
}

#pragma mark - 提交商户信息
-(void)My_ShopsubmitCheck_Req{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_shopSubmit_Req andParameterDic:_dic andTarget:self andSeletor:@selector(MyShopSubmitCheckReqCode:reqDic:)];
}

-(void)MyShopSubmitCheckReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSDictionary * dicUpdate = @{@"code":@"2435"};
            PostNetNotification(dicUpdate,@"MyShopSubmitCheckReq");
            
        }else{
            
            PostNetNotification(_dic,@"MyShopSubmitCheckReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetNotification(reqCode,@"MyShopSubmitCheckReq");
        
    }
    
}

@end
