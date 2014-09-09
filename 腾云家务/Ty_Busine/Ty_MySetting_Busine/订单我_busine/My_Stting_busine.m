//
//  My_Stting_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_Stting_busine.h"

@implementation My_Stting_busine
@synthesize my_setUpadteModel;
#pragma mark - 订单我界面刷新数据
-(void)loadUpdateMySetting{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setValue:MyLoginUserGuid forKey:@"userGuid"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_SearchCheckStateAndMoney andParameterDic:_dic andTarget:self andSeletor:@selector(myUpdate:reqDic:)];
}

#pragma mark - 请求回调方法
-(void)myUpdate:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            my_setUpadteModel.accountMoney = [[[_dic objectForKey:@"rows"] objectAtIndex:0]objectForKey:@"accountMoney"];
            my_setUpadteModel.checkState = [[[_dic objectForKey:@"rows"] objectAtIndex:0]objectForKey:@"checkState"];

            PostNetNotification(_dic,@"MySettingUpdate");
            
        }else{
            
            PostNetNotification(_dic,@"MySettingUpdate");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetNotification(reqCode,@"MySettingUpdate");
        
    }
}

@end
