//
//  Ty_MessageList_Busine.m
//  腾云家务
//
//  Created by liu on 14-6-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MessageList_Busine.h"
#import "Ty_DbMethod.h"
#import "Ty_Model_MessageInfo.h"

@implementation Ty_MessageList_Busine


@synthesize allMessageArr = _allMessageArr;

- (id)init
{
    if (self = [super init])
    {
        _allMessageArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    _allMessageArr = nil;
}

- (void)insertMessageIntoTable:(Ty_Model_MessageInfo *)messageInfo
{
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%d','%d','%d','%d','%d','%d','%d','%d','%@')",TBL_MESSAGE,
                     Message_Guid,
                     Message_Time,
                     Message_ContactGuid,
                     Message_ContactName,
                     Message_ContactRealName,
                     Message_SenderGuid,
                     Message_Content,
                     Message_VoiceServicePath,
                     Message_ContactPhoto,
                     Message_ContactType,
                     Message_ContactSex,
                     Message_Type,
                     Message_IsRead,
                     Message_IsSendSuccess,
                     Message_IsVoiceRead,
                     Message_IsDelete,
                     Message_IsDownloadSuccess,
                     Message_IsGroupDelete,
                     Message_UserAnnear,
                     
                     messageInfo.messageGuid,
                     messageInfo.messageTime,
                     messageInfo.messageContactGuid,
                     messageInfo.messageContactJIDName,
                     messageInfo.messageContactRealName,
                     messageInfo.messageSenderGuid,
                     messageInfo.messageContent,
                     messageInfo.messageVoiceServicePath,
                     messageInfo.messageContactPhoto,
                     messageInfo.messageContactType,
                     messageInfo.messageContactSex,
                     messageInfo.messageType,
                     messageInfo.messageIsRead,
                     messageInfo.messageIsSendSuccess,
                     messageInfo.messageIsVoiceRead,
                     messageInfo.messageIsDelete,
                     messageInfo.messageIsDownloadSuccess,
                     messageInfo.messageIsGroupDelete,
                     messageInfo.messageContactAnnear];
    
    [[Ty_DbMethod shareDbService] insertData:sql];
}

