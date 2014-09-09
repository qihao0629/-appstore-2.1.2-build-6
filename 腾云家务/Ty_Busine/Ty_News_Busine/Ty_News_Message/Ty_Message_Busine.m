//
//  Ty_Message_Busine.m
//  腾云家务
//
//  Created by liu on 14-6-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Message_Busine.h"
#import "Ty_Model_MessageInfo.h"
#import "Ty_DbMethod.h"
#import "VoiceConverter.h"
#import "XmppManager.h"
#import "StatusNotificationBar.h"
#import "AppDelegateViewController.h"

@implementation Ty_Message_Busine


@synthesize messageArr = _messageArr;

- (id)init
{
    if (self = [super init])
    {
        _messageArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    _messageArr = nil;
}

- (void)selectMessageDataFromTableByContactGuid:(NSString *)contactGuid pageNum:(int)pageNum
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ left join %@ on %@ = %@  where %@ = '%@' and %@ != 1 and %@ = 1 order by %@ desc limit %d,10 ",TBL_MESSAGE,
                     TBL_MSG_CONTACTINFO,
                     Msg_ContactGuid,
                     Message_ContactGuid,
                     Message_ContactGuid,
                     contactGuid,
                     Message_IsDelete,
                     Message_IsDownloadSuccess,
                     Message_Time,
                     pageNum];
    
    NSString *sql1 = [NSString stringWithFormat:@"select * from %@  where %@ = '%@' and %@ != 1 and %@ = 1 order by %@ desc limit %d,10 ",TBL_MESSAGE,
                     Message_ContactGuid,
                     contactGuid,
                     Message_IsDelete,
                     Message_IsDownloadSuccess,
                     Message_Time,
                     pageNum];
    
    FMResultSet *resultSet =  [[Ty_DbMethod shareDbService] selectData:sql1];
    while (resultSet.next)
    {
       // NSLog(@"~~~~~~");
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
        messageInfo.messageContactType = [resultSet intForColumn:Message_ContactType];
        // messageInfo.messageUnreadNum = [resultSet intForColumn:@"count (*)"];
        messageInfo.messageContactPhoto = [resultSet stringForColumn:Msg_ContactPhoto];
        messageInfo.messageVoiceServicePath = [resultSet stringForColumn:Message_VoiceServicePath];
        messageInfo.messageIsGroupDelete  = [resultSet intForColumn:Message_IsGroupDelete];
        messageInfo.messageContactPhoto = [resultSet stringForColumn:Message_ContactPhoto];
        messageInfo.messageContactAnnear = [resultSet stringForColumn:Message_UserAnnear];
        
        [_messageArr insertObject:messageInfo atIndex:0];
        messageInfo = nil;
        
    }
    
    [resultSet close];
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

- (void)selectDownloadFailedVoice:(NSMutableArray *)array
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = 0 and %@ != -1",TBL_MESSAGE,
                     Message_IsDownloadSuccess,
                     Message_Type];
    
    FMResultSet *resultSet =  [[Ty_DbMethod shareDbService] selectData:sql];
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
        messageInfo.messageContactType = [resultSet intForColumn:Message_ContactType];
        // messageInfo.messageUnreadNum = [resultSet intForColumn:@"count (*)"];
        messageInfo.messageContactPhoto = [resultSet stringForColumn:Msg_ContactPhoto];
        messageInfo.messageVoiceServicePath = [resultSet stringForColumn:Message_VoiceServicePath];
        messageInfo.messageContactPhoto = [resultSet stringForColumn:Message_ContactPhoto];
        messageInfo.messageContactAnnear = [resultSet stringForColumn:Message_UserAnnear];
        
        [array addObject:messageInfo];
        messageInfo = nil;
        
    }
    
    [resultSet close];

    
}

- (void)insertMessageIntoTable:(Ty_Model_MessageInfo *)messageInfo
{
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%d','%d','%d','%d','%d','%d','%d','%d','%@')",TBL_MESSAGE,
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

- (void)updateVoiceMessageServicePath:(NSString *)path messageGuid:(NSString *)messageGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'",TBL_MESSAGE,
                     Message_VoiceServicePath,
                     path,
                     Message_Guid,
                     messageGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
}
- (void)updateVoiceReadStatusByMessageGuid:(NSString *)messageGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '1' where %@ = '%@'",TBL_MESSAGE,Message_IsVoiceRead,Message_Guid,messageGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

- (void)updateVoiceDownLoadStatusByMessageGuid:(NSString *)messageGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '1' where %@ = '%@'",TBL_MESSAGE,
                     Message_IsDownloadSuccess,
                     Message_Guid,
                     messageGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

- (BOOL)isDataExist:(NSString *)messageGuid
{
    BOOL isExist = NO;
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",TBL_MESSAGE,Message_Guid,messageGuid];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        isExist = YES;
    }
    
    return isExist;
}

/*
- (NSString *)getContactPhoto:(NSString *)contactGuid
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",TBL_MSG_CONTACTINFO,Msg_ContactGuid,contactGuid];
    NSString *contactPhoto = @"";
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        contactPhoto
    }
    
}

 */

- (void)updateMessageSendStatusByMessageGuid:(NSString *)messageGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '0' where %@ = '%@'",TBL_MESSAGE,
                     Message_IsSendSuccess,
                     Message_Guid,
                     messageGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
    
}


- (void)updateMessageSendStatusSuccessByMessageGuid:(NSString *)messageGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '1' where %@ = '%@'",TBL_MESSAGE,
                     Message_IsSendSuccess,
                     Message_Guid,
                     messageGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
    
}

