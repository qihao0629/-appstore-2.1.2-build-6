//
//  Ty_Model_MessageInfo.m
//  腾云家务
//
//  Created by liu on 14-6-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Model_MessageInfo.h"

@implementation Ty_Model_MessageInfo

@synthesize messageContactGuid = _messageContactGuid;
@synthesize messageContactName = _messageContactName;
@synthesize messageContactRealName = _messageContactRealName;
@synthesize messageContactSex = _messageContactSex;
@synthesize messageContent = _messageContent;
@synthesize messageGuid = _messageGuid;
@synthesize messageIsDelete = _messageIsDelete;
@synthesize messageIsRead = _messageIsRead;
@synthesize messageIsSendSuccess = _messageIsSendSuccess;
@synthesize messageIsVoiceRead = _messageIsVoiceRead;
@synthesize messageSenderGuid = _messageSenderGuid;
@synthesize messageTime = _messageTime;
@synthesize messageType = _messageType;
@synthesize messageUnreadNum = _messageUnreadNum;
@synthesize messageContactJIDName = _messageContactJIDName;
@synthesize messageContactType = _messageContactType;
@synthesize messageHeight = _messageHeight;
@synthesize messageContactPhoto = _messageContactPhoto;
@synthesize messageVoiceServicePath = _messageVoiceServicePath;
@synthesize messageIsDownloadSuccess = _messageIsDownloadSuccess;

- (id)init
{
    if (self = [super init])
    {
        _messageType = 0;
        _messageIsVoiceRead = 0;
        _messageIsSendSuccess = 1;
        _messageIsRead = 0;
        _messageIsDelete = 0;
        _messageContactSex = 0;
        _messageUnreadNum = 0;
        _messageHeight = 0;
        _messageContactType = 1;
        _messageIsDownloadSuccess = 1;
        
        _messageGuid = @"";
        _messageContent = @"";
        _messageContactRealName = @"";
        _messageContactName = @"";
        _messageContactGuid = @"";
        _messageSenderGuid = @"";
        _messageTime = @"";
        _messageContactJIDName = @"";
        _messageContactPhoto = @"";
        _messageVoiceServicePath = @"";
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    
    _messageInfo_Copy = [[[self class] allocWithZone: zone] init];
    
    _messageInfo_Copy.messageContactRealName = [self.messageContactRealName copyWithZone:zone];
    _messageInfo_Copy.messageContactGuid = [self.messageContactGuid copyWithZone:zone];
    _messageInfo_Copy.messageContactJIDName = [self.messageContactJIDName copyWithZone:zone];
    _messageInfo_Copy.messageContactName = [self.messageContactName copyWithZone:zone];
    _messageInfo_Copy.messageContactPhoto = [self.messageContactPhoto copyWithZone:zone];
    _messageInfo_Copy.messageContactSex = self.messageContactSex;
    _messageInfo_Copy.messageContactType = self.messageContactType;
    _messageInfo_Copy.messageContent = [self.messageContent copyWithZone:zone];
    _messageInfo_Copy.messageVoiceServicePath = [self.messageVoiceServicePath copyWithZone:zone];
    _messageInfo_Copy.messageGuid = [self.messageGuid copyWithZone:zone];
    _messageInfo_Copy.messageHeight = self.messageHeight;
    _messageInfo_Copy.messageIsDelete = self.messageIsDelete;
    _messageInfo_Copy.messageIsRead = self.messageIsRead;
    _messageInfo_Copy.messageIsSendSuccess = self.messageIsSendSuccess;
    _messageInfo_Copy.messageIsVoiceRead = self.messageIsVoiceRead;
    _messageInfo_Copy.messageSenderGuid = [self.messageSenderGuid copyWithZone:zone];
    _messageInfo_Copy.messageTime = [self.messageTime copyWithZone:zone];
    _messageInfo_Copy.messageType = self.messageType;
    _messageInfo_Copy.messageUnreadNum = self.messageUnreadNum;
    _messageInfo_Copy.messageIsDownloadSuccess = self.messageIsDownloadSuccess;
    
    

    return _messageInfo_Copy;
}


@end