- (void)getAllMessageList
{
    [_allMessageArr removeAllObjects];
    NSString *sql = [NSString stringWithFormat:@"select * from %@  left join (select count (*) ,%@ as %@ from %@ where %@ = '0' and %@ = '1' group by contactGuid) on %@ = %@  left join %@ on %@ = %@ where %@ = '1'and %@ = '0' group by %@  order by %@ desc",TBL_MESSAGE,
                     Message_ContactGuid,
                     @"contactGuid",
                     TBL_MESSAGE,
                     Message_IsRead,
                     Message_IsDownloadSuccess,
                     @"contactGuid",Message_ContactGuid,
                     
                     TBL_MSG_CONTACTINFO,
                     Msg_ContactGuid,Message_ContactGuid,
                     Message_IsDownloadSuccess,
                     Message_IsGroupDelete,
                     
                     Message_ContactGuid,
                     Message_Time];
    
    NSString *sql1 = [NSString stringWithFormat:@"select * from %@  left join (select count (*) ,%@ as %@ from %@ where %@ = '0' and %@ = '1' group by contactGuid) on %@ = %@  left join %@ on %@ = %@ where %@ = '1'and %@ = '0' group by %@  order by %@ desc",TBL_MESSAGE,
                      Message_ContactGuid,
                      @"contactGuid",
                      TBL_MESSAGE,
                      Message_IsRead,
                      Message_IsDownloadSuccess,
                      @"contactGuid",Message_ContactGuid,
                      
                      TBL_MSG_CONTACTINFO,
                      Msg_ContactGuid,Message_ContactGuid,
                      
                      
                      Message_IsDownloadSuccess,
                      Message_IsGroupDelete,
                      
                      Message_ContactGuid,
                      Message_Time];
    
    NSString *sql2 = [NSString stringWithFormat:@"select * from %@  left join (select count (*) ,%@ as %@ from %@ where %@ = '0' and %@ = '1' group by contactGuid) on %@ = %@  where %@ = '1'and %@ = '0' group by %@  order by %@ desc",TBL_MESSAGE,
                      Message_ContactGuid,
                      @"contactGuid",
                      TBL_MESSAGE,
                      Message_IsRead,
                      Message_IsDownloadSuccess,
                      @"contactGuid",Message_ContactGuid,
                      
                      Message_IsDownloadSuccess,
                      Message_IsGroupDelete,
                      
                      Message_ContactGuid,
                      Message_Time];
    
    FMResultSet *resultSet =  [[Ty_DbMethod shareDbService] selectData:sql2];
    while (resultSet.next)
    {
        
        Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
        messageInfo.messageGuid = [resultSet stringForColumn:Message_Guid];
        messageInfo.messageContactGuid = [resultSet stringForColumn:Message_ContactGuid];
        messageInfo.messageContactJIDName = [resultSet stringForColumn:Message_ContactName];
        messageInfo.messageContactRealName = [resultSet stringForColumn:Message_ContactRealName];
        messageInfo.messageContactSex = [resultSet intForColumn:Message_ContactSex];
        messageInfo.messageContent = [resultSet stringForColumn:Message_Content];
        messageInfo.messageIsDelete = [resultSet intForColumn:Message_IsDelete];
        messageInfo.messageIsRead = [resultSet intForColumn:Message_IsRead];
        messageInfo.messageIsSendSuccess = [resultSet intForColumn:Message_IsSendSuccess];
        messageInfo.messageIsVoiceRead = [resultSet intForColumn:Message_IsVoiceRead];
        messageInfo.messageSenderGuid = [resultSet stringForColumn:Message_SenderGuid];
        messageInfo.messageTime = [resultSet stringForColumn:Message_Time];
        messageInfo.messageType = [resultSet intForColumn:Message_Type];
        messageInfo.messageUnreadNum = [resultSet intForColumn:@"count (*)"];
        messageInfo.messageContactType = [resultSet intForColumn:Message_ContactType];
       // messageInfo.messageContactPhoto = [resultSet stringForColumn:Msg_ContactPhoto];
       // messageInfo.messageContactSex = [resultSet intForColumnIndex:Msg_ContactSex];
        messageInfo.messageVoiceServicePath = [resultSet stringForColumn:messageInfo.messageVoiceServicePath];
        messageInfo.messageContactPhoto = [resultSet stringForColumn:Message_ContactPhoto];
        messageInfo.messageContactAnnear = [resultSet stringForColumn:Message_UserAnnear];
        [_allMessageArr addObject:messageInfo];
        messageInfo = nil;
        
    }
    
    
//    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
//    messageInfo.messageContactRealName = @"我的抢单和预约";
//    messageInfo.messageContent = @"点击查看全部抢单和预约详情";
//    [_allMessageArr insertObject:messageInfo atIndex:0];
//    messageInfo = nil;
    
    for (Ty_Model_MessageInfo *messageInfo1 in _allMessageArr)
    {
       // NSLog(@"%@",messageInfo1.messageContactGuid);
        //NSLog(@"%@",Message_Q_Guid);
        if ([messageInfo1.messageContactGuid isEqualToString:Message_Q_Guid])
        {
            //[_allMessageArr exc];
           // messageInfo1.messageType = -1;
            messageInfo1.messageIsVoiceRead = 1;
            Ty_Model_MessageInfo *messageInfo_Q = [messageInfo1 copy];
       
            [_allMessageArr insertObject:messageInfo_Q atIndex:0];
            [_allMessageArr removeObject:messageInfo1];
            
            break;
        }
    }
    
    
    Ty_Model_MessageInfo *messageInfo2 = [[Ty_Model_MessageInfo alloc]init];
     messageInfo2.messageContactRealName = @"系统消息";
    [self getSystemMessage:messageInfo2];
    if(messageInfo2.messageContent.length == 0)
    {
        messageInfo2.messageContent = @"您的订单服务信息，注意接收哦~";
    }
    [_allMessageArr insertObject:messageInfo2 atIndex:1];
    
    messageInfo2 = nil;
    
    //测试 生活小贴士
    Ty_Model_MessageInfo *messageInfo3 = [[Ty_Model_MessageInfo alloc]init];
    messageInfo3.messageContactRealName = @"生活小贴士";
    messageInfo3.messageContent = @"生活小贴士、生活小窍门，等你哦~";
    [self getLifeTipsMessage:messageInfo3];
    [_allMessageArr insertObject:messageInfo3 atIndex:2];
    messageInfo3 = nil;
    
    /*
    Ty_Model_MessageInfo *messageInfo1 = [[Ty_Model_MessageInfo alloc]init];
    messageInfo1.messageContactRealName = @"腾云小Q";
    [_allMessageArr insertObject:messageInfo1 atIndex:0];
    */
    [resultSet close];
    
    
}

