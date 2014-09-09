//
//  My_ShopAddWork_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopAddWork_busine.h"


@implementation My_ShopAddWork_busine
#pragma mark - 商户添加服务项目
-(void)loadDataAddWork:(Ty_Model_WorkListInfo *)WorklistModel{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setValue:MyLoginUserGuid forKey:@"userGuid"];
    [_dic setValue:WorklistModel.workGuid forKey:@"workGuid"];
    [_dic setObject:WorklistModel.postSalary forKey:@"postSalary"];
    [_dic setObject:WorklistModel.postRealSalary forKey:@"postRealSalary"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_USERSKILLADD andParameterDic:_dic andTarget:self andSeletor:@selector(GetAddSkill:reqDic:)];
}

#pragma mark - 请求回调方法
-(void)GetAddSkill:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSLog(@"%@",_dic);
            PostNetNotification(_dic,@"MyshopAddworkList");
            
        }else{
            
            PostNetNotification(_dic,@"MyshopAddworkList");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetNotification(reqCode,@"MyshopAddworkList");
        
    }
}

@end
