//
//  Ty_DatabaseDefine_Message.h
//  腾云家务
//
//  Created by liu on 14-6-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_DatabaseDefine_Message_h
#define _____Ty_DatabaseDefine_Message_h


#pragma mark --- table

#define TBL_MESSAGE @"TBL_Message"

#define Message_Guid @"Message_Guid"
#define Message_Time @"Message_Time"
#define Message_ContactGuid @"Message_ContactGuid"
#define Message_ContactName @"Message_Contactname"
#define Message_ContactRealName @"Message_RealName"
#define Message_SenderGuid @"Message_SenderGuid"
#define Message_Content @"Message_Content"//当时文字私信时，存的的是信息内容；当为语音时，存放的是该语音的本地地址
#define Message_VoiceServicePath @"Message_VoiceServicePath"//该条语音信息在服务器的地址
#define Message_ContactPhoto @"Message_ContactPhoto" //头像

#define Message_ContactType @"Message_ContactType"
#define Message_ContactSex @"Message_ContactSex"
#define Message_Type @"Message_Type"
#define Message_IsRead @"Message_IsRead"
#define Message_IsSendSuccess @"Message_IsSendSuccess"
#define Message_IsVoiceRead @"Message_IsVoiceRead"
#define Message_IsDelete @"Message_IsDelete"
#define Message_IsDownloadSuccess @"Message_IsDownloadSuccess" //语音下载是否成功标志
#define Message_IsGroupDelete @"Message_IsGroupDelete" //以组为单位的删除，主要用于信息的列表页
#define Message_UserAnnear @"Message_UserAnner" // 家务号


#pragma mark ----系统消息表
#define SYSTEMMESSAGE @"SYSTEMMESSAGE"
#define SysTemMessage_ID @"SysTemMessage_ID"
#define SysTemMessage_Message @"SysTemMessage_Message"
#define SysTemMessage_Time @"SysTemMessage_Time"
#define SysTemMessage_ReqGuid @"SysTemMessage_ReqGuid"
#define SysTemMessage_ReqType @"SysTemMessage_ReqType"
#define SysTemMessage_IsRead @"StsTemMessage_IsRed"


#pragma mark ---- 个人信息相关表

#define TBL_MSG_CONTACTINFO @"TBL_Msg_ContactInfo"

#define Msg_ContactGuid @"Msg_ContactGuid"
#define Msg_ContactRealName @"Msg_ContactRealName"
#define Msg_ContactSex @"Msg_ContactSex"
#define Msg_ContactPhoto @"Msg_ContactPhoto"


#pragma mark ----- 生活小贴士
#define TBL_LIFETIPS @"TBL_lifeTips"

#define LifeTips_ID @"LifeTips_ID"
#define LifeTips_Guid @"LifeTips_Guid"
#define LifeTips_Content @"LifeTips_Content"
#define LifeTips_ContentImage @"LifeTips_ContentImage"
#define LifeTips_Time @"LifeTips_Time"
#define LifeTips_Title @"LifeTips_Title"
#define LifeTips_TimeStamp @"LifeTips_TimeStamp"
#define LifeTips_IsRead @"LifeTips_IsRead"

#pragma mark --- 小贴士时间戳
#define TBL_TIMESTAMP @"TBL_TimeStamp"

#define TimeStamp_LifeTips @"TimeStamp_LifeTips"


#pragma mark ----- 统计电话
#define TBL_Phone @"TBL_Phone"

#define Phone_ID @"Phone_ID"
#define Phone_MyGuid @"Phone_MyGuid"
#define Phone_YourGuid @"Phone_YourGuid"
#define Phone_Number @"Phone_Number"
#define Phone_Time @"Phone_Time"



#endif
