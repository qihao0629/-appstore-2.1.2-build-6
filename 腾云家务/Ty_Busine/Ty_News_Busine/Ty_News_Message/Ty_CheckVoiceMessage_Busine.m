//
//  Ty_CheckVoiceMessage_Busine.m
//  腾云家务
//
//  Created by liu on 14-6-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_CheckVoiceMessage_Busine.h"
#import "Ty_Model_MessageInfo.h"
#import "Ty_DbMethod.h"
#import "Ty_Message_Busine.h"

static Ty_CheckVoiceMessage_Busine *_shareCheckVoiceMessage = nil;

@implementation Ty_CheckVoiceMessage_Busine

+ (Ty_CheckVoiceMessage_Busine *)shareCheckVoiceMessage
{
    if (nil == _shareCheckVoiceMessage )
    {
        _shareCheckVoiceMessage = [[Ty_CheckVoiceMessage_Busine alloc]init];
    }
    
    return _shareCheckVoiceMessage;
}

- (id)init
{
    if (self = [super init])
    {
        [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(getDownloadFailedVoiceMessage) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)getDownloadFailedVoiceMessage
{
    if (IFLOGINYES)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        [self selectDownloadFailedVoice:array];
        
        if (array.count > 0)
        {
            Ty_Message_Busine *messageBusine = [[Ty_Message_Busine alloc]init];
            
            for (Ty_Model_MessageInfo *messageInfo in array)
            {
                [messageBusine downLoadVoiceMessage:messageInfo];
            }
            
            messageBusine = nil;
        }
        
        array = nil;

    }
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
        
        [array addObject:messageInfo];
        messageInfo = nil;
        
    }
    
    [resultSet close];
    
    
}


@end
