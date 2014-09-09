//
//  Ty_SystemMessageBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_SystemMessageBusine.h"
#import "Ty_Model_SystemMsgInfo.h"
#import "Ty_DbMethod.h"
@implementation Ty_SystemMessageBusine
{
    NSMutableArray* receiveArray;
}
@synthesize messageArray = _messageArray;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _messageArray=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)insertMessage
{
    for (int i=0; i<receiveArray.count; i++) {
        NSString* insertSql=[NSString stringWithFormat:@"insert into %@(%@,%@,%@,%@,%@) values ('%@','%@','%@','%d','%d')",SYSTEMMESSAGE,SysTemMessage_Time,SysTemMessage_Message,SysTemMessage_ReqGuid,SysTemMessage_ReqType,SysTemMessage_IsRead,[receiveArray[i] systemMsg_Time],[receiveArray[i] systemMsgContent],[receiveArray[i] systemMsg_ReqGuid],[receiveArray[i] systemMsg_ReqType],[receiveArray[i] systemMsg_IsRead]];
        [[Ty_DbMethod shareDbService]insertData:insertSql];
    }
}
-(void)selectSystemMsgByPageNum:(NSInteger)currentPageNum
{/*
    NSString* selectSql=[NSString stringWithFormat:@"select * from %@ order by %@ limit %d,10",SYSTEMMESSAGE,
                         SysTemMessage_Time,
                         currentPageNum];
   */
    NSString* selectSql=[NSString stringWithFormat:@"select * from %@ order by %@ desc",SYSTEMMESSAGE,
                         SysTemMessage_Time];
    
    FMResultSet* resultSet=[[Ty_DbMethod shareDbService] selectData:selectSql];
    while (resultSet.next)
    {
        Ty_Model_SystemMsgInfo* systemInfo=[[Ty_Model_SystemMsgInfo alloc]init];
        
        systemInfo.systemMsgContent = [resultSet stringForColumn:SysTemMessage_Message];
        systemInfo.systemMsg_Time = [resultSet stringForColumn:SysTemMessage_Time];
        
        [_messageArray addObject:systemInfo];
        systemInfo = nil;
        
    }
}

- (void)setSystemMsgIsRead
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = 1",SYSTEMMESSAGE,SysTemMessage_IsRead];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

-(void)getMessageFromNet:(NSString *)flag reqGuid:(NSString *)_reqGuid
{
    if (flag!=nil&&_reqGuid!=nil) {
        NSMutableDictionary *messagedic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:flag,@"flag",_reqGuid,@"requirementGuid",MyLoginUserType,@"userType", nil];
        [[Ty_NetRequestService shareNetWork] formRequest:URL_SystemMessage andParameterDic:messagedic andTarget:self andSeletor:@selector(ReceiveSystemMessageInfo:dic:)];
    }
}
-(void)ReceiveSystemMessageInfo:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString=[dateFormatter stringFromDate:[NSDate date]];
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue]==200) {
            receiveArray=[[NSMutableArray alloc]init];
            Ty_Model_SystemMsgInfo* systemInfo=[[Ty_Model_SystemMsgInfo alloc]init];
            systemInfo.systemMsgContent=[_dic objectForKey:@"msg"];
            systemInfo.systemMsg_Time=dateString;
            systemInfo.systemMsg_ReqGuid=@"";
            [receiveArray addObject:systemInfo];
            [self insertMessage];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
        }
    }else{
        
    }
}


@end
