//
//  My_BankMsgModel.m
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_BankMsgModel.h"

@implementation My_BankMsgModel

@synthesize bankCardAccountType = _bankCardAccountType;
@synthesize bankCardNum = _bankCardNum;
@synthesize bankGuid = _bankGuid;
@synthesize bankLogo = _bankLogo;
@synthesize bankName = _bankName;
@synthesize mayTurnOutMoney = _mayTurnOutMoney;

- (id)init
{
    if (self = [super init])
    {
        _bankName = @"";
        _bankLogo = @"";
        _bankGuid = @"";
        _bankGuid = @"";
        _bankCardNum = @"";
        _bankCardAccountType = @"";
        _mayTurnOutMoney = @"";
    }
    
    return self;
}

@end
