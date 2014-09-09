//
//  CustomDate.m
//  腾云家务
//
//  Created by 齐 浩 on 13-10-11.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "CustomDate.h"

@implementation CustomDate
@synthesize date = _date;
@synthesize dayStr = _dayStr;
@synthesize hourStr = _hourStr;
@synthesize minStr = _minStr;
@synthesize dateString = _dateString;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateString = [[NSMutableString alloc]init];
    }
    return self;
}
@end
