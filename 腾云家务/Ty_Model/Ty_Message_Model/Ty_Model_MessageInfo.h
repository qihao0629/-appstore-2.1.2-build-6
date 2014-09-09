//
//  Ty_Model_MessageInfo.h
//  腾云家务
//
//  Created by liu on 14-6-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Model_MessageInfo : NSObject
{
    Ty_Model_MessageInfo *_messageInfo_Copy;
}

@property (nonatomic,strong) NSString *messageGuid;
@property (nonatomic,strong) NSString *messageTime;
@property (nonatomic,strong) NSString *messageContactGuid;
@property (nonatomic,strong) NSString *messageContactName;//用户名
@property (nonatomic,strong) NSString *messageContactRealName;//真是姓名
@property (nonatomic,strong) NSString *messageContactJIDName;// xmpp用户名
@property (nonatomic,strong) NSString *messageSenderGuid;
@property (nonatomic,strong) NSString *messageContent;
@property (nonatomic,assign) int messageContactSex;//联系人性别
@property (nonatomic,assign) int messageType;//信息类型  -1 文字      （按之前的来）
@property (nonatomic,assign) int messageIsRead;
@property (nonatomic,assign) int messageIsSendSuccess;
@property (nonatomic,assign) int messageIsVoiceRead;
@property (nonatomic,assign) int messageIsDelete;
@property (nonatomic,assign) int messageUnreadNum;//未读信息条数
@property (nonatomic,assign) int messageContactType ; //联系人类型 0 中介
@property (nonatomic,assign) int messageIsDownloadSuccess;//语音是否下载成功标志，默认为1，成功
@property (nonatomic,assign) int messageIsGroupDelete;

@property (nonatomic,strong) NSString *messageContactAnnear;//家务号



@property (nonatomic,strong) NSString *messageVoiceServicePath;

@property (nonatomic,strong) NSString *messageContactPhoto;

@property (nonatomic,assign) CGFloat messageHeight;// 辅助字段

@end
