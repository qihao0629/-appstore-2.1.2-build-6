//
//  Ty_TradingRecord_Busine.m
//  腾云家务
//
//  Created by liu on 14-7-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_TradingRecord_Busine.h"

@implementation Ty_TradingRecord_Busine

- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

- (void)getTradingRecord
{
    [[Ty_NetRequestService shareNetWork] formRequest:My_TradingRecord_Req andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:MyLoginUserGuid,@"userGuid", nil] andTarget:self andSeletor:@selector(getTradingRecord:data:)];
}

- (void)getTradingRecord:(NSString *)result data:(NSMutableDictionary *)dic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetTradingRecord" object:dic];
}

@end
