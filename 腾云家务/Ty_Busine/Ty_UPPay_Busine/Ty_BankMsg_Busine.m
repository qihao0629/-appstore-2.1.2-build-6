//
//  Ty_BankMsg_Busine.m
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_BankMsg_Busine.h"
#import "My_BankMsgModel.h"

@implementation Ty_BankMsg_Busine

- (id)init
{
    if (self = [super init])
    {
        _bankMsgDic = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

- (void)getBankMsgRequest
{
    [[Ty_NetRequestService shareNetWork] formRequest:My_BankMsg_Req andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:MyLoginUserGuid,@"userGuid", nil] andTarget:self andSeletor:@selector(getBankMsgRequest:data:)];
}

- (void)getBankMsgRequest:(NSString *)result data:(NSMutableDictionary *)dic
{
    NSLog(@"%@",dic);
    [_bankMsgDic removeAllObjects];
   // _bankMsgDic = dic;
    
    if (dic != nil)
    {
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
        
        if ([result isEqualToString:REQUESTSUCCESS])
        {
            if ([[dic objectForKey:@"code"] intValue] == 200)
            {
                NSMutableDictionary *dic1 = [dic objectForKey:@"bankCard"];
                My_BankMsgModel *bankModel = [[My_BankMsgModel alloc]init];
                bankModel.bankName = [dic1 objectForKey:@"bankName"];
                bankModel.bankGuid = [dic1 objectForKey:@"bankCardGuid"];
                bankModel.bankCardNum = [dic1 objectForKey:@"bankCardNumber"];
                bankModel.bankLogo = [dic1 objectForKey:@"bankLogo"];
                bankModel.bankCardAccountType = [dic1 objectForKey:@"bankCardAccountType"];
                bankModel.mayTurnOutMoney = [dic objectForKey:@"mayTurnOutMoney"];
                
                [dataDic setObject:bankModel forKey:@"bankMsg"];
                [dataDic setObject:[dic objectForKey:@"code"] forKey:@"code"];
            }
            else
            {
                [dataDic setObject:[dic objectForKey:@"code"] forKey:@"code"];
                [dataDic setObject:[dic objectForKey:@"msg"] forKey:@"msg"];
            }
            
        }
        else if ([result isEqualToString:REQUESTFAIL])
        {
            [dataDic setObject:[dic objectForKey:@"code"] forKey:@"code"];
            [dataDic setObject:[dic objectForKey:@"msg"] forKey:@"msg"];
        }
        
        
        //PostNetNotification(dataDic, @"GetBankMsg");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GetBankMsg" object:dataDic];
    }
   
}

- (void)drawMoneyRequest:(NSMutableDictionary *)dic
{
    [[Ty_NetRequestService shareNetWork] formRequest:My_DrawMoney_Req andParameterDic:dic andTarget:self andSeletor:@selector(drawMoney:data:)];
}
- (void)drawMoney:(NSString *)result data:(NSMutableDictionary *)dic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawsMoney" object:dic];
}

@end
