//
//  TYNotificationTool.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-24.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYNotificationTool.h"
@implementation TYNotificationTool
static int NotificationMark=0;
+(int)getNotificationMark
{
    return NotificationMark;
}
+(int)setNotificationMark
{
    NotificationMark++;
    return NotificationMark;
}
@end
