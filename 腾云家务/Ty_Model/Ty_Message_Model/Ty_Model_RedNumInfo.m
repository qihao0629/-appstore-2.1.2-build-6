//
//  Ty_Model_RedNumInfo.m
//  腾云家务
//
//  Created by liu on 14-7-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Model_RedNumInfo.h"

@implementation Ty_Model_RedNumInfo

@synthesize  redNumLocation = _redNumLocation;

@synthesize redNumStr = _redNumStr;

- (id)init
{
    if (self = [super init])
    {
        _redNumStr = @"";
        _redNumLocation = 0;
    }
    
    return self;
}

@end