- (void)getSystemMessage:(Ty_Model_MessageInfo *)messageInfo
{
     NSString *sql = [NSString stringWithFormat:@"select * from %@ left join (select count (*)  from %@ where %@ = '0'  ) order by %@ desc limit 0,1",
                      SYSTEMMESSAGE,
                      SYSTEMMESSAGE,
                      SysTemMessage_IsRead,
                      SysTemMessage_Time];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
       
        messageInfo.messageContent = [resultSet stringForColumn:@"您的订单服务信息，注意接收哦~"];
        messageInfo.messageTime = [resultSet stringForColumn:SysTemMessage_Time];
        messageInfo.messageUnreadNum = [resultSet intForColumn:@"count (*)"];
        
    }
}

- (void)getLifeTipsMessage:(Ty_Model_MessageInfo *)messageInfo
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ left join (select count (*)  from %@ where %@ = '0'  ) order by %@ desc limit 0,1",
                     TBL_LIFETIPS,
                     TBL_LIFETIPS,
                     LifeTips_IsRead,
                     LifeTips_Time];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        
       // messageInfo.messageContent = [resultSet stringForColumn:LifeTips_Content];
        messageInfo.messageTime = [resultSet stringForColumn:LifeTips_Time];
        messageInfo.messageUnreadNum = [resultSet intForColumn:@"count (*)"];
        
    }
}

- (NSInteger)getAllUnreadMessageNum
{
    int num = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select count (*) from %@ where %@ = 0 and %@ = 0 and %@ = 1 and %@ = 0 ",TBL_MESSAGE,
                     Message_IsRead,
                     Message_IsDelete,
                     Message_IsDownloadSuccess,
                     Message_IsGroupDelete];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService]selectData:sql];
    while (resultSet.next)
    {
        num = [resultSet intForColumnIndex:0];
    }
    
    
    int systemNum = 0;
    NSString *sql1 = [NSString stringWithFormat:@"select count (*) from %@ where %@ = 0 ",SYSTEMMESSAGE,SysTemMessage_IsRead];
    FMResultSet *resultSet1 = [[Ty_DbMethod shareDbService] selectData:sql1];
    while (resultSet1.next)
    {
        systemNum = [resultSet1 intForColumnIndex:0];
    }
    
    int lifeTipsNum = 0;
    NSString *sql2 = [NSString stringWithFormat:@"select count (*) from %@ where %@ = 0 ",TBL_LIFETIPS,LifeTips_IsRead];
    FMResultSet *resultSet2 = [[Ty_DbMethod shareDbService] selectData:sql2];
    while (resultSet2.next)
    {
        lifeTipsNum = [resultSet2 intForColumnIndex:0];
    }
    
    return num + systemNum + lifeTipsNum;
}

- (void)updateGroupDeleteByContactGuid:(NSString *)contactGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '1', %@ = '1' where %@ = '%@'",TBL_MESSAGE,
                     Message_IsGroupDelete,
                     Message_IsRead,
                     Message_ContactGuid,
                     contactGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

- (BOOL)isQDataExist
{
    BOOL isExist = NO;
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",TBL_MESSAGE,Message_ContactGuid,Message_Q_Guid];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        isExist = YES;
    }
    
    return isExist;
}

