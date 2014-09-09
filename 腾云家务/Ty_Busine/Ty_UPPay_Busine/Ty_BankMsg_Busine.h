//
//  Ty_BankMsg_Busine.h
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_BankMsg_Busine : NSObject
{
    NSMutableDictionary *_bankMsgDic;
}

- (void)getBankMsgRequest;

- (void)drawMoneyRequest:(NSMutableDictionary *)dic;

@end
