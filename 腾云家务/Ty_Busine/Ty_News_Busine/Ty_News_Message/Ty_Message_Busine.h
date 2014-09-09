//
//  Ty_Message_Busine.h
//  腾云家务
//
//  Created by liu on 14-6-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ty_Model_MessageInfo;

@interface Ty_Message_Busine : NSObject


@property (nonatomic,strong) NSMutableArray *messageArr;


/**
 *  以分页的方式查找与某个人的信息
 *
 *  @param contactGuid 联系人guid
 *  @param pageNum     当前页
 */
- (void)selectMessageDataFromTableByContactGuid:(NSString *)contactGuid pageNum:(int)pageNum;


/**
 *  查找下载失败的语音信息，以便再次下载
 *
 *  @param array 存放失败语音的数组
 */
- (void)selectDownloadFailedVoice:(NSMutableArray *)array;


/**
 *  插数据到信息表
 *
 *  @param messageInfo 数据源
 */
- (void)insertMessageIntoTable:(Ty_Model_MessageInfo *)messageInfo;


/**
 *  将信息的发送状态置为“0”——发送失败
 *
 *  @param messageGuid 信息guid
 */

- (void)updateMessageSendStatusByMessageGuid:(NSString *)messageGuid;


- (void)updateMessageSendStatusSuccessByMessageGuid:(NSString *)messageGuid;

/**
 *  将与某个联系人相关的消息都置为已读
 *
 *  @param contactGuid 联系人guid
 */
- (void)updateMessageReadStatusByContactGuid:(NSString *)contactGuid;


/**
 *  将语音消息置为已读状态
 *
 *  @param messageGuid 信息guid
 */
- (void)updateVoiceReadStatusByMessageGuid:(NSString *)messageGuid;


/**
 *  发送语音到服务器
 *
 *  @param messageInfo 语音信息
 */

- (void)sendVoiceMessageToService:(Ty_Model_MessageInfo *)messageInfo;


/**
 *  下载语音信息
 *
 *  @param messageInfo 语音信息（主要是存数据库时用）
 */
- (void)downLoadVoiceMessage:(Ty_Model_MessageInfo *)messageInfo;



@end