- (BOOL)isMsgContactInfoExist:(NSString *)contactGuid
{
    BOOL isExist = NO;
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",TBL_MSG_CONTACTINFO,Msg_ContactGuid,contactGuid];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        isExist = YES;
    }
        
    return isExist;

}
- (void)insertMsgContactInfoIntoTable:(NSMutableDictionary *)dic
{
    //NSLog(@"%@",dic);
    if ([self isMsgContactInfoExist:[dic objectForKey:@"userGuid"]])// 数据库里已存在，更新
    {
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'",TBL_MSG_CONTACTINFO,
                         Msg_ContactPhoto,
                         [dic objectForKey:@"userPhoto"],
                         Msg_ContactGuid,
                         [dic objectForKey:@"userGuid"]];
        [[Ty_DbMethod shareDbService] updateData:sql];
        
        
        
    }
    else//插入
    {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@,%@) values ('%@','%@') ",TBL_MSG_CONTACTINFO,
                         Msg_ContactGuid,
                         Msg_ContactPhoto,
                         [dic objectForKey:@"userGuid"],
                         [dic objectForKey:@"userPhoto"]];
        [[Ty_DbMethod shareDbService] insertData:sql];
        
        //通知列表页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Msg_UpdatePhoto" object:dic];
}


#pragma mark ---- 创建一条小Q
- (void)createQDataIntoTable
{
    if (![self isQDataExist])
    {
        /*
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@,%@,%@) values ('%@','%@','%@','%@','%@','%@')",TBL_MESSAGE,
                         Message_ContactGuid,
                         Message_ContactName,
                         Message_ContactRealName,
                         Message_IsDownloadSuccess,
                         Message_Content,
                         Message_Q_Guid,Message_Q_JID,@"腾云小Q",@"1",@"欢迎使用腾云家务。\n我是腾云小Q，您的家务助手！\n如果您在使用中有任何问题或建议，记得发消息告诉我，小Q随时准备回答您的问题哦！"];
         */
        
        Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
        
        messageInfo.messageGuid = [[Guid share]getGuid];
        messageInfo.messageContent = @"欢迎使用腾云家务。\n我是腾云小Q，您的家务助手！\n如果您在使用中有任何问题或建议，记得发消息告诉我，小Q随时准备回答您的问题哦！";
        messageInfo.messageContactGuid = Message_Q_Guid;
        messageInfo.messageContactJIDName = Message_Q_JID;
        messageInfo.messageContactName = @"腾云小Q";
        messageInfo.messageContactRealName = @"腾云小Q";
        messageInfo.messageContactSex = 1;
        messageInfo.messageContactType = 1;
        messageInfo.messageIsDelete = 0;
        messageInfo.messageIsDownloadSuccess = 1;
        messageInfo.messageIsRead = 1;
        messageInfo.messageIsSendSuccess = 1;
        messageInfo.messageTime = [self getCurrentTime];
        messageInfo.messageType = -1;
        messageInfo.messageIsGroupDelete = 0;
        messageInfo.messageSenderGuid = Message_Q_Guid;
        
        
        [self insertMessageIntoTable:messageInfo];
        messageInfo = nil;
    }
}


#pragma mar ---- 从网络请求数据
- (void)getMsgContactInfoFromNetWithContactGuid:(NSString *)contactGuid
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:contactGuid,@"userGuid", nil];
    [[Ty_NetRequestService shareNetWork] formRequest:URL_GetMsgContactInfo andParameterDic:dic andTarget:self andSeletor:@selector(getMsgContactInfoStatusResult:data:)];
    
   
}

- (void)getMsgContactInfoStatusResult:(NSString *)statusResult data:(NSMutableDictionary *)dic
{
    if ([statusResult isEqualToString:REQUESTSUCCESS])
    {
        //请求成功
        if (200 == [[dic objectForKey:@"code"] integerValue])
        {
            //成功
           
            [self insertMsgContactInfoIntoTable:[[dic objectForKey:@"rows"] objectAtIndex:0]];
        }
        else
        {
            
        }
    }
    else if ([statusResult isEqualToString:REQUESTFAIL])
    {
        //请求失败
       
    }
}


#pragma mark --- 辅助信息-获取时间
- (NSString *)getCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *current = [dateFormatter stringFromDate:currentDate];
    dateFormatter = nil;
    return current;
}

@end
