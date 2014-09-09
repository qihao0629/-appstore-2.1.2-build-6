//
//  Ty_Message_Define.h
//  腾云家务
//
//  Created by liu on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_Message_Define_h
#define _____Ty_Message_Define_h



#pragma mark --- 小Q

#define Message_Q_Guid @"4411af4457be21dcf0d3ce63eba81c33"
#define Message_Q_JID  @"tengyunxiaoq_family"

#pragma mark --- 录音存放路径
#define VoicePath [NSString stringWithFormat:@"%@/%@/%@/",PATH_OF_DOCUMENT,MyLoginUserGuid,@"VoiceFile"]


#pragma mark --- XMPP 的节点们

#define XmppMessageGuid @"messageGuid"
#define XmppMessageContactType @"messageContactType"
#define XmppMessageSendUserGuid @"messageSendUserGuid"
#define XmppMessageContactRealName @"messageContactRealName"
#define XmppMessageContactSex @"messageContactGender"
#define XmppMessageType @"messageType"
#define XmppMessageTime @"messageTime"
#define XmppMessageReceiveGuid @"messageReceiveGuid"

//获取系统消息更新标识
#define GetSystemMessageFlag  [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"] objectForKey:@"systemMessageFlag"]

//设置系统消息更新标识
#define SetSystemMessageFlag(flag) [[[NSUserDefaults standardUserDefaults] objectForKey:@"MyLogin"] setObject:flag forKey:@"systemMessageFlag"]

#endif

