//
//  My_SettingUpadteModel.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/15.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_SettingUpadteModel.h"

@implementation My_SettingUpadteModel
@synthesize checkState = _checkState;
@synthesize accountMoney = _accountMoney;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _checkState = @"";
        _accountMoney = @"";
    }
    return self;
}

@end
