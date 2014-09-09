//
//  Ty_DrawMoney_Busine.m
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_DrawMoney_Busine.h"

@implementation Ty_DrawMoney_Busine

- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

- (void)getDrawMoneyRecord
{
    [[Ty_NetRequestService shareNetWork] formRequest:My_DrawRecord_Req andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:MyLoginUserGuid,@"userGuid" ,nil] andTarget:self andSeletor:@selector(getDrawMoneyRecord:data:)];
}

- (void)getDrawMoneyRecord:(NSString *)result data:(NSMutableDictionary *)dic
{
   // PostNetNotification(dic, @"GetDrawRecord");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetDrawRecord" object:dic];
   
}

@end
