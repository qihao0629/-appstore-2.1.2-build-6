//
//  Ty_Phone_Model.m
//  腾云家务
//
//  Created by 齐 浩 on 14-8-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Phone_Model.h"

@implementation Ty_Phone_Model
@synthesize myGuid = _myGuid;
@synthesize yourGuid = _yourGuid;
@synthesize phoneNumber = _phoneNumber;
@synthesize PhoneTime = _PhoneTime;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _myGuid = @"";
        _yourGuid = @"";
        _phoneNumber = @"";
        _PhoneTime = @"";
    }
    return self;
}
@end
