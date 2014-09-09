//
//  Ty_Model_LifeTipsInfo.m
//  腾云家务
//
//  Created by liu on 14-8-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Model_LifeTipsInfo.h"

@implementation Ty_Model_LifeTipsInfo

@synthesize lifeTipsContent = _lifeTipsContent;
@synthesize lifeTipsContentImg = _lifeTipsContentImg;
@synthesize lifeTipsDate = _lifeTipsDate;
@synthesize lifeTipsGuid = _lifeTipsGuid;
@synthesize lifeTipsTitle = _lifeTipsTitle;
@synthesize lifeTipsIsRead = _lifeTipsIsRead;

- (id)init
{
    if (self = [super init])
    {
        _lifeTipsTitle = @"";
        _lifeTipsGuid = @"";
        _lifeTipsDate = @"";
        _lifeTipsContentImg = @"";
        _lifeTipsContent = @"";
        _lifeTipsIsRead = 0;
    }
    
    return self;
}

@end
