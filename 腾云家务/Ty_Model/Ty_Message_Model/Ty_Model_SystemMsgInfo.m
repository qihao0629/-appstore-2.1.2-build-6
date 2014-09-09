//
//  Ty_Model_SystemMsgInfo.m
//  腾云家务
//
//  Created by liu on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Model_SystemMsgInfo.h"

@implementation Ty_Model_SystemMsgInfo

@synthesize systemMsgGuid = _systemMsgGuid;

@synthesize systemMsg_ReqGuid = _systemMsg_ReqGuid;

@synthesize systemMsgContent = _systemMsgContent;

@synthesize systemMsg_Time=_systemMsg_Time;

@synthesize systemRedNumArr = _systemRedNumArr;

@synthesize systemMsg_IsRead = _systemMsg_IsRead;

@synthesize systemMsg_ReqType = _systemMsg_ReqType;


- (id)init
{
    if (self = [super init])
    {
        _systemMsgContent = @"";
        _systemMsgGuid = @"";
        _systemMsg_ReqGuid = @"";

        _systemMsg_Time=@"";
        
        _systemMsg_ReqType = 0;
        
        _systemMsg_IsRead = 0;
        
        _systemRedNumArr = [[NSMutableArray alloc]init];

    }
    
    return self;
}

-(void)dealloc
{
    _systemRedNumArr = nil;
}

@end