- (void)updateMessageReadStatusByContactGuid:(NSString *)contactGuid
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '1' where %@ = '%@' and %@ = '0'",TBL_MESSAGE,
                     Message_IsRead,
                     Message_ContactGuid,
                     contactGuid,
                     Message_IsRead];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

#pragma mark ---- 发送语音消息到服务器
- (void)sendVoiceMessageToService:(Ty_Model_MessageInfo *)messageInfo
{
  //  NSThread *thread = [NSThread ];
    /*
    NSString *wavPathStr = [NSString stringWithFormat:@"%@%@.wav",VoicePath,messageInfo.messageGuid];
    NSString *amrPathStr = [NSString stringWithFormat:@"%@%@.amr",VoicePath,messageInfo.messageGuid];
    [VoiceConverter wavToAmr:wavPathStr amrSavePath:amrPathStr];
    
    [[Ty_NetRequestService shareNetWork] formRequest:URL_SendVoiceMsg andParameterDic:nil andfileDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:amrPathStr,@"voiceMessage", nil] andSymbolParameter:messageInfo andTarget:self andSeletor:@selector(sendMessageSuccess:data:)];
     
     */
    
    [NSThread detachNewThreadSelector:@selector(convertWavToAmr:) toTarget:self withObject:messageInfo];
   
    
    
}

//新开的线程，转换语音格式，完成后发送语音到服务器
- (void)convertWavToAmr:(Ty_Model_MessageInfo *)messageInfo
{
   // NSLog(@"new");
    
    NSString *wavPathStr = [NSString stringWithFormat:@"%@%@.wav",VoicePath,messageInfo.messageGuid];
    NSString *amrPathStr = [NSString stringWithFormat:@"%@%@.amr",VoicePath,messageInfo.messageGuid];
    [VoiceConverter wavToAmr:wavPathStr amrSavePath:amrPathStr];
    
    messageInfo.messageVoiceServicePath = amrPathStr;
    
    [self performSelectorOnMainThread:@selector(sendVoice:) withObject:messageInfo waitUntilDone:YES];
}


- (void)sendVoice:(Ty_Model_MessageInfo *)messageInfo
{
    [[Ty_NetRequestService shareNetWork] formRequest:URL_SendVoiceMsg andParameterDic:nil andfileDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:messageInfo.messageVoiceServicePath,@"voiceMessage", nil] andSymbolParameter:messageInfo andTarget:self andSeletor:@selector(sendMessageSuccess:data:)];
}

//发送语音的回调
- (void)sendMessageSuccess:(id)object data:(NSMutableDictionary *)dic
{
  //  NSLog(@"%@",dic);
    Ty_Model_MessageInfo *messageInfo = (Ty_Model_MessageInfo *)object;
    
    if (nil == dic)
    {
        NSLog(@"失败");
        messageInfo.messageIsSendSuccess = 0;
        [self updateMessageSendStatusByMessageGuid:messageInfo.messageGuid];
        //刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMessage_SendMsgFail" object:messageInfo];
        
    }
    else
    {
        NSLog(@"成功~");
        if ([[dic objectForKey:@"code"] intValue] == 200)
        {
            NSLog(@"成功~200");
            NSString *path = [dic objectForKey:@"paths"];
            
            messageInfo.messageVoiceServicePath = path;
            

            
            [[XmppManager shareXmppManager] sendMessage:messageInfo];
            
            [self updateVoiceMessageServicePath:path messageGuid:messageInfo.messageGuid];
            
            
            
        }
    }
    //此处走更新方法，
   // [self insertMessageIntoTable:messageInfo];
    
}

#pragma mark --- 下载语音
- (void)downLoadVoiceMessage:(Ty_Model_MessageInfo *)messageInfo
{
    Ty_Model_MessageInfo *newMessageInfo = [[Ty_Model_MessageInfo alloc]init];
    newMessageInfo = [messageInfo copy];
    [[Ty_NetRequestService shareNetWork] downLoadVoiceMessage:newMessageInfo target:self seletor:@selector(downLoadStatus:data:)];
}

- (void)downLoadStatus:(id)object data:(NSMutableDictionary *)dic
{
    
    Ty_Model_MessageInfo *messageInfo = (Ty_Model_MessageInfo *)object;
    
   // NSLog(@"%@",messageInfo);
    
    NSString *filePath = [NSString stringWithFormat:@"%@%@.amr",VoicePath,messageInfo.messageGuid];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"下载成功~~~~~~~~");
        
        NSString *wavStr = [NSString stringWithFormat:@"%@%@.wav",VoicePath,messageInfo.messageGuid];
        [VoiceConverter amrToWav:filePath wavSavePath:wavStr];
        
        messageInfo.messageContent = wavStr;
        
        
        if ([self isDataExist:messageInfo.messageGuid])
        {
            [self updateVoiceDownLoadStatusByMessageGuid:messageInfo.messageGuid];
        }
        else
        {
            [self insertMessageIntoTable:messageInfo];
        }
        
        
        //通知气泡页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMessage" object:messageInfo];
        
        //通知列表页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
        
        [[StatusNotificationBar shareNotificationBar] showStatusMessage:[NSString stringWithFormat:@"%@发来一条消息",messageInfo.messageContactRealName]];
        
        if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
        {
            
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
            [appDelegateVC setTabBarIcon:[self getAllUnreadMessageNum] atIndex:1];
        }
    }
    else
    {
        NSLog(@"下载失败~~~");
        //下载失败的方法，加入到一张表里，之后继续下载
        messageInfo.messageIsDownloadSuccess = 0;
        
        if ([self isDataExist:messageInfo.messageGuid])
        {
            [self insertMessageIntoTable:messageInfo];
        }
        
    }
}

@end
