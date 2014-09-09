//
//  MessageVC.h
//  MessageMVC
//
//  Created by liu on 14-5-26.
//  Copyright (c) 2014年 刘美超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageView.h"
#import "Ty_Message_Busine.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "LongPressGestureDelegate.h"


@class MessageCell;

@interface MessageVC : TYBaseView<AVAudioRecorderDelegate,AVAudioPlayerDelegate,LongPressGestureDelegate,UIAlertViewDelegate>
{
    MessageView *_messageView;
    
    Ty_Message_Busine *_messageBusine;
    
    BOOL _isKeyoardShow;
    
    NSInteger _currentPageNum;
    
    NSString *_contactPhotoUrl;//联系人头像，因为收到消息时，直接add到数组，并没有走数据库查询，所以没有头像地址
    
    //以下与录音有关
    AVAudioRecorder *_audioRecorder;
    NSTimer *_timer;
    NSString *_voiceGuidStr;

    AVAudioPlayer *_audioPlayer;
    
    NSTimer *_playVoiceTimer;
    
    //用于保存之前的cell及info信息
    MessageCell *_oldMessageCell;
    Ty_Model_MessageInfo *_oldMessageInfo;
    
    Ty_Model_MessageInfo *_failMessageInfo;
    
    //pageNum
    NSInteger _pageNum;
    
    //复制的内容保存的字符串
    NSString *_pasteboardStr;
    

}

//调用此页面需传的参数
@property (nonatomic,strong) NSString *contactGuid;

/**(与contactJIDName 二选一)用户名,用来设置xmpp登录名*/
@property (nonatomic,strong) NSString *contactName;

/**(必须项)真实姓名,显示于聊天页面的title栏*/
@property (nonatomic,strong) NSString *contactRealName;

/**(必须项)用来标识中介及普通用户 0:中介 1:非中介*/
@property (nonatomic,assign) int contactType;

/**(必须项)联系人性别 0:男  1:女*   中介可不写*/
@property (nonatomic,assign) int contactSex;


/**
 *  (必须项)联系人家务号
 */
@property (nonatomic,strong) NSString *contactAnnear;

//可选
/**(与contactName 二选一)xmpp登录名：xxx_family xxx为用户名*/
@property (nonatomic,strong) NSString *contactJIDName;

@property (nonatomic,strong) NSString *contactImg;
/*********************************参数结束*******************************/


/**
 *  文字与语音切换按钮触发的事件
 */
- (void)changeMessageStatus;

/**
 *  发送文字信息
 *
 *  @param message 文字内容
 */
- (void)sendMessage:(NSString *)message;

//录音相关
- (void)startRecord;
- (void)recordEnd;

/**
 *  录音的准备工作
 */
- (void)prepareCancelRecord;
- (void)continueRecord;


- (void)playVoice:(MessageCell *)cell indexRow:(int)row;

- (void)sendFailMessageAgain:(Ty_Model_MessageInfo *)messageInfo;

- (void)getMoreData;

@end
